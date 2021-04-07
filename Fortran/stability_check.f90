! module to check if the intended domain is stable
! uses global module
! uses dimensions module
module stable
  use global
  use dimensions
  implicit none
  real(dp) :: test

contains
  subroutine stability_check()
    if (delta_x_Star <= 0.5d0*(delta_y_Star**2)) then
      print*,'The finite difference scheme is stable.'
    else
      print*,'The finite difference scheme is unstable'
      print*,'There should be at least', &
      ((Ny-1)**2)/(2.d0*(F**2)) + 1.d0 &
      ,'sample points for x.'
      StableDomain = .false.
    endif
    print*
  end subroutine stability_check
end module stable
