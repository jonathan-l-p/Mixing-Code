plot(XStar(1,:), kappaStar(1,:), XStar(1,:), kappaStar(Ny,:),...
    'LineWidth',2)
% ylim([0,1.05])
xlabel('x*')
ylabel('\kappa*')
legend('\kappa* at +\infty', '\kappa* at -\infty')
hold on

plot(XStar(1,:), 1./(1+XStar(1,:)))
hold on

plot(XStar(1,10000:end), 1./(XStar(1,10000:end)))