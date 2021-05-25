figure('DefaultAxesFontSize',25)

plot(XStar(1,:), kappaStar(1,:),'-',...
    XStar(1,:), kappaStar(Ny,:),'-',...
    'LineWidth',2)
xlabel('x*')
% ylabel('\kappa*')
legend('$\kappa^*_{+\infty}$', '$\kappa^*_{-\infty}$', ...
    'Interpreter','latex')
% ylim([-0.5, 1.125])
grid on

% plot(XStar(1,:), kappaStar(1,:), XStar(1,:), kappaStar(Ny,:),...
%     'LineWidth',2)
