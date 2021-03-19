! module to define precision of real variables
module realprecision
  implicit none
  integer, parameter :: dp = kind(0.d0)
  integer, parameter :: sp = selected_real_kind(P=5,R=15)
  integer, parameter :: dp_alt = kind(0.d0)

  public :: dp,sp,dp_alt,print_kind_info
  private

  contains
    ! routine to print information about the kinds being used
    subroutine print_kind_info()
      real(sp) :: pi_single
      real(dp) :: pi_double
      print*,'double precision is kind=',dp
      print*,'single precision is kind=',sp
      print*,'kind of a double precision number is',dp_alt
      pi_single = 4.0_sp*atan(1.0_sp)
      pi_double = 4.0_dp*atan(1.0_dp)
      print*,'pi in single precision is',pi_single
      print*,'pi in double precision is',pi_double
      ! see what happens if we accidentally mix precisions
      pi_double = pi_single
      print*,'pi converted from single is =',pi_double
    end subroutine print_kind_info

end module realprecision
