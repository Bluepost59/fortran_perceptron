module mod_prcptr
  implicit none
  !----------------------------------------------------------------------
  ! header of perceptron
  !----------------------------------------------------------------------
  type perceptron
     integer :: dimsion ! dimension of sample data
     double precision,allocatable :: w(:)
     double precision :: eta
     double precision :: epoch
   contains
     procedure :: learn => perceptron_learn
  end type perceptron

  interface perceptron
     module procedure init_perceptron
  end interface perceptron

contains
  !======================================================================
  ! implementations of perceptron
  !----------------------------------------------------------------------
  ! constructer
  !----------------------------------------------------------------------
  type(perceptron) function init_perceptron(nnn,myeta)
    integer :: nnn
    double precision :: myeta

    allocate(init_perceptron%w(nnn))
    init_perceptron%w = 0d0

    init_perceptron%dimsion = nnn
    init_perceptron%eta = myeta

    init_perceptron%epoch = 0
  end function init_perceptron
  !----------------------------------------------------------------------
  ! learning
  !----------------------------------------------------------------------
  subroutine perceptron_learn(self,mydata,y,answered_error)
    class(perceptron) :: self
    double precision :: mydata(:) ! 1 sample (not dataset)
    double precision :: y         ! true answer
    logical,optional :: answered_error              ! error

    double precision :: z 
    double precision :: output
    integer :: i
    
    answered_error = .false.

    if(size(mydata) /= self%dimsion) return

    z=0d0
    do i=1, size(mydata)
       z = z + mydata(i) *self%w(i)
    end do

    output = phi(z)

    if(output /= y) answered_error = .true.

    do i=1, self%dimsion
       self%w(i) = self%w(i) + self%eta *(y-output) *mydata(i)
    end do

  end subroutine perceptron_learn
  !
  !======================================================================
  ! other functions
  !----------------------------------------------------------------------
  ! activation function
  !----------------------------------------------------------------------
  double precision function phi(x)
    double precision :: x

    if(x<=0) then
       phi = -1
    else
       phi = 1
    end if
  end function phi


end module mod_prcptr
