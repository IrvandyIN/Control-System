clc
clear all

% Plot Pole and Zero Sistem
num = [59];
den = [1 1 1];
G = tf(num,den)
p = pole(G)
z = zero(G)
t = 0:0.05:20;

%%
figure(1)
pzmap(G)
grid on

% figure(2)
% step(num,den,t)
% grid on