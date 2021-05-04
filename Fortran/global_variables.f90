! module to define global variables for the main code
! uses realprecision module
module global
  use realprecision
  implicit none

  ! okay to edit - - - - - - -
  character(len=*), parameter :: &
  OutPath = '/Users/jonathan/Documents/DataDump/out_Fortran/'

  ! integer, parameter :: Nx = 160000
  ! integer, parameter :: Ny = 853
  ! integer, parameter :: Nx = 27500
  ! integer, parameter :: Ny = 701
  integer, parameter :: Nx = 40000
  integer, parameter :: Ny = 427 ! 426
  ! integer, parameter :: Nx = 20000
  ! integer, parameter :: Ny = 301
  integer, parameter :: x0ind = 1 ! ceiling(real(Nx)/7.d0) ! index of xStar where \kappa*_{\infinity}(x) switches from a constant to a function of 1 / sqrt{x}

  logical :: BuildMain = .true. ! logical variable to determine whether or not the run the main loop

  ! under construction
  ! nondimensional input variables
  real(dp) :: F = 3.0d0 ! F = 5.d0 ! factor to ensure that the computational domain is wider than the maximum boundary layer thickness
  real(dp) :: FSR_h = 1.d0/3.d0 ! h_{\infinity} / h_{-\infinity} INVERTED
  real(dp) :: FSR_u = 4.0d0 ! u_{\infinity} / u_{-\infinity}
  real(dp) :: G = 10.d0 ! G = 10.d0 ! 2.25d0*0.000025d0 ! factor to ensure that the inital boundary layer thickness is smaller than the computational domain
  real(dp) :: Pr = 1.0d0 ! Prandtl number
  real(dp) :: strain_ratio = 1.d0 ! 2.d0 ! \kappa_{\infinity}(x0ind) L / U_{\infinity}
  real(dp) :: Y1Hp = 1.d0 ! free stream composition of fluid 1 at y = H
  real(dp) :: Y1Hn = 0.d0 ! free stream composition of fluid 1 at y = -H
  real(dp) :: Y2Hp = 0.d0 ! free stream composition of fluid 2 at y = H
  real(dp) :: Y2Hn = 1.d0 ! free stream composition of fluid 2 at y = -H

  ! dimensional input variables
  ! fluid1 = OXYGEN
  ! fluid2 = PROPANE
  real(dp) :: cp1 = 988.d0 ! specific heat of fluid 1, [J/(kg K)]
  real(dp) :: cp2 = 1630.d0 ! specific heat of fluid 2, [J/(kg K)]
  real(dp) :: nu = 0.275d0 ! stoichiometric ratio of fluid 2 to fluid 1 by mass
  real(dp) :: Q = 30.d0 ! heating value of the fuel []
  real(dp) :: Tcrit1 = 154.55d0 ! critical temperature of fluid 1, [K]
  real(dp) :: Tcrit2 = 369.15d0 ! critical temperature of fluid 2, [K]
  real(dp) :: THp ! free stream temperature at y = H, [K]
  real(dp) :: Vcrit1 = 0.0025d0 ! critical volume of fluid 1, [m3/kg]
  real(dp) :: Vcrit2 = 0.0045d0 ! critical volume of fluid 2, [m3/kg]
  real(dp) :: W1 = 0.032d0 ! molecular weight of fluid 1, [kg/mol]
  real(dp) :: W2 = 0.044d0 ! molecular weight of fluid 2, [kg/mol]

  ! DO NOT EDIT parameters - - - - - - -
  integer ::  k ! x-direction index integer for main loop
  integer :: Nx_ARRAY(1,1) = Nx
  integer :: Ny_ARRAY(1,1) = Ny

  logical :: BreakLoop = .false. ! flag for whether or not to stop computation
  logical :: StableDomain = .true. ! flag for whether or not domain in stable

  real(dp) :: Ank_kappa(Ny,Nx) = 0.d0 ! [TEST] for testing the behavior of one of the terms in the kappa equation
  real(dp) :: delta_x_Star, delta_y_Star ! [DIMENSIONLESS]
  real(dp) :: FSR_kappa ! \kappa_{\infinity} / \kappa_{-\infinity}
  real(dp) :: fStar(1,Nx) = 0.d0 ! for \kappa equation
  real(dp) :: hStar(Ny,Nx) = 0.d0 ! h on entire domain [DIMENSIONLESS]
  real(dp) :: kappaStar(Ny,Nx) = 0.d0 ! \kappa on entire domain [DIMENSIONLESS]
  real(dp) :: kappaStarAtPositiveInfinity(Nx) = 0.d0 ! [TEST
  real(dp) :: mu(Ny,Nx) = 0.d0 ! viscosity on entire domain [kg/(m s)]
  real(dp) :: muHp ! \mu at y = H
  real(dp) :: muStar(Ny,Nx) = 0.d0 ! viscosity on entire domain [DIMENSIONLESS]
  real(dp) :: rhoStar(Ny,Nx) = 0.d0 ! \rho on entire domain [DIMENSIONLESS]
  real(dp) :: T(Ny,Nx) = 0.d0 ! temperature on entire domain [K]
  real(dp) :: UStar(Ny,Nx) = 0.d0, VStar(Ny,Nx) = 0.d0 ! u and v on entire domain [DIMENSIONLESS]
  real(dp) :: VarSave(25,1) = 0.d0 ! array to save quantities of interest
  real(dp) :: XStar(Ny,Nx) = 0.d0, YStar(Ny,Nx) = 0.d0 ! position in x and y [m] [DIMENSIONLESS]
  real(dp) :: xvectorStar(Nx) = 0.d0, yvectorStar(Ny) = 0.d0 ! [DIMENSIONLESS]
  real(dp) :: Y1(Ny,Nx) = 0.d0, Y2(Ny,Nx) = 0.d0 ! Y1 and Y2 on entire domain

  ! Sirignano variables
  real(dp) :: ybar(Ny,Nx) = 0.d0
  real(dp) :: g_of_x(Ny,Nx) = 0.d0
  real(dp) :: eta(Ny,Nx) = 0.d0
  real(dp) :: G_of_eta(Ny,Nx) = 0.d0
  real(dp) :: E(Ny,Nx) = 0.d0
  real(dp) :: Alpha(Ny,Nx) = 0.d0
  real(dp) :: Beta(Ny,Nx) = 0.d0
  ! - - - - - - -

end module global
