! module to define initial and boundary (IB) conditions
! uses real precision module
! uses global module
! uses properties module
module IBconditions
  use realprecision
  use global
  use properties
  implicit none
  integer :: i, j
  real(dp) :: UStari(Ny,1) = 0.d0 ! u on all y at x = 0, [DIMENSIONLESS]
  real(dp) :: hStari(Ny,1) = 0.d0 ! h on all y at x = 0, [DIMENSIONLESS]
  real(dp) :: kappaStari(Ny,1) = 0.d0 ! \kappa on all y at x = 0, [DIMENSIONLESS]
  real(dp) :: Y1i(Ny,1) = 0.d0, Y2i(Ny,1) = 0.d0 ! Y1 and Y2 on all y at x = 0

  contains
    subroutine applyIBu()
      ! define u for all y at x = 0
      do i = 1,Ny
        ! assume U*(y = h) = 1
        UStari(i,1) = ((1.d0 + (1.d0/FSR_U))/2.d0) &
        + (((1.d0 - (1.d0/FSR_U))/2.d0)*tanh(G*yvectorStar(i)))
      end do

      ! apply Ui to x=0
      UStar(:,1) = UStari(:,1)

      ! apply UHp to y=H
      UStar(1,:) = 1.d0

      ! apply UHp to y=-H
      UStar(Ny,:) = 1.d0/FSR_U
    end subroutine applyIBu

    subroutine applyIBh()
      ! define h for all y at x = 0
      do i = 1,Ny
        ! assume h*(y = h) = 1
        hStari(i,1) = ((1.d0 + (1.d0/FSR_h))/2.d0) &
        + (((1.d0 - (1.d0/FSR_h))/2.d0)*tanh(G*yvectorStar(i)))
      end do

      ! apply hi to x=0
      hStar(:,1) = hStari(:,1)

      ! apply hHp to y=H
      hStar(1,:) = 1.d0

      ! apply hHn to y=-H
      hStar(Ny,:) = 1.d0/FSR_h
    end subroutine applyIBh

    subroutine applyIBTemp()
      ! define temperature for all y at x = 0
      do i = 1,Ny
        T(i,1) = findTemp(findCombCp(Y1(i,1),Y2(i,1)),hStar(i,1))
      end do

      ! apply Thp to y=H
      T(1,:) = Thp

      ! apply Thp to y=-H
      T(Ny,:) = T(Ny,1)

    end subroutine applyIBTemp

    subroutine applyIBComp()
      ! define composition of fluid 1 and fluid 2 for all y at x = 0
      do i = 1,Ny
        Y1i(i,1) = ((Y1Hp + Y1Hn)/2.d0) &
        + (((Y1Hp - Y1Hn)/2.d0)*tanh(G*yvectorStar(i)))

        Y2i(i,1) = ((Y2Hp + Y2Hn)/2.d0) &
        + (((Y2Hp - Y2Hn)/2.d0)*tanh(G*yvectorStar(i)))
      end do

      ! apply Y1i and Y2i to x=0
      Y1(:,1) = Y1i(:,1)
      Y2(:,1) = Y2i(:,1)

      ! apply YnHp to y=H
      Y1(1,:) = Y1hp
      ! Y2(1,:) = Y2hp not necessary because already 0

      ! apply YnHn to y=-H
      ! Y1(Ny,:) = Y1hn not necessary because already 0
      Y2(Ny,:) = Y2hn

    end subroutine applyIBComp

    subroutine applyIBmu()
      real(dp) :: mu1temp
      real(dp) :: mu2temp

      ! find \mu at y = H
      muHp = findMu(THp,Tcrit1,Vcrit1,W1)

      ! apply mui to x=0
      do i = 1,Ny
        mu1temp = findMu(T(i,1),Tcrit1,Vcrit1,W1)
        mu2temp = findMu(T(i,1),Tcrit2,Vcrit2,W2)
        mu(i,1) = findCombMu(Y1(i,1),mu1temp,Y2(i,1),mu2temp)

        muStar(i,1) = mu(i,1)/muHp
      end do

      ! apply muHp to y=h
      mu(1,:) = muHp
      muStar(1,:) = mu(1,:)/muHp

      ! apply MuHN to y = -h
      mu(Ny,:) = mu(Ny,1)
      muStar(Ny,:) = mu(Ny,:)/muHp

    end subroutine applyIBmu

    subroutine applyIBrho()
      ! apply rhoi to x = 0
      do i = 1,Ny
        rhoStar(i,1) = findRhoStar(T(i,1),Y1(i,1),Y2(i,1))
      end do

      ! apply rhoHp to y = H
      rhoStar(1,:) = rhoStar(1,1)

      ! apply rhoHP to y = -H
      rhoStar(Ny,:) = rhoStar(Ny,1)
    end subroutine applyIBrho

    subroutine applyIBkappa()
      ! define \kappa_{\infinity} / \kappa_{-\infinity}
      FSR_kappa = sqrt(RhoStar(Ny,1)/RhoStar(1,1))

      ! define \kappa for all y at x = 0
      do i = 1,Ny
        ! assume \kappa*(y = h) = 1
        kappaStari(i,1) = (((1.d0 + (1.d0/FSR_kappa))/2.d0) &
        + (((1.d0 - (1.d0/FSR_kappa))/2.d0)*tanh(G*yvectorStar(i))))
      end do

      ! apply kappai to x=0
      kappaStar(:,1) = kappaStari(:,1)

      fStar(1,:) = 1.d0 ! keep this for non-reactive case!

    end subroutine applyIBkappa

end module IBconditions
