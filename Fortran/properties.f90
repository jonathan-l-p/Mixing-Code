! module to find scalar quantities as functions of temperature
! uses global module
! uses realprecision module
module properties
  use global
  use realprecision
  implicit none

  contains
    ! function to find viscosity for a particular fluid as a function of T
    real(dp) function findMu(T,Tcrit,Vcrit,W)
      real(dp), intent(in) :: T
      real(dp), intent(in) :: Tcrit
      real(dp), intent(in) :: Vcrit
      real(dp), intent(in) :: W
      real(dp) :: VcritConvert ! unit converted Vcrit
      real(dp) :: WConvert ! unit converted W

      ! initiate constants and variables for equations that i don't understand
      real(dp) :: A = 1.16145d0
      real(dp) :: B = 0.14874d0
      real(dp) :: C = 0.52487d0
      real(dp) :: D = 0.77320d0
      real(dp) :: E = 2.16178d0
      real(dp) :: F = 2.43787d0
      real(dp) :: G = -0.0006435d0
      real(dp) :: H = 7.27371d0
      real(dp) :: S = 18.0323d0
      real(dp) :: Wcon = -0.76830d0
      real(dp) :: epsOverK
      real(dp) :: Tstar
      real(dp) :: omegastar

      ! convert Vcrit to [cm3/mol]
      VcritConvert = Vcrit*(100.d0**3)*W

      ! convert W to [g/mol]
      WConvert = W*1000.d0

      ! use equations that I don't understand
      epsOverK = Tcrit/1.2593d0
      Tstar = T/epsOverK

      omegastar = (A/(Tstar**B)) &
            + (C/exp(D*Tstar))  &
            + (E/exp(F*Tstar))  &
            + (G*(Tstar**B)*sin((S*(Tstar**Wcon))-H))

      findMu = (0.0000407850d0)*((WConvert*T)**(1.d0/2.d0))/&
      ((VcritConvert**(2.d0/3.d0))*omegastar)

      ! this value should be in g/(cm*s), so we convert to kg/(m*s)
      findMu = findMu*0.1d0

      ! Riki correction factor: predicted values are 100 times greater than
      ! they should be
      ! findMu = findMu*0.01d0 ! [kg/(m s)]
    end function findMu

    ! function to find the combined mu for mixed fluids
    real(dp) function findCombMu(Y1,mu1,Y2,mu2)
      real(dp), intent(in) :: Y1
      real(dp), intent(in) :: mu1
      real(dp), intent(in) :: Y2
      real(dp), intent(in) :: mu2

      findCombMu = (Y1*mu1) + (Y2*mu2) ! [kg/(m s)]
    end function findCombMu

    ! function to find normalized \mu
    real(dp) function findMuStar(mu)
      real(dp), intent(in) :: mu
      findMuStar = mu/muHp
    end function findMuStar

    ! ! function to find the combined Cp for mixed fluids
    ! real(dp) function findCombCp(Y1,Y2)
    !   real(dp), intent(in) :: Y1
    !   real(dp), intent(in) :: Y2
    !
    !   findCombCp = (Y1*cp1) + (Y2*cp2) ! [J/(kg K)]
    ! end function findCombCp

    ! find temperature of mixed fluids as a function of normalized enthalpy
    ! * pure composition of free stream assumption
    real(dp) function findTemp(hstar)
      real(dp), intent(in) :: hstar ! normalized enthalpy

      findTemp = THp*hstar ! [K]
    end function findTemp

    ! find density of mixed fluids based on temperature and composition
    ! * pure composition of free stream assumption
    real(dp) function findRhoStar(T,Y1,Y2)
      real(dp), intent(in) :: T
      real(dp), intent(in) :: Y1
      real(dp), intent(in) :: Y2
      real(dp) :: MolWeightComb

      MolWeightComb = 1.d0/((Y1/W1) + (Y2/W2))

      findRhoStar = (THp/T)*(MolWeightComb/W1) ! [Dimensionless]
    end function findRhoStar

end module properties
