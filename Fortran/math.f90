! module to contain mathematical functions or processes that are not already defined
! uses realprecision module
module math
  use realprecision
  implicit none

  contains
    ! a function to apply the trapezoidal rule to a set of vectors in order to
    ! approximate the area under the curve of one over the other
    real(dp) function trap(vec_x, vec_f_of_x)
      integer :: i ! loop index
      real(dp), intent(in) :: vec_x(:), vec_f_of_x(:)
      real(dp) :: b ! temportary base of trapezoid
      real(dp) :: h1 ! temporary height of side 1 of trapezoid
      real(dp) :: h2 ! temporary height of side 1 of trapezoid

      trap = 0.d0 ! initialize the trapezoidal sum

      do i = 1,(size(vec_x)-1)
        b = vec_x(i+1) - vec_x(i)
        h1 = vec_f_of_x(i)
        h2 = vec_f_of_x(i+1)

        trap = trap + 0.5d0*b*(h1+h2)
      end do
    end function trap
end module math
