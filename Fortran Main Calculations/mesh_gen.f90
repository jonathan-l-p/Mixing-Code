! module to discretize the domain into a mesh of x and y values
! uses realprecision module
! uses global module
module meshgen
  use realprecision
  use global
  implicit none
  integer :: i, j

contains
  ! subroutine meshgenxy()
  !   ! create x and y vectors
  !   do i = 2, Nx
  !     xvector(i) = xvector(i-1) + delta_x
  !   end do
  !
  !   yvector(1) = h
  !   do i = 2, Ny
  !     yvector(i) = yvector(i-1) + delta_y
  !   end do
  !
  !   ! create a meshgrid of x and y values
  !   do i = 1, Ny
  !     do j = 1, Nx
  !       X(i,j) = xvector(j)
  !     end do
  !   end do
  !
  !   do j = 1, Nx
  !     do i = 1, Ny
  !       Y(i,j) = yvector(i)
  !     end do
  !   end do
  !
  !   ! we can find nondimensional X and Y
  !   XStar = (1.d0/L)*X
  !   YStar = (sqrt(ReHP)/L)*Y
  !
  !   print*,'Mesh generation is done!'
  !   print*
  !
  ! end subroutine meshgenxy

  subroutine meshgenStarxy()
    ! create x and y vectors
    do i = 2, Nx
      xvectorStar(i) = xvectorStar(i-1) + delta_x_Star
    end do

    yvectorStar(1) = F
    do i = 2, Ny
      yvectorStar(i) = yvectorStar(i-1) + delta_y_Star
    end do

    ! create a meshgrid of x and y values
    do i = 1, Ny
      do j = 1, Nx
        XStar(i,j) = xvectorStar(j)
      end do
    end do

    do j = 1, Nx
      do i = 1, Ny
        YStar(i,j) = yvectorStar(i)
      end do
    end do
  end subroutine meshgenStarxy

end module meshgen
