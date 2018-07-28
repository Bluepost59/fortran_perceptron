all:mod_prcptr.f90 test.f90
	gfortran mod_prcptr.f90 test.f90

clean:
	rm -vrf *.out *.mod
