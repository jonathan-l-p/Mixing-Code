
% load Sirignano's code results
load('/Users/jonathan/Google Drive/11 Spring 2021/199 Individual Study/Sirignano Code/workspace saves/results_G=1.mat')

font = 25;

% YF
plot_k_values = [100 2500 10000 20000 40000];
figure('DefaultAxesFontSize',font)
plot(eta(:,plot_k_values(1)), Y2(:,plot_k_values(1)), ...
    eta(:,plot_k_values(2)), Y2(:,plot_k_values(2)), ...
    eta(:,plot_k_values(3)), Y2(:,plot_k_values(3)), ...
    eta(:,plot_k_values(4)), Y2(:,plot_k_values(4)), ...
    eta(:,plot_k_values(5)), Y2(:,plot_k_values(5)), ...
    x, YF, 'LineWidth', 2)
xlim([-4, 4])
xlabel('\eta')
ylabel('YF')
legend(strcat('my solution x* = ', num2str(XStar(1,plot_k_values(1)))), ...
    strcat('x* = ', num2str(XStar(1,plot_k_values(2)))), ...
    strcat('x* = ', num2str(XStar(1,plot_k_values(3)))), ...
    strcat('x* = ', num2str(XStar(1,plot_k_values(4)))), ...
    strcat('x* = ', num2str(XStar(1,plot_k_values(5)))), ...
    'Sirignano''s similar solution')
grid on

% % YF
% figure('DefaultAxesFontSize',font)
% plot(eta(:,k), Alpha(:,k), x, alpha1, 'LineWidth', 2)
% xlim([-4, 4])
% xlabel('\eta')
% ylabel('alpha')
% legend('my solution', 'Sirignano''s solution')

% load('/Users/jonathan/Google Drive/11 Spring 2021/199 Individual Study/Sirignano Code/workspace saves/results_G=1.mat')
% figure('DefaultAxesFontSize',font)
% plot(x, YF, 'LineWidth', 2)
% hold on
% 
% load('/Users/jonathan/Google Drive/11 Spring 2021/199 Individual Study/Sirignano Code/workspace saves/results_G=1_3.mat')
% plot(x, YF, 'LineWidth', 2)
% hold on
% 
% load('/Users/jonathan/Google Drive/11 Spring 2021/199 Individual Study/Sirignano Code/workspace saves/results_G=1_5.mat')
% plot(x, YF, 'LineWidth', 2)
% hold on
% 
% load('/Users/jonathan/Google Drive/11 Spring 2021/199 Individual Study/Sirignano Code/workspace saves/results_G=1_7.mat')
% plot(x, YF, 'LineWidth', 2)
% hold on
% 
% load('/Users/jonathan/Google Drive/11 Spring 2021/199 Individual Study/Sirignano Code/workspace saves/results_G=1_9.mat')
% plot(x, YF, 'LineWidth', 2)
% hold on
% 
% legend('G = 1.0','G = 1.3','G = 1.5','G = 1.7','G = 1.9')
% ylabel('YF')
% xlabel('\eta')