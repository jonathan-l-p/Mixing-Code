! module to find quantities of interest while stepping in the x direction
! uses global module
! uses realprecision module
! uses dimensions module
! uses CleanScheme module
! uses properites module
module primarycalcs
  use global
  use realprecision
  use dimensions
  use CleanScheme
  use properties
  implicit none
  integer :: n1, n2, n3, n4, n5, n6, n_fine
  real(dp) :: DOY1_Temp, DOY2_Temp, Ank_temp, c_temp

  contains
    subroutine compScheme()
      ! solve for composition Y1 and Y2 in the next x position along all y
      do n1 = 2, (Ny - 1)
        ! Y1
        DOY1_Temp = DO_CentralY(Y1(n1+1,k), Y1(n1-1,k))
        DOY2_Temp = DO_CentralY2_mu(Y1(n1+1,k), Y1(n1,k), Y1(n1-1,k), n1)
        Ank_Temp = 0.d0 ! A = 0,
        c_temp = 1.d0/Pr ! c = 1/Pr

        Y1(n1,k+1) = VARnkp1(Y1(n1,k), DOY1_Temp, DOY2_Temp, Ank_Temp, c_temp, &
        n1)

        ! Y2
        DOY1_Temp = DO_CentralY(Y2(n1+1,k), Y2(n1-1,k))
        DOY2_Temp = DO_CentralY2_mu(Y2(n1+1,k), Y2(n1,k), Y2(n1-1,k), n1)
        Ank_Temp = 0.d0 ! A = 0,
        c_temp = 1.d0/Pr ! c = 1/Pr

        Y2(n1,k+1) = VARnkp1(Y2(n1,k), DOY1_Temp, DOY2_Temp, Ank_Temp, c_temp, &
        n1)

        ! stop computations if either Y is negative
        if ((Y1(n1,k+1) < 0.d0) .or. (Y2(n1,k+1) < 0.d0)) then
          BreakLoop = .true.
          exit
        end if
      end do
    end subroutine compScheme

    subroutine hStarScheme()
      ! solve for enthalpy in the next x position along all y
      do n2 = 2, (Ny - 1)
        ! solve for h
        DOY1_Temp = DO_CentralY(hStar(n2+1,k), hStar(n2-1,k))
        DOY2_Temp = DO_CentralY2_mu(hStar(n2+1,k), hStar(n2,k), &
        hStar(n2-1,k), n2)
        Ank_Temp = 0.d0 ! no reaction
        c_temp = 1.d0/Pr ! c = 1/Pr

        hStar(n2,k+1) = VARnkp1(hStar(n2,k), DOY1_Temp, &
        DOY2_Temp, Ank_Temp, c_temp, n2)
      end do
    end subroutine hStarScheme

    subroutine uStarScheme()
      ! solve for u in the next x position along all y
      do n3 = 2, (Ny - 1)
        DOY1_Temp = DO_CentralY(uStar(n3+1,k), uStar(n3-1,k))
        DOY2_Temp = DO_CentralY2_mu(uStar(n3+1,k), uStar(n3,k), uStar(n3-1,k), &
        n3)
        Ank_Temp = 0.d0 ! A = 0,
        c_temp = 1.d0 ! c = 1

        uStar(n3,k+1) = VARnkp1(uStar(n3,k), DOY1_Temp, DOY2_Temp, Ank_Temp, &
        c_temp, n3)
      end do
    end subroutine uStarScheme

    subroutine vStarScheme()
      ! solve for v in the next x position along all y
      ! we already know v at y = 0

      ! first travel upward from y = 0
      do n4 = ceiling(real(Ny)/2.d0), 2, -1
        ! delta_y_Star terms should be preceded by a - because we are travelling upward
        vStar(n4-1,k+1) = vStar(n4,k+1) &
        - ((-delta_y_Star/rhoStar(n4,k))*(((uStar(n4,k)/delta_x_Star)&
        *(rhoStar(n4,k+1)-rhoStar(n4,k))) &
        + ((rhoStar(n4,k)/delta_x_Star)*(uStar(n4,k+1)-uStar(n4,k))) &
        + ((vStar(n4,k)/(-2.d0*delta_y_Star))&
        *(rhoStar(n4+1,k+1)-rhoStar(n4-1,k+1))) &
        + (strain_ratio*rhoStar(n4,k)*kappaStar(n4,k))))
      end do

      ! then travel downward from y = 0
      do n5 = ceiling(real(Ny)/2.d0), (Ny - 1)
        vStar(n5+1,k+1) = vStar(n5,k+1) &
        - ((delta_y_Star/rhoStar(n5,k))*(((uStar(n5,k)/delta_x_Star)&
        *(rhoStar(n5,k+1)-rhoStar(n5,k))) &
        + ((rhoStar(n5,k)/delta_x_Star)*(uStar(n5,k+1)-uStar(n5,k))) &
        + ((vStar(n5,k)/(2.d0*delta_y_Star))&
        *(rhoStar(n5+1,k+1)-rhoStar(n5-1,k+1))) &
        + (strain_ratio*rhoStar(n5,k)*kappaStar(n5,k))))
      end do
    end subroutine vStarScheme

    subroutine kappaStarScheme()
      do n6 = 2, (Ny - 1)
        DOY1_Temp = DO_CentralY(kappaStar(n6+1,k), kappaStar(n6-1,k))
        DOY2_Temp = DO_CentralY2_mu(kappaStar(n6+1,k), kappaStar(n6,k), &
        kappaStar(n6-1,k), n6)
        Ank_Temp = (strain_ratio*rhoStar(n6,k)*(kappaStar(n6,k)**2)) &
        - ((strain_ratio)*(fStar(1,k)**2)) ! kappaStar(1,k) = \kappa*_{\infinity}(x)
        ! Ank_Temp = 0.d0
        c_temp = 1.d0 ! c = 1
        ! - - - - - -
        Ank_kappa(n6,k) = Ank_Temp
        ! - - - - - -

        kappaStar(n6,k+1) = VARnkp1(kappaStar(n6,k), DOY1_Temp, DOY2_Temp, &
        Ank_Temp, c_temp, n6)
      end do

      ! y = H zero first and second derivative BC
      kappaStar(1,k+1) = kappaStar(2,k+1)

      ! y = -H zero first and second derivative BC
      kappaStar(Ny,k+1) = kappaStar(Ny-1,k+1)

    end subroutine kappaStarScheme

    subroutine sourceTermOperatorScheme()
      do n_fine = 1, Ny ! should the source term change the free streams?
        ! new parameters
        hStar_fine(n_fine,k_fine+1) = ( (-Q1*ReactionRate2_fine(n_fine,k_fine) &
        /uStar(n_fine,k)) * delta_x_Star_fine ) + hStar_fine(n_fine,k_fine)

        ! Y1_fine(n_fine,k_fine+1) = ( (ReactionRate2_fine(n_fine,k_fine) &
        ! /(uStar(n_fine,k) * nu)) * delta_x_Star_fine ) + Y1_fine(n_fine,k_fine)
        !
        ! Y2_fine(n_fine,k_fine+1) = ( (ReactionRate2_fine(n_fine,k_fine) &
        ! /(uStar(n_fine,k) )) * delta_x_Star_fine ) + Y2_fine(n_fine,k_fine)

        Y1_fine(n_fine,k_fine+1) = Y1(n_fine,k)
        Y2_fine(n_fine,k_fine+1) = Y2(n_fine,k)

        ! if (Y1_fine(n_fine,k_fine+1) < 0.0d0) then
        !   Y1_fine(n_fine,k_fine+1) = 0.0d0
        ! endif
        !
        ! if (Y2_fine(n_fine,k_fine+1) < 0.0d0) then
        !   Y2_fine(n_fine,k_fine+1) = 0.0d0
        ! endif

        ! update parameters
        T_fine(n_fine,k_fine+1) = findTemp(hStar_fine(n_fine,k_fine+1))

        rhoStar_fine(n_fine,k_fine+1) = findRhoStar(T_fine(n_fine,k_fine+1), &
        Y1_fine(n_fine,k_fine+1),Y2_fine(n_fine,k_fine+1))

        muStar_fine(n_fine,k_fine+1) = findCombMu(Y1_fine(n_fine,k_fine+1) , &
        findMu(T_fine(n_fine,k_fine+1),Tcrit1,Vcrit1,W1) , &
        Y2(n_fine,k_fine+1) , &
        findMu(T_fine(n_fine,k_fine+1),Tcrit2,Vcrit2,W2) ) / muHp

        ReactionRate2_fine(n_fine,k_fine+1) = &
        findReactionRateFuel(rhoStar_fine(n_fine,k_fine+1), &
        Y1_fine(n_fine,k_fine+1), Y2_fine(n_fine,k_fine+1), &
        hStar_fine(n_fine,k_fine+1))
      end do
    end subroutine sourceTermOperatorScheme

end module primarycalcs
