% CAUTION: the ybar in this code does not match the ybar used by Sirignano

prepath = '/Users/jonathan/Documents/MATLAB_PlotDump/YBar/';

% define YBar, which is the integral of rho along y at x* = 1
YBar = repelem(0,Ny)';
for i = 1:floor(Ny/2)
    YBar(i) = trapz(YStar(ceil(Ny/2):-1:i,1), ...
        rhoStar(ceil(Ny/2):-1:i,Nx));
end

for i = (ceil(Ny/2)+1):Ny
    YBar(i) = trapz(YStar(ceil(Ny/2):i,1), ...
        rhoStar(ceil(Ny/2):i,Nx));
end

% plot u
plotxchop5Star(uStar,1)
ylim([min(YStar(:,Nx)), max(YStar(:,Nx))])
xlabel('u')
set(gca,'FontSize',18)
saveas(gcf,strcat([prepath,'ustar(y).png']))

% plot v
plotxchop5Star(vStar,2)
ylim([min(YStar(:,Nx)), max(YStar(:,Nx))])
xlabel('v*')
set(gca,'FontSize',18)
saveas(gcf,strcat([prepath,'vstar(y).png']))

% plot h
plotxchop5Star(hStar,3)
ylim([min(YStar(:,Nx)), max(YStar(:,Nx))])
xlabel('h*')
set(gca,'FontSize',18)
saveas(gcf,strcat([prepath,'hstar(y).png']))

% plot Y1
plotxchop5Star(Y1,4)
ylim([min(YStar(:,Nx)), max(YStar(:,Nx))])
xlabel('Y1')
set(gca,'FontSize',18)
saveas(gcf,strcat([prepath,'Y1(y).png']))

% plot kappa
plotxchop5Star(kappaStar,5)
ylim([min(YStar(:,Nx)), max(YStar(:,Nx))])
xlabel('\kappa*')
set(gca,'FontSize',18)
saveas(gcf,strcat([prepath,'kappastar(y).png']))

function plotxchop5Star(A,n)
% import variables from main Workspace
Nx = evalin('base','Nx');
XStar = evalin('base','XStar');
YStar = evalin('base','YStar');
x_vectorStar = XStar(1,:); y_vectorStar = YStar(:,1);
YBar = evalin('base','YBar');
LW = 2.0; % line width

% define 5 x values evenly spaced throughout the domain
i1 = 1;
i2 = ceil(Nx/4);
i3 = ceil(2*Nx/4);
i4 = ceil(3*Nx/4);
i5 = Nx;


figure(n)
hold on

% plot a(y) at 6 x values
plot(A(:, i1), YBar, 'LineWidth', LW)
plot(A(:, i2), YBar, 'LineWidth', LW)
plot(A(:, i3), YBar, 'LineWidth', LW)
plot(A(:, i4), YBar, 'LineWidth', LW)
plot(A(:, i5), YBar, 'LineWidth', LW)

% define strings for legend
l1 = ['x* = ', num2str(x_vectorStar(i1))];
l2 = ['x* = ', num2str(x_vectorStar(i2))];
l3 = ['x* = ', num2str(x_vectorStar(i3))];
l4 = ['x* = ', num2str(x_vectorStar(i4))];
l5 = ['x* = ', num2str(x_vectorStar(i5))];

% plot legend
legend(l1, l2, l3, l4, l5, 'Location', 'Best')

% label y axis
ylabel('$\bar{y}$','interpreter','latex')

% font size
set(gca,'FontSize',18)
end