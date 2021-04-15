clear;clc;close all

% plot various parameters for various cases
% SR = 1.0, 4.0, Pr = 1.0, UR = 4.0
SavePath = '/Users/jonathan/Documents/DataDump/MATLAB_test_cases/';
PlotPath = '/Users/jonathan/Downloads/sample SR plots/';

%% Pr = 1.0
load([SavePath, 'Pr_1_SR_2_UR_4_ConsKap@inf_true'])
l1 = ['Pr = ', num2str(Pr)];
Pr1 = Pr;
SR1 = strain_ratio;
UR1 = FSR_U;

% our analysis occurs at G_inf = 1, so lets find the closest k index where
% that is true
[minValue,k] = min(abs(G_of_eta(1,:)-1));

% G_of_eta over eta
figure(1)
plot(uStar(:,k), hStar(:,k), 'LineWidth', 2)
% title(['Pr = ', num2str(Pr), ...
%     ' and U_\infty/U_{-\infty} = ', num2str(FSR_U), ...
%     ' at x* = ', num2str(XStar(1,Nx))])
ylabel('h*')
xlabel('\eta')
% xlim([-2.5,2.5])
hold on

%% Pr = 0.7
load([SavePath, 'Pr_0d7_SR_2_UR_4_ConsKap@inf_true'])
l2 = ['Pr = ', num2str(Pr)];
Pr2 = Pr;
SR2 = strain_ratio;
UR2 = FSR_U;

% G_of_eta over eta
figure(1)
plot(uStar(:,k), hStar(:,k), 'LineWidth', 2)

%% Pr = 1.3
load([SavePath, 'Pr_1d3_SR_2_UR_4_ConsKap@inf_true'])
l3 = ['Pr = ', num2str(Pr)];
Pr3 = Pr;
SR3 = strain_ratio;
UR3 = FSR_U;

% G_of_eta over eta
figure(1)
plot(uStar(:,k), hStar(:,k), 'LineWidth', 2)
legend(l1, l2, l3, 'Location', 'best')
set(gca,'FontSize',18)
saveas(gcf,strcat([PlotPath,'plot.png']))


%% test case matches
if ~( (Pr1==Pr2) && (UR1==UR2) )
    fprintf('Error: cases do not match\n')
end
if ~( (Pr3==Pr3) && (UR2==UR3) )
    fprintf('Error: cases do not match\n')
end
