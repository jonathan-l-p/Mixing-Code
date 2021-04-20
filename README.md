# Mixing Code for shear, compression, and diffusion analysis
### Author: Jonathan Palafoutas, Winter 2020

## About:
The Fortran files are responsible for the main fluid calculations. Velocities u and v, enthalpy h, compression factor kappa, and the mass fractions Y1 and Y2 are explicitly solved for downstream. Temperature, density, and viscosity are calculated and updated as well. These values are stored in arrays across the computational domain and stored as .bin files to be opened and analyzed by MATLAB scripts.

'Makefile' is responsible for compiling the Fortran code.

## Instructions:
Fluid and computational parameters can be adjusted in 'global_variables.f90'.

Execute 'script_clean' to completely recompile and execute the Fortran code.
Execute 'script' to run the Fortran code without forcing a recompilation.
Run 'make clean' in order to remove .o and .mod files 

To import fluid data into MATLAB, run 'a_importf.m'. Ensure that the export directory 'SavePath' in 'global_variables.f90' matches the import directory of the same name in 'a_importf.m'.

Run 'a_ImPlot.m' to import and plot the data at the same time.

## Fortran File Dictionary:
* **binwrite.f90** - converts numerical arrays to .bin files for exporting to other programs
* **clean_scheme.f90** - includes a general differential scheme for the convective/advective equation form that 4 out of our 5 governing equations follow, which simplifies **primary_calculations.f90**
* **dimensions.f90** - updates dimensional quantities across the domain (temperature, viscosity, and density)
* **global_variables.f90** - contains variables that are widely accessed throughout the code
* **IB_conditions.f90** - established initial and boundary conditions on the computational domain
* **Makefile** - compiles the Fortran files
* **math.f90** - contains functions for general mathematical operations, such as finding the trapezoidal area under a series of points
* **mesh_gen.f90** - defines the computational domain as a rectilinear mesh
* **mixing_main.f90** - main script
* **primary_calculations.f90** - defines the differential scheme for finding each of our 5 primary quantities of interest
* **properties.f90** - includes functions for calculating dimensional fluid properties such a temperature or viscosity
* **real_precision.f90** - defines the numerical precision for the code
* **script** - compiles the code using **Makefile** and then executes it
* **script_clean** - same as **script**, but clears the terminal before the code code compiles and removes the .mod and .o files to avoid clutter
* **Sirignano_variables** - calculates the variables defined in Sirignano's work that we are analyzing in this study
* **stablity_check.f90** - checks that the domain is stable using the same stability check as for the heat equation

