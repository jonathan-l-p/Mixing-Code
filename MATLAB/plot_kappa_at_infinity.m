figure('DefaultAxesFontSize',25)

plot(XStar(1,:), kappaStar(1,:), XStar(1,:), kappaStar(Ny,:),...
    XStar(1,x0ind:end),c./XStar(1,x0ind:end),...
    'LineWidth',2)
<<<<<<< Updated upstream
ylim([0,1.05])
xlabel('x*')
ylabel('\kappa*')
legend('\kappa* at +\infty', '\kappa* at -\infty')
=======

% plot(XStar(1,:), kappaStar(1,:), XStar(1,:), kappaStar(Ny,:),...
%     'LineWidth',2)

% ylim([0,1.05])
xlabel('x*')
ylabel('\kappa*')
legend('\kappa* at +\infty', '\kappa* at -\infty', 'c/x*')
hold on
>>>>>>> Stashed changes
