! a module to write data to a binary file
! uses realprecision module
module binwrite
  use realprecision
  implicit none

  contains
    subroutine binwritef(A,filename)
      character(len=*), intent(in) :: filename
      real(dp), intent(in) :: A(:,:)

      open(unit=100,file=SavePath//filename,status='replace',access='stream',&
      form='unformatted')
      write(100)A
    end subroutine binwritef

    subroutine binwritef_int(A,filename)
      character(len=*), intent(in) :: filename
      integer, intent(in) :: A(:,:)

      open(unit=100,file=filename,status='replace',access='stream',&
      form='unformatted')
      write(100)A
    end subroutine binwritef_int

end module binwrite
