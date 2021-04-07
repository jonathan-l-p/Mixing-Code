FC=gfortran
FFLAGS=-O3 -Wall -Wextra -frecursive
SRC=real_precision.f90 math.f90 global_variables.f90 Sirignano_variables.f90 mesh_gen.f90 properties.f90 IB_conditions.f90 dimensions.f90 stability_check.f90 clean_scheme.f90 primary_calculations.f90 binwrite.f90 mixing_main.f90
OBJ=${SRC:.f90=.o}

%.o: %.f90
	$(FC) $(FFLAGS) -o $@ -c $<

main: $(OBJ)
	$(FC) $(FFLAGS) -o $@ $(OBJ)

clean:
	rm *.o *.mod main
