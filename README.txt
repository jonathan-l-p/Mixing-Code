Mixing Code for shear, compression, and diffusion analysis
Author: Jonathan Palafoutas, Winter 2020

ABOUT:
The Fortran files are responsible for the main fluid calculations. Velocities u and v, enthalpy h, compression factor kappa, and the mass fractions Y1 and Y2 are explicitly solved for downstream. Temperature, density, and viscosity are calculated and updated as well. These values are stored in arrays across the computational domain and stored as .bin files to be opened and analyzed by MATLAB scripts.

'Makefile' is responsinle for compiling the Fortran code.

INSTRUCTIONS:
Fluid and computational parameters can be adjusted in 'global_variables.f90'.

Execute 'script_clean' to completely recompile and execute the Fortran code.
Execute 'script' to run the Fortran code without forcing a recompilation.

To import fluid data into MATLAB, run 'a_importf.m'. Ensure that the export directory 'SavePath' in 'global_variables.f90' matches the import directory of the same name in 'a_importf.m'.

Run 'a_ImPlot.m' to import and plot the data at the same time.
