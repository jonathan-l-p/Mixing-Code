clear;clc;close all

% plot various parameters for various cases
% Pr = 0.7, 1.0, 1.3, SR = 2.0, UR = 4.0
SavePath = '/Users/jonathan/Documents/DataDump/MATLAB_test_cases/';
PlotPath = '/Users/jonathan/Downloads/sample Pr plots/';

%% Pr = 0.7
load([SavePath, 'Pr_0d7_SR_2d0_UR_4d0.mat'])
l1 = ['Pr = ', num2str(Pr)];
SR1 = strain_ratio;
UR1 = FSR_U;

% u
figure(1)
plot(uStar(:,Nx), YStar(:,1), 'LineWidth', 2)
% title(['\kappa_\inftyL/U_\infty = ', num2str(strain_ratio), ...
%     ' and U_\infty/U_{-\infty} = ', num2str(FSR_U), ...
%     ' at x* = ', num2str(XStar(1,Nx))])
xlabel('u*')
ylabel('y*')
hold on

% v
figure(2)
plot(vStar(:,Nx), YStar(:,1), 'LineWidth', 2)
% title(['\kappa_\inftyL/U_\infty = ', num2str(strain_ratio), ...
%     ' and U_\infty/U_{-\infty} = ', num2str(FSR_U), ...
%     ' at x* = ', num2str(XStar(1,Nx))])
xlabel('v*')
ylabel('y*')
hold on

% h
figure(3)
plot(hStar(:,Nx), YStar(:,1), 'LineWidth', 2)
% title(['\kappa_\inftyL/U_\infty = ', num2str(strain_ratio), ...
%     ' and U_\infty/U_{-\infty} = ', num2str(FSR_U), ...
%     ' at x* = ', num2str(XStar(1,Nx))])
xlabel('h*')
ylabel('y*')
hold on

% Y1
figure(4)
plot(Y1(:,Nx), YStar(:,1), 'LineWidth', 2)
% title(['\kappa_\inftyL/U_\infty = ', num2str(strain_ratio), ...
%     ' and U_\infty/U_{-\infty} = ', num2str(FSR_U), ...
%     ' at x* = ', num2str(XStar(1,Nx))])
xlabel('Y1')
ylabel('y*')
hold on

% kappa
figure(5)
plot(kappaStar(:,Nx), YStar(:,1), 'LineWidth', 2)
% title(['\kappa_\inftyL/U_\infty = ', num2str(strain_ratio), ...
%     ' and U_\infty/U_{-\infty} = ', num2str(FSR_U), ...
%     ' at x* = ', num2str(XStar(1,Nx))])
xlabel('\kappa*')
ylabel('y*')
hold on

% h/h over u/u
figure(6)
plot(uStar(:,Nx),hStar(:,Nx), 'LineWidth', 2)
% title(['\kappa_\inftyL/U_\infty = ', num2str(strain_ratio), ...
%     ' and U_\infty/U_{-\infty} = ', num2str(FSR_U), ...
%     ' at x* = ', num2str(XStar(1,Nx))])
xlabel('u/U_\infty')
ylabel('h/h_\infty')
hold on

%% Pr = 1.0
load([SavePath, 'Pr_1d0_SR_2d0_UR_4d0.mat'])
l2 = ['Pr = ', num2str(Pr)];
SR2 = strain_ratio;
UR2 = FSR_U;

figure(1)
plot(uStar(:,Nx), YStar(:,1), 'LineWidth', 2)
hold on

figure(2)
plot(vStar(:,Nx), YStar(:,1), 'LineWidth', 2)
hold on

figure(3)
plot(hStar(:,Nx), YStar(:,1), 'LineWidth', 2)
hold on

figure(4)
plot(Y1(:,Nx), YStar(:,1), 'LineWidth', 2)
hold on

figure(5)
plot(kappaStar(:,Nx), YStar(:,1), 'LineWidth', 2)
hold on

figure(6)
plot(uStar(:,Nx),hStar(:,Nx), 'LineWidth', 2)
hold on

%% Pr = 1.3
load([SavePath, 'Pr_1d3_SR_2d0_UR_4d0.mat'])
l3 = ['Pr = ', num2str(Pr)];
SR3 = strain_ratio;
UR3 = FSR_U;

figure(1)
plot(uStar(:,Nx), YStar(:,1), 'LineWidth', 2)
legend(l1, l2, l3, 'Location', 'best')
set(gca,'FontSize',18)
saveas(gcf,strcat([PlotPath,'ustar.png']))

figure(2)
plot(vStar(:,Nx), YStar(:,1), 'LineWidth', 2)
legend(l1, l2, l3, 'Location', 'best')
set(gca,'FontSize',18)
saveas(gcf,strcat([PlotPath,'vstar.png']))

figure(3)
plot(hStar(:,Nx), YStar(:,1), 'LineWidth', 2)
legend(l1, l2, l3, 'Location', 'best')
set(gca,'FontSize',18)
saveas(gcf,strcat([PlotPath,'hstar.png']))

figure(4)
plot(Y1(:,Nx), YStar(:,1), 'LineWidth', 2)
legend(l1, l2, l3, 'Location', 'best')
set(gca,'FontSize',18)
saveas(gcf,strcat([PlotPath,'Y1.png']))

figure(5)
plot(kappaStar(:,Nx), YStar(:,1), 'LineWidth', 2)
legend(l1, l2, l3, 'Location', 'best')
set(gca,'FontSize',18)
saveas(gcf,strcat([PlotPath,'kappastar.png']))

figure(6)
plot(uStar(:,Nx),hStar(:,Nx), 'LineWidth', 2)
legend(l1, l2, l3, 'Location', 'best')
set(gca,'FontSize',18)
saveas(gcf,strcat([PlotPath,'FSRh_over_FSRu.png']))

%% test case matches
if ~(( (SR1==SR2) && (SR2==SR3) ) && ((UR1==UR2) && (UR2==UR3)))
    fprintf('Error: cases do not match\n')
end

