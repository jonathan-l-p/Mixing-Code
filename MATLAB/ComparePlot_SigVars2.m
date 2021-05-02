
% load Sirignano's code results
load('/Users/jonathan/Google Drive/11 Spring 2021/199 Individual Study/Sirignano Code/workspace saves/results_G=1.mat')

font = 25;

% YF
figure('DefaultAxesFontSize',font)
plot(eta(:,100), Y2(:,100), eta(:,1000), Y2(:,1000), eta(:,10000), Y2(:,10000), eta(:,30000), Y2(:,30000), eta(:,40000), Y2(:,40000), x, YF, 'LineWidth', 2)
xlim([-4, 4])
xlabel('\eta')
ylabel('YF')
legend('my solution k = 100', 'k = 1000', 'k = 10000', 'k = 30000', 'k = 40000', 'Sirignano''s solution')

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