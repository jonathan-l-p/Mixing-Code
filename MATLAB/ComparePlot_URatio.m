clear;clc;close all

% plot various parameters for various cases
% UR = 2.0, 8.0, Pr = 1.0, SR = 2.0
SavePath = '/Users/jonathan/Documents/DataDump/MATLAB_test_cases/';
PlotPath = '/Users/jonathan/Downloads/sample UR plots/';

%% SR = 1.0
load([SavePath, 'Pr_1d0_SR_2d0_UR_2d0'])
l1 = ['U_\infty/U_{-\infty} = ', num2str(FSR_U)];
Pr1 = Pr;
SR1 = strain_ratio;
UR1 = FSR_U;

% u
figure(1)
plot(uStar(:,Nx), YStar(:,1), 'LineWidth', 2)
title(['Pr = ', num2str(Pr), ...
    ' and \kappa_\inftyL/U_\infty = ', num2str(strain_ratio), ...
    ' at x* = ', num2str(XStar(1,Nx))])
xlabel('u*')
ylabel('y*')
hold on

% v
figure(2)
plot(vStar(:,Nx), YStar(:,1), 'LineWidth', 2)
title(['Pr = ', num2str(Pr), ...
    ' and \kappa_\inftyL/U_\infty = ', num2str(strain_ratio), ...
    ' at x* = ', num2str(XStar(1,Nx))])
xlabel('v*')
ylabel('y*')
hold on

% h
figure(3)
plot(hStar(:,Nx), YStar(:,1), 'LineWidth', 2)
title(['Pr = ', num2str(Pr), ...
    ' and \kappa_\inftyL/U_\infty = ', num2str(strain_ratio), ...
    ' at x* = ', num2str(XStar(1,Nx))])
xlabel('h*')
ylabel('y*')
hold on

% Y1
figure(4)
plot(Y1(:,Nx), YStar(:,1), 'LineWidth', 2)
title(['Pr = ', num2str(Pr), ...
    ' and \kappa_\inftyL/U_\infty = ', num2str(strain_ratio), ...
    ' at x* = ', num2str(XStar(1,Nx))])
xlabel('Y1')
ylabel('y*')
hold on

% kappa
figure(5)
plot(kappaStar(:,Nx), YStar(:,1), 'LineWidth', 2)
title(['Pr = ', num2str(Pr), ...
    ' and \kappa_\inftyL/U_\infty = ', num2str(strain_ratio), ...
    ' at x* = ', num2str(XStar(1,Nx))])
xlabel('\kappa*')
ylabel('y*')
hold on

%% SR = 4.0
load([SavePath, 'Pr_1d0_SR_2d0_UR_8d0'])
l2 = ['U_\infty/U_{-\infty} = ', num2str(FSR_U)];
Pr2 = Pr;
SR2 = strain_ratio;
UR2 = FSR_U;

figure(1)
plot(uStar(:,Nx), YStar(:,1), 'LineWidth', 2)
legend(l1, l2, 'Location', 'best')
set(gca,'FontSize',18)
saveas(gcf,strcat([PlotPath,'ustar.png']))

figure(2)
plot(vStar(:,Nx), YStar(:,1), 'LineWidth', 2)
legend(l1, l2, 'Location', 'best')
set(gca,'FontSize',18)
saveas(gcf,strcat([PlotPath,'vstar.png']))

figure(3)
plot(hStar(:,Nx), YStar(:,1), 'LineWidth', 2)
legend(l1, l2, 'Location', 'best')
set(gca,'FontSize',18)
saveas(gcf,strcat([PlotPath,'hstar.png']))

figure(4)
plot(Y1(:,Nx), YStar(:,1), 'LineWidth', 2)
legend(l1, l2, 'Location', 'best')
set(gca,'FontSize',18)
saveas(gcf,strcat([PlotPath,'Y1.png']))

figure(5)
plot(kappaStar(:,Nx), YStar(:,1), 'LineWidth', 2)
legend(l1, l2, 'Location', 'best')
set(gca,'FontSize',18)
saveas(gcf,strcat([PlotPath,'kappastar.png']))

%% test case matches
if ~( (Pr1==Pr2) && (SR1==SR2) )
    fprintf('Error: cases do not match\n')
end
