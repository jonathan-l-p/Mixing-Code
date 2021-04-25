
close all

% load Sirignano's code results
load('/Users/jonathan/Google Drive/11 Spring 2021/199 Individual Study/Sirignano Code/results.mat')

% find k index where G_inf = 1
[minValue,k] = min(abs(G_of_eta(1,:)-1));

font = 25;

% alpha
figure('DefaultAxesFontSize',font)
plot(eta(:,k), Alpha(:,k), x, alpha0, 'LineWidth', 2)
xlim([-4, 4])
xlabel('\eta')
ylabel('\alpha')
legend('my solution', 'Sirignano''s solution')

% h
figure('DefaultAxesFontSize',font)
plot(eta(:,k), hStar(:,k), x, h0, 'LineWidth', 2)
xlim([-4, 4])
xlabel('\eta')
ylabel('h')
legend('my solution', 'Sirignano''s solution')