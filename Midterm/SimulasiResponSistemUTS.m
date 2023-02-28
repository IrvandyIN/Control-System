clc
clear all

%Simulasi Respon Sistem 
num = [59];
den = [1 1 1];
t = 0:0.005:20;
sys = tf (num,den)
[y,x,t] = step(num,den,t);
plot(t,y)
% step(num,den)
grid on
title('Unit-Step Response of G(s)=59/(s^2+s+1)');
xlabel('t(s)');
ylabel('Output');