% with the current workspace, plot enthalpy at the end of the domain
run a_importf.m
fprintf('\nLOADED CURRENT CASE\n\n')

figure('DefaultAxesFontSize', 25)
plot(hStar(:,Nx), YStar(:,Nx),'LineWidth',2);
xlabel('h*')
ylabel('y*')
legend1 = ['Da = ', num2str(Da)];
hold on

% load in the nonreactive case and plot the same thing
load('/Users/jonathan/Documents/DataDump/MATLAB_test_cases/NonReactive.mat');
fprintf('\nLOADED NON-REACTIVE CASE\n\n')

plot(hStar(:,Nx), YStar(:,Nx),'LineWidth',2)
legend2 = 'non-reactive case';
legend(legend1, legend2)