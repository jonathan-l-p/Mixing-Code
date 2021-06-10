! module to find quantities of interest while stepping in the x direction
! uses global module
! uses realprecision module
! uses dimensions module
! uses CleanScheme module
module primarycalcs2
  use global
  use realprecision
  use dimensions
  use CleanScheme
  implicit none
  integer :: n, n, n2, n3, n4, n5, n6, n_fine
  real(dp) :: DOY1_Temp, DOY2_Temp, Ank_temp, c_temp

  contains
    real(dp) function Delta_Y1_mixing()
      ! solve for composition Y1 and Y2 in the next x position along all y
      do n = 2, (Ny - 1)
        ! Y1
        DOY1_Temp = DO_CentralY(Y1(n+1,k), Y1(n-1,k))
        DOY2_Temp = DO_CentralY2_mu(Y1(n+1,k), Y1(n,k), Y1(n-1,k), n)
        Ank_Temp = 0.d0 ! A = 0,
        c_temp = 1.d0/Pr ! c = 1/Pr

        Y1(n,k+1) = Delta_VARnkp1(Y1(n,k), DOY1_Temp, DOY2_Temp, Ank_Temp, c_temp, &
        n)

        ! stop computations if either Y is negative
        if ((Y1(n,k+1) < 0.d0) .or. (Y2(n,k+1) < 0.d0)) then
          BreakLoop = .true.
          exit
        end if
      end do
    end function Delta_Y1_mixing

    real(dp) function Delta_Y2_mixing()
      ! solve for composition Y1 and Y2 in the next x position along all y
      do n = 2, (Ny - 1)
        ! Y1
        DOY1_Temp = DO_CentralY(Y2(n+1,k), Y2(n-1,k))
        DOY2_Temp = DO_CentralY2_mu(Y2(n+1,k), Y2(n,k), Y2(n-1,k), n)
        Ank_Temp = 0.d0 ! A = 0,
        c_temp = 1.d0/Pr ! c = 1/Pr

        Y2(n,k+1) = Delta_VARnkp1(Y2(n,k), DOY1_Temp, DOY2_Temp, Ank_Temp, c_temp, &
        n)

        ! stop computations if either Y is negative
        if ((Y1(n,k+1) < 0.d0) .or. (Y2(n,k+1) < 0.d0)) then
          BreakLoop = .true.
          exit
        end if
      end do
    end function Delta_Y2_mixing

    subroutine Delta_h_mixing()
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
    end subroutine Delta_h_mixing

    ! subroutine sourceTermOperatorScheme()
    !   do n_fine = 1, Ny ! should the source term change the free streams?
    !     ! new parameters
    !     hStar_fine(n_fine,k_fine+1) = ( (Q1*ReactionRate2_fine(n_fine,k_fine) &
    !     /uStar(n_fine,k)) * delta_x_Star_fine ) + hStar_fine(n_fine,k_fine)
    !
    !     Y1_fine(n_fine,k_fine+1) = ( (ReactionRate2_fine(n_fine,k_fine) &
    !     /(uStar(n_fine,k) * nu)) * delta_x_Star_fine ) + Y1_fine(n_fine,k_fine)
    !
    !     Y2_fine(n_fine,k_fine+1) = ( (ReactionRate2_fine(n_fine,k_fine) &
    !     /uStar(n_fine,k)) * delta_x_Star_fine ) + Y2_fine(n_fine,k_fine)
    !
    !     ! update parameters
    !     T_fine(n_fine,k_fine+1) = findTemp(cp,hStar_fine(n_fine,k_fine+1))
    !
    !     rhoStar_fine(n_fine,k_fine+1) = findRhoStar(T_fine(n_fine,k_fine+1), &
    !     Y1_fine(n_fine,k_fine+1),Y2_fine(n_fine,k_fine+1))
    !
    !     ReactionRate2_fine(n_fine,k_fine+1) = &
    !     findReactionRateFuel(rhoStar_fine(n_fine,k_fine+1), &
    !     Y1_fine(n_fine,k_fine+1), Y2_fine(n_fine,k_fine+1), &
    !     hStar_fine(n_fine,k_fine+1))
    !   end do
    ! end subroutine sourceTermOperatorScheme

end module primarycalcs2
