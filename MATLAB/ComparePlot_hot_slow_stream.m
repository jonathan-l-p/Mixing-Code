clear;clc;close all

% plot various parameters for various cases
% Pr = 0.7, 1.0, 1.3, SR = 2.0, UR = 4.0

%% Pr = 1.0, hot fast stream
load('test_cases/Pr_1d0_SR_2d0_UR_4d0.mat')
l1 = ['Pr = ', num2str(Pr), ', hot fast stream'];
SR1 = strain_ratio;
UR1 = FSR_U;

% u
figure(1)
plot(uStar(:,Nx), YStar(:,1), 'LineWidth', 2)
title(['\kappa_\inftyL/U_\infty = ', num2str(strain_ratio), ...
    ' and U_\infty/U_{-\infty} = ', num2str(FSR_U), ...
    ' at x* = ', num2str(XStar(1,Nx))])
xlabel('u*')
ylabel('y*')
hold on

% v
figure(2)
plot(vStar(:,Nx), YStar(:,1), 'LineWidth', 2)
title(['\kappa_\inftyL/U_\infty = ', num2str(strain_ratio), ...
    ' and U_\infty/U_{-\infty} = ', num2str(FSR_U), ...
    ' at x* = ', num2str(XStar(1,Nx))])
xlabel('v*')
ylabel('y*')
hold on

% h
figure(3)
plot(hStar(:,Nx), YStar(:,1), 'LineWidth', 2)
title(['\kappa_\inftyL/U_\infty = ', num2str(strain_ratio), ...
    ' and U_\infty/U_{-\infty} = ', num2str(FSR_U), ...
    ' at x* = ', num2str(XStar(1,Nx))])
xlabel('h*')
ylabel('y*')
hold on

% Y1
figure(4)
plot(Y1(:,Nx), YStar(:,1), 'LineWidth', 2)
title(['\kappa_\inftyL/U_\infty = ', num2str(strain_ratio), ...
    ' and U_\infty/U_{-\infty} = ', num2str(FSR_U), ...
    ' at x* = ', num2str(XStar(1,Nx))])
xlabel('Y1')
ylabel('y*')
hold on

% kappa
figure(5)
plot(kappaStar(:,Nx), YStar(:,1), 'LineWidth', 2)
title(['\kappa_\inftyL/U_\infty = ', num2str(strain_ratio), ...
    ' and U_\infty/U_{-\infty} = ', num2str(FSR_U), ...
    ' at x* = ', num2str(XStar(1,Nx))])
xlabel('\kappa*')
ylabel('y*')
hold on

%% Pr = 1.0, hot slow stream
load('test_cases_hot_slow_stream/Pr_1d0_SR_2d0_UR_4d0.mat')
l2 = ['Pr = ', num2str(Pr), ', hot slow stream'];
SR2 = strain_ratio;
UR2 = FSR_U;

figure(1)
plot(uStar(:,Nx), YStar(:,1), 'LineWidth', 2)
legend(l1, l2)

figure(2)
plot(vStar(:,Nx), YStar(:,1), 'LineWidth', 2)
legend(l1, l2)

figure(3)
plot(hStar(:,Nx), YStar(:,1), 'LineWidth', 2)
legend(l1, l2)

figure(4)
plot(Y1(:,Nx), YStar(:,1), 'LineWidth', 2)
legend(l1, l2)

figure(5)
plot(kappaStar(:,Nx), YStar(:,1), 'LineWidth', 2)
legend(l1, l2)

%% test case matches
if ~( (SR1==SR2) && (UR1==UR2) )
    fprintf('Error: cases do not match\n')
end

