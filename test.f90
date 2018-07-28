!======================================================================
! for test
!----------------------------------------------------------------------
program main
  use mod_prcptr
  implicit none

  type(perceptron) myperceptron
  double precision,allocatable :: mydata(:)
  double precision :: yi

  integer :: nnn = 1

  integer :: HANDLE_EOF = 1000

  integer :: i
  logical :: answered_error
  integer :: n_errors

  allocate(mydata(2))

  myperceptron = perceptron(2,1d-2)

  write(6,*) myperceptron%w

  open(221,file="mydata.txt")
  open(223,file="errors.log",status="replace")
  write(223,*) "#i errors"

  do i=1,1000
     n_errors=0
     do
        write(6,*) nnn
        read(221,*,end=1000) mydata(1),mydata(2),yi
!        write(6,*) mydata,yi
        call myperceptron%learn(mydata,yi,answered_error)
        if(answered_error) then
           n_errors = n_errors + 1
        end if
        nnn = nnn + 1
     end do

!1000 write(6,*) "EOF detected."
1000 continue

     rewind(221)
     write(223,*) i, n_errors
  end do

  write(6,*) myperceptron%w

  close(221)
  close(223)

end program main
