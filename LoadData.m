clear all;
close all;
clc;
%%
data = loadCSVfile('Indy7FrictionData_joint1.csv');
data = sortrows(data, 1);

%%
veld = data(:,1);
vel = data(:,2);
tau = data(:,3);
%%

%%
figure,
% subplot(2,1,1)
plot(veld, tau, 'k-o', 'linewidth',2)
hold on;
plot(vel, tau, 'b-o', 'linewidth',2)
legend('desired', 'real');