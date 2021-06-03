program mixing
  use realprecision
  use math
  use SigVars
  use global
  use meshgen
  use properties
  use IBconditions
  use dimensions
  use stable
  use CleanScheme
  use primarycalcs
  use binwrite
  implicit none

  print*,'-----------------------------'
  print*,'Fluid Mixing Code'
  print*,'by Jonathan Palafoutas (2021)'
  print*,'-----------------------------'
  print*

  ! SETUP ----------------------------------------------------------------------
  ! find delta_x_Star and delta_y_Star based on domain size and # of samples
  delta_x_Star = 1.d0/(Nx - 1) ! delta_x / L
  delta_y_Star = -2.d0*F/(Ny-1) ! /sqrt{Re} delta_y / L
  delta_x_Star_fine = delta_x_Star/float(Nx_fine)

  ! check if the proposed domain is stable
  call stability_check()

  ! generate mesh
  call meshgenStarxy()

  ! apply initial and boundary velocities to U
  call applyIBu()
  ! no need for applyIBV() because v is 0 at x = 0 and y = 0

  ! apply initial and boundary enthalpy to Enthalpy and EnthalpyStar
  call applyIBh()

  ! apply initial and boundary compositions to Y1 and Y2
  call applyIBComp()

  ! apply initial and boundary temperatures to T
  call applyIBTemp()

  ! apply initial viscosity to Mu
  call applyIBmu()

  ! apply initial and boundary density to /rho*
  call applyIBrho()

  ! apply initial and boundary kappa to kappaStar
  call applyIBkappa()

  ! apply initial and boundary reaction rate of
  call applyIBReactionRate2()

  ! apply boundary conditions to temperary arrays
  ! call applyIBtemporaryArrays()

  ! the domain is now up-to-date with initial and boundary conditions (except for
  ! the kappa boundaries, which we will calculate in the main loop)
  print*,'Set up computational domain with initial and boundary conditions'
  print*

  ! PRIMARY CALCULATIONS -------------------------------------------------------
  ! MAIN LOOP
  print*, 'Beginning main loop calculations ...'
  print*

  if (BuildMain .eqv. .true.) then
    do k = 1, (Nx-1) ! take a step in x
      ! we have all the information we need to find Y1, Y2, hstar, and ustar
      call compScheme()

      if (BreakLoop .eqv. .true.) then
        print*,'Calculations failed at k =', k
        print*
        exit
      end if

      call hStarScheme() ! mechanical operator
      call uStarScheme()
      call kappaStarScheme()

      ! new vstar needs new density so we must update density at x + delta_x
      ! update domain quantities
      call updateDomain()

      ! now we can update vstar
      call vStarScheme()

      ! FINE CALCULATIONS FOR SOURCE TERM
      ! our hStar is calculated according to the mechanical operator
      ! now let's calculate it according to the source term operator
      ! Questions:
      !   should i update free stream?
      !   do mass fractionw weighted quantities change now that we have reactants

      ! initialize fine array as the current value in the course array
      ReactionRate2_fine(:,1) = ReactionRate2(:,k)
      ! hStar_fine(:,1) = hStar(:,k)
      ! Y1_fine(:,1) = Y1(:,k)
      ! Y2_fine(:,1) = Y2(:,k)
      T_fine(:,1) = T(:,k)
      rhoStar_fine(:,1) = rhoStar(:,k)

     do k_fine = 1, Nx_fine
       call sourceTermOperatorScheme()
     end do

     ! include source term contributions
     Y1(:,k+1) = Y1(:,k+1) + Y1_fine(:,Nx_fine)
     Y2(:,k+1) = Y2(:,k+1) + Y2_fine(:,Nx_fine)
     hStar(:,k+1) = hStar(:,k+1) + hStar_fine(:,Nx_fine)
     T(:,k+1) = T(:,k+1) + T_fine(:,Nx_fine)
     rhoStar(:,k+1) = rhoStar(:,k+1) + rhoStar_fine(:,Nx_fine)

     ! print update
     if (mod(k,100) == 0) then
       print*, 'k = ',k
     endif
    end do

    print*
    print*,'Completed main loop calculations'
    print*
  end if

  ! Calculate Sirignano variables ----------------------------------------------
  ! call calculate_ybar()
  ! call calculate_g_of_x()
  ! call calculate_eta()
  ! call calculate_G_of_eta()
  ! call calculate_E()
  !
  ! print*,'Completed calculations of Sirignano variables'
  ! print*

  ! EXPORT ---------------------------------------------------------------------
  ! write data to binary files in order to analyze in other programs
  call binwritef(Y1,'out_Y1.bin')
  call binwritef(Y2,'out_Y2.bin')
  call binwritef(fStar,'out_fStar.bin')
  call binwritef(hStar,'out_hStar.bin')
  call binwritef(kappaStar,'out_kappaStar.bin')
  call binwritef(mu,'out_mu.bin')
  call binwritef(muStar,'out_muStar.bin')
  call binwritef(rhoStar,'out_rhoStar.bin')
  call binwritef(T,'out_T.bin')
  call binwritef(uStar,'out_uStar.bin')
  call binwritef(vStar,'out_vStar.bin')
  call binwritef(XStar,'out_XStar.bin')
  call binwritef(YStar,'out_YStar.bin')
  call binwritef(Y1,'out_Y1.bin')
  call binwritef(Y2,'out_Y2.bin')
  call binwritef_int(Nx_ARRAY,'out_Nx.bin')
  call binwritef_int(Ny_ARRAY,'out_Ny.bin')

  call binwritef(ReactionRate2,'out_ReactionRate2.bin')

  call binwritef(ybar,'out_ybar.bin')
  call binwritef(g_of_x,'out_g_of_x.bin')
  call binwritef(eta,'out_eta.bin')
  call binwritef(G_of_eta,'out_G_of_eta.bin')
  call binwritef(E,'out_E.bin')

  ! VARIABLE SAVES - - - - - - -
  VarSave(2,1) = delta_x_Star
  VarSave(3,1) = delta_y_Star
  VarSave(4,1) = FSR_kappa
  VarSave(5,1) = strain_ratio
  VarSave(6,1) = x0ind
  VarSave(7,1) = FSR_U
  VarSave(8,1) = FSR_h
  VarSave(9,1) = Pr
  VarSave(10,1) = Da
  call binwritef(VarSave,'out_VarSave.bin')

  print*,'Wrote output arrays to .bin files'
  print*

end program mixing
