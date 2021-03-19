! module to simplify the expression of conductive/advective and diffusive equations
! uses global module
! uses realprecision module
module CleanScheme
  use global
  use realprecision
  real(dp) :: munm1hStar ! muStar(n-(1/2),k)
  real(dp) :: munp1hStar ! muStar(n+(1/2),k)

  contains
    ! function to simplify the evaluation of the central differential operator
    ! in y
    ! ASSUMING COMPUTATIONS ARE FOR NORMALIZED EQUATIONS
    real(dp) function DO_CentralY(np1k, nm1k)
      real(dp), intent(in) :: np1k ! var(n+1,k)
      real(dp), intent(in) :: nm1k ! var(n-1,k)

      DO_CentralY = (np1k - nm1k)/(2.d0*delta_y_Star)
    end function DO_CentralY

    ! function to simplify the evaluation of the second central differential
    ! operator in y using a hybrid discretized mu value
    ! ASSUMING COMPUTATIONS ARE FOR NORMALIZED EQUATIONS
    real(dp) function DO_CentralY2_mu(np1k, nk, nm1k, n)
      real(dp), intent(in) :: np1k ! var(n+1,k)
      real(dp), intent(in) :: nk ! var(n,k)
      real(dp), intent(in) :: nm1k ! var(n-1,k)
      integer, intent(in) :: n

      ! munm1hStar = (muStar(n-1,k) + muStar(n,k))/2.d0
      ! munp1hStar = (muStar(n+1,k) + muStar(n,k))/2.d0

      ! DO_CentralY2_mu = ((munp1hStar*np1k) - ((munp1hStar+munm1hStar)*nk)&
      !  + (munm1hStar*nm1k))/(delta_y_Star**2)

      DO_CentralY2_mu = (1/(2.d0*(delta_y_Star**2)))&
      *( ((muStar(n+1,k) + muStar(n,k))*(np1k - nk)) &
      - ((muStar(n,k) + muStar(n-1,k))*(nk - nm1k)) )
    end function DO_CentralY2_mu

    ! function to simplify the evaluation of VAR(n,k+1)
    ! ASSUMING COMPUTATIONS ARE FOR NORMALIZED EQUATIONS
    real(dp) function VARnkp1(VARnk, DOY1, DOY2, Ank, c, n)
      real(dp), intent(in) :: VARnk ! var(n,k)
      real(dp), intent(in) :: DOY1 ! DO_CentralY
      real(dp), intent(in) :: DOY2 ! DO_CentralY2_mu
      real(dp), intent(in) :: Ank ! A(n,k)
      real(dp), intent(in) :: c ! constant in front of DO_CentralY2_mu
      integer, intent(in) :: n

      VARnkp1 = VARnk &
       + ((delta_x_Star/(rhoStar(n,k)*uStar(n,k)))*((c*DOY2)&
        - (rhoStar(n,k)*vStar(n,k)*DOY1) - Ank))
    end function VARnkp1

end module CleanScheme
