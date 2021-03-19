! module to check if the intended domain is stable
! uses global module
! uses dimensions module
module stable
  use global
  use dimensions
  implicit none
  real(dp) :: test

contains
  ! subroutine stability_check()
  !   if (delta_x <= (RhoHP*(delta_y**2))/(2.d0*MuHP)) then
  !     print*,'The finite difference scheme is stable.'
  !   else
  !     print*,'The finite difference scheme is unstable'
  !     print*,'There should be at least', &
  !     MuHP*L*((Ny-1)**2)/(2.d0*RhoHP*(h**2)) + 1.d0 &
  !     ,'sample points for x.'
  !   endif
  !   print*
  ! end subroutine stability_check

  ! ! a normalized and less specific version of stability_check
  ! subroutine stability_check2()
  !   if (delta_x <= (RhoHP*(delta_y**2))/(2.d0*MuHP)) then
  !     print*,'The finite difference scheme is stable.'
  !   else
  !     print*,'The finite difference scheme is unstable'
  !     print*,'There should be at least', &
  !     MuHP*L*((Ny-1)**2)/(2.d0*RhoHP*(h**2)) + 1.d0 &
  !     ,'sample points for x.'
  !   endif
  !   print*
  ! end subroutine stability_check2

end module stable
