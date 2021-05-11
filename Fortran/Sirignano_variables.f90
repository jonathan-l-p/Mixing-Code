! module to calculate the variables used by Sirignano
! uses realprecision module
! uses math module
! uses global module
module SigVars
  use realprecision
  use math
  use global
  implicit none
  integer :: i ! loop index
  integer :: j ! loop index

  contains
    subroutine calculate_ybar()
      ! ybar is defined as the integral from 0 to y of the product of rho and y
      do j = 1,Nx
        do i = 1,floor(real(Ny)/2.d0)
          ybar(i,j) = trap(YStar(ceiling(real(Ny)/2.d0):i:-1 , j), &
            rhoStar(ceiling(real(Ny)/2.d0):i:-1 , j))
        end do

        do i = (ceiling(real(Ny)/2.d0)+1),Ny
          ybar(i,j) = trap(YStar(ceiling(real(Ny)/2.d0):i , j), &
            rhoStar(ceiling(real(Ny)/2.d0):i , j))
        end do
      end do
    end subroutine calculate_ybar

    subroutine calculate_g_of_x()
      g_of_x = sqrt(2.d0*XStar)
    end subroutine calculate_g_of_x

    subroutine calculate_eta()
      eta = ybar/g_of_x
      ! CAUTION: eta will be inf at x=0
    end subroutine calculate_eta

    ! subroutine calculate_G_of_eta()
    !   G_of_eta = 2.d0*strain_ratio*kappaStar*XStar
    ! end subroutine calculate_G_of_eta
    !
    ! subroutine calculate_E()
    !   ! E is defined as the integral from 0 to eta of the product of G and eta
    !   do j = 1,Nx
    !     do i = 1,floor(real(Ny)/2.d0)
    !       E(i,j) = trap(eta(ceiling(real(Ny)/2.d0):i:-1 , j), &
    !         G_of_eta(ceiling(real(Ny)/2.d0):i:-1 , j))
    !     end do
    !
    !     do i = (ceiling(real(Ny)/2.d0)+1),Ny
    !       E(i,j) = trap(eta(ceiling(real(Ny)/2.d0):i , j), &
    !         G_of_eta(ceiling(real(Ny)/2.d0):i , j))
    !     end do
    !   end do
    ! end subroutine calculate_E
    !
    ! subroutine calculate_Alpha()
    !   Alpha = Y2 - (nu*Y1)
    ! end subroutine calculate_Alpha
    !
    ! subroutine calculate_Beta()
    ! end subroutine calculate_Beta

end module SigVars
