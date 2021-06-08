! module for all affairs relating to dimensionality
! uses real precision module
! uses global module
! uses properties module
module dimensions
  use realprecision
  use global
  use properties
  implicit none
    integer :: i

  contains

    ! subroutine to update values of non-dimensionless arrays
    subroutine updateDomain()
      real(dp) :: mu1temp
      real(dp) :: mu2temp

      do i = 2,Ny-1
        ! VERY IMPORTANT UPDATES
        T(i,k+1) = findTemp(cp,hStar(i,k+1))

        mu1temp = findMu(T(i,k+1),Tcrit1,Vcrit1,W1)
        mu2temp = findMu(T(i,k+1),Tcrit2,Vcrit2,W2)
        mu(i,k+1) = findCombMu(Y1(i,k+1),mu1temp,Y2(i,k+1),mu2temp)
        muStar(i,k+1) = mu(i,k+1)/muHp

        rhoStar(i,k+1) = findRhoStar(T(i,k+1),Y1(i,k+1),Y2(i,k+1))
      end do
    end subroutine updateDomain

end module dimensions
