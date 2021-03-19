! module to define global variables for the main code
! uses realprecision module
module global
  use realprecision
  implicit none

  ! okay to edit - - - - - - -
  character(len=*), parameter :: SavePath = '/Users/jonathan/Documents/DataDump/'

  ! integer, parameter :: Nx = 160000
  ! integer, parameter :: Ny = 853
  ! integer, parameter :: Nx = 80000
  ! integer, parameter :: Ny = 603
  integer, parameter :: Nx = 40000
  integer, parameter :: Ny = 426
  ! integer, parameter :: Nx = 20000
  ! integer, parameter :: Ny = 301
  integer, parameter :: x0ind = 1 ! ceiling(real(Nx)/7.d0) ! index of xStar where \kappa*_{\infinity}(x) switches from a constant to a function of 1 / sqrt{x}

  logical :: BuildMain = .true. ! logical variable to determine whether or not the run the main loop

  ! under construction
  ! nondimensional input variables
  real(dp) :: F = 7.d0 ! F = 5.d0 ! factor to ensure that the computational domain is wider than the maximum boundary layer thickness
  real(dp) :: FSR_h = 1.5d0 ! h_{\infinity} / h_{-\infinity}
  real(dp) :: FSR_u = 10.d0 ! u_{\infinity} / u_{-\infinity}
  real(dp) :: G = 10.d0 ! G = 10.d0 ! 2.25d0*0.000025d0 ! factor to ensure that the inital boundary layer thickness is smaller than the computational domain
  real(dp) :: Pr = 0.7d0 ! Prandtl number
  real(dp) :: strain_ratio = 0.5d0 ! \kappa_{\infinity}(x0ind) L / U_{\infinity}
  real(dp) :: Y1Hp = 1.d0 ! free stream composition of fluid 1 at y = H
  real(dp) :: Y1Hn = 0.d0 ! free stream composition of fluid 1 at y = -H
  real(dp) :: Y2Hp = 0.d0 ! free stream composition of fluid 2 at y = H
  real(dp) :: Y2Hn = 1.d0 ! free stream composition of fluid 2 at y = -H

  ! dimensional input variables
  ! fluid1 = OXYGEN
  ! fluid2 = PROPANE
  real(dp) :: cp1 = 988.d0 ! specific heat of fluid 1, [J/(kg K)]
  real(dp) :: cp2 = 1630.d0 ! specific heat of fluid 2, [J/(kg K)]
  real(dp) :: Tcrit1 = 154.55d0 ! critical temperature of fluid 1, [K]
  real(dp) :: Tcrit2 = 369.15d0 ! critical temperature of fluid 2, [K]
  real(dp) :: THp = 800.d0 ! free stream temperature at y = H, [K]
  real(dp) :: Vcrit1 = 0.0025d0 ! critical volume of fluid 1, [m3/kg]
  real(dp) :: Vcrit2 = 0.0045d0 ! critical volume of fluid 2, [m3/kg]
  real(dp) :: W1 = 0.032d0 ! molecular weight of fluid 1, [kg/mol]
  real(dp) :: W2 = 0.044d0 ! molecular weight of fluid 2, [kg/mol]

  ! DO NOT EDIT parameters - - - - - - -
  integer ::  k ! x-direction index integer for main loop
  integer :: Nx_ARRAY(1,1) = Nx
  integer :: Ny_ARRAY(1,1) = Ny

  logical :: BreakLoop = .false. ! logical variable for whether or not to stop computation

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
  ! - - - - - - -

  ! ! old parameters
  ! ! fluid1 = OXYGEN
  ! ! fluid2 = PROPANE
  ! real(dp) :: deltai = 0.000025d0 ! initial mixing layer thickness
  ! real(dp) :: KappaHP = 0.5d0 ! free stream kappa at y = h, [1/s]
  ! real(dp) :: FS = 5.d0 ! factor of safety, how much greater h is than the approximated delta max
  ! real(dp) :: L = 0.01d0 ! x domain (0, L), [m]
  ! real(dp) :: p = 2000000.d0 ! pressure on entire domain, [N/m2]
  ! real(dp) :: R = 8.31446261815324d0 ! universal gas constant, [J/(mol K)]
  ! real(dp) :: Thn = 300.d0 ! free stream temperature at y = -h, [K]
  ! real(dp) :: Uhp = 1.d0 ! free stream velocity at y = h, [m/s]
  ! real(dp) :: Uhn = 0.01d0 ! free stream velocity at y = -h, [m/s]
  !
  ! ! not okay to edit
  ! integer ::  k ! x-direction index integer for main loop
  ! integer :: Nx_ARRAY(1,1) = Nx
  ! integer :: Ny_ARRAY(1,1) = Ny
  !
  !
  ! real(dp) :: delta_max_approx ! [m]
  ! real(dp) :: delta_x, delta_y ! [m]
  ! real(dp) :: Enthalpy(Ny,Nx) = 0.d0 ! enthalpy on entire domain, [J/kg]
  ! real(dp) :: Enthalpyi(Ny,1) = 0.d0 ! enthalpy on all y at x = 0, [J/kg]
  ! real(dp) :: EnthalpyHP ! enthalpy at free stream (positive)
  ! real(dp) :: EnthalpyHN ! enthalpy at free stream (negative)
  ! real(dp) :: EnthalpyStar(Ny,Nx) = 0.d0 ! enthalpy on entire domain, [DIMENSIONLESS]
  ! real(dp) :: h ! y domain, (-h, h), [m]
  ! real(dp) :: Kappa(Ny,Nx) = 0.d0 ! kappa on entire domain, [1/s]
  ! real(dp) :: KappaHN ! free stream kappa at y = -h, [1/s]
  ! real(dp) :: Kappai(Ny,1) ! kappa on all y at x = 0, [1/s]
  ! real(dp) :: KappaStar(Ny,Nx) = 0.d0 ! kappa on entire domain, [DIMENSIONLESS]
  ! real(dp) :: Mu(Ny,Nx) = 0.d0 ! mu on the entire domain, [kg/(m s)]
  ! real(dp) :: MuHP ! viscosity at free stream (positive)
  ! real(dp) :: MuHN ! viscosity at free stream (negative)
  ! real(dp) :: MuStar(Ny,Nx) = 0.d0 ! mu on the entire domain, [DIMENSIONLESS]
  ! real(dp) :: ReHP  ! Reynolds number
  ! real(dp) :: Rho(Ny,Nx) = 0.d0 ! rho on the entire domain, [kg/m3]
  ! real(dp) :: RhoHP ! density at free stream (positive)
  ! real(dp) :: RhoHN ! density at free stream (negative)
  ! real(dp) :: RhoStar(Ny,Nx) = 0.d0 ! rho on the entire domain, [DIMENSIONLESS]
  ! real(dp) :: T(Ny,Nx) = 0.d0 ! temperature on entire domain, [K]
  ! real(dp) :: U(Ny,Nx) = 0.d0, V(Ny,Nx) = 0.d0 ! u and v on entire domain [m/s]
  ! real(dp) :: UStar(Ny,Nx) = 0.d0, VStar(Ny,Nx) = 0.d0 ! u and v on entire domain [DIMENSIONLESS]
  ! real(dp) :: UStari(Ny,1) = 0.d0 ! u on all y at x = 0, [DIMENSIONLESS]
  ! real(dp) :: X(Ny,Nx) = 0.d0, Y(Ny,Nx) = 0.d0 ! position in x and y [m]
  ! real(dp) :: XStar(Ny,Nx) = 0.d0, YStar(Ny,Nx) = 0.d0 ! position in x and y [m] [DIMENSIONLESS]
  ! real(dp) :: xvector(Nx) = 0.d0, yvector(Ny) = 0.d0 ! [m]
  ! real(dp) :: Y1(Ny,Nx) = 0.d0, Y2(Ny,Nx) = 0.d0 ! Y1 and Y2 on entire domain
  ! real(dp) :: Y1i(Ny,1) = 0.d0, Y2i(Ny,1) = 0.d0 ! Y1 and Y2 on all y at x = 0

end module global
