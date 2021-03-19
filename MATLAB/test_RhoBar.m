% Explore the implications of the RhoBar variable
% \int_0^y   \rho dy'

% define RhoBar, which is the integral of rho along y at x* = 1
RhoBar = repelem(0,Ny)';
for i = 1:floor(Ny/2)
    RhoBar(i) = trapz(YStar(ceil(Ny/2):-1:i,1), ...
        rhoStar(ceil(Ny/2):-1:i,Nx));
end

for i = (ceil(Ny/2)+1):Ny
    RhoBar(i) = trapz(YStar(ceil(Ny/2):i,1), ...
        rhoStar(ceil(Ny/2):i,Nx));
end

plot(kappaStar(:,Nx),YStar(:,1), 'LineWidth', 2)
hold on
plot(kappaStar(:,Nx),RhoBar(:), 'LineWidth', 2)
ylim([min(YStar(:,Nx)), max(YStar(:,Nx))])
xlabel('\kappa*')
legend({'y = y*', 'y = $\bar{\rho}$'},'Interpreter','Latex')