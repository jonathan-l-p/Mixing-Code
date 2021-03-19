% a script to define functions for plotting and make plots
close all

prepath = '\Users\jonathan\Downloads\plot_';
SAVEALL = 0;

plotxchop5Star(uStar,1)
xlabel('u*')
title(['u*_\infty/u*_{-\infty} = ', ...
    num2str(FSR_U)])
if SAVEALL
    saveas(gcf,strcat([prepath,'ustar(y).png']))
end

plotxchop5Star(vStar,2)
xlabel('v*')
if SAVEALL
    saveas(gcf,strcat([prepath,'vstar(y).png']))
end

plotxchop5Star(hStar,3)
xlabel('h*')
title(['h*_\infty/h*_{-\infty} = ', ...
    num2str(FSR_h)])
if SAVEALL
    saveas(gcf,strcat([prepath,'hstar(y).png']))
end

plotxchop5Star(Y1,4)
xlabel('Y1')
if SAVEALL
    saveas(gcf,strcat([prepath,'Y1(y).png']))
end

plotxchop5Star(Y2,5)
xlabel('Y2')
if SAVEALL
    saveas(gcf,strcat([prepath,'Y2(y).png']))
end

plotxchop5Star(rhoStar,6)
xlabel('\rho*')
if SAVEALL
    saveas(gcf,strcat([prepath,'rhostar(y).png']))
end

plotxchop5Star(muStar,7)
xlabel('\mu*')
if SAVEALL
    saveas(gcf,strcat([prepath,'mustar(y).png']))
end

plotxchop5Star(T,8)
xlabel('T')
if SAVEALL
    saveas(gcf,strcat([prepath,'T(y).png']))
end

plotxchop5Star(kappaStar,9)
xlabel('\kappa*')
title(['\kappa_\infty(x_0) L / U_\infty = ', ...
    num2str(strain_ratio), ', \kappa_\infty/\kappa_{-\infty} = ', ...
    num2str(FSR_kappa)])
if SAVEALL
    saveas(gcf,strcat([prepath,'kappastar(y).png']))
end
% saveas(gcf,strcat([prepath,'kappastar(y).png']))

% plotxchop5Star(AnkKappa,10)
% xlabel('\kappa_\infty(x_0)L/U_\infty (\rho*\kappa*^2 - \kappa*_\infty)')

%% plot functions

% y vs. a for several x values on the same graph. a can represent any
% quantity contained in an array

% A - any quantity in a 2D array
% n - figure number

function plotxchop5Star(A,n)
% import variables from main Workspace
Nx = evalin('base','Nx');
XStar = evalin('base','XStar');
YStar = evalin('base','YStar');
x_vectorStar = XStar(1,:); y_vectorStar = YStar(:,1);
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
plot(A(:, i1), y_vectorStar, 'LineWidth', LW)
plot(A(:, i2), y_vectorStar, 'LineWidth', LW)
plot(A(:, i3), y_vectorStar, 'LineWidth', LW)
plot(A(:, i4), y_vectorStar, 'LineWidth', LW)
plot(A(:, i5), y_vectorStar, 'LineWidth', LW)

% define strings for legend
l1 = ['x* = ', num2str(x_vectorStar(i1))];
l2 = ['x* = ', num2str(x_vectorStar(i2))];
l3 = ['x* = ', num2str(x_vectorStar(i3))];
l4 = ['x* = ', num2str(x_vectorStar(i4))];
l5 = ['x* = ', num2str(x_vectorStar(i5))];

% plot legend
%legend(l1, l2, l3, l4, l5, l6, 'Location', 'north')
legend(l1, l2, l3, l4, l5)

% label y axis
ylabel('y*')
end
