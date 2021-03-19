! module for all affairs relating to dimensionality
! uses real precision module
! uses global module
! uses properties module
module dimensions
  use realprecision
  use global
  use properties
  implicit none
    integer :: i

  contains
    ! ! subroutine to declare dimensionless constants
    ! subroutine dimlessConstants()
    !   ! the following constants are not dimensionless, but they are used to
    !   ! normalize other not dimensionless quantities into dimensionless quantities
    !   EnthalpyHP = findEnth(findCombCp(Y1hp,Cp1,Y2hp,Cp2),Thp)
    !   EnthalpyHN = findEnth(findCombCp(Y1hn,Cp1,Y2hn,Cp2),Thn)
    !
    !   MuHP = findCombMu(Y1hp,findMu(Thp,Tcrit1,Vcrit1,W1),Y2hp,&
    !   findMu(Thp,Tcrit2,Vcrit2,W2))
    !   MuHN = findCombMu(Y1hn,findMu(Thn,Tcrit1,Vcrit1,W1),Y2hn,&
    !   findMu(Thn,Tcrit2,Vcrit2,W2))
    !
    !   RhoHP = findRho(Thp,Y1hp,Y2hp)
    !   RhoHN = findRho(Thn,Y1hn,Y2hn)
    !
    !   ! free stream kappas are linked via the pressure gradient
    !   KappaHN = sqrt((RhoHP/RhoHN)*(KappaHP**2))
    !
    !   ! okay now the following quantities are dimensionless
    !   ReHP = RhoHP*Uhp*L/MuHP
    !
    !   Pr = 1.d0
    !
    !   VarSave(1,1) = ReHP
    !
    !   ! Sirignano suggestion
    !   Rei = RhoHP*Uhp*deltai/MuHP
    !   VarSave(4,1) = Rei
    !
    ! end subroutine dimlessConstants
    !
    ! ! subroutine to update values of dimensionless arrays (without velocity)
    ! subroutine updateDimlessProperties()
    !   do i = 2,Ny-1
    !     RhoStar(i,k+1) = Rho(i,k+1)/RhoHP
    !     MuStar(i,k+1) = Mu(i,k+1)/MuHP
    !   end do
    ! end subroutine updateDimlessProperties

    ! subroutine to update values of non-dimensionless arrays
    subroutine updateDomain()
      real(dp) :: mu1temp
      real(dp) :: mu2temp

      do i = 2,Ny-1
        ! VERY IMPORTANT UPDATES
        T(i,k+1) = findTemp(findCombCp(Y1(i,k+1),Y2(i,k+1)),hStar(i,k+1))

        mu1temp = findMu(T(i,k+1),Tcrit1,Vcrit1,W1)
        mu2temp = findMu(T(i,k+1),Tcrit2,Vcrit2,W2)
        mu(i,k+1) = findCombMu(Y1(i,k+1),mu1temp,Y2(i,k+1),mu2temp)
        muStar(i,k+1) = mu(i,k+1)/muHp

        rhoStar(i,k+1) = findRhoStar(T(i,k+1),Y1(i,k+1),Y2(i,k+1))
      end do
    end subroutine updateDomain

    ! ! subroutine to update values of non-dimensionless arrays
    ! subroutine updateDimVel()
    !   do i = 1,Ny
    !     ! useful updates
    !     U(i,k+1) = Uhp*UStar(i,k+1)
    !     V(i,k+1) = Uhp*VStar(i,k+1)/sqrt(ReHP)
    !     Kappa(i,k+1) = KappaHP*KappaStar(i,k+1)
    !   end do
    ! end subroutine updateDimVel

end module dimensions
