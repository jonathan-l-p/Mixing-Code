plot(XStar(1,:), kappaStar(1,:), XStar(1,:), kappaStar(Ny,:),...
    'LineWidth',2)
ylim([0,1.05])
xlabel('x*')
ylabel('\kappa*')
legend('\kappa* at +\infty', '\kappa* at -\infty')