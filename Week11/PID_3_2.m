clc
clear all

%% define the system
s = tf('s');
G = 1/(s^2 - 4*s - 5)
Kp = 37.25;
Ki = 29.75;
Kd = 15;
C = (Kd*s^2 + Kp*s + Ki)/s

%% Simulate

[y,t] = step(G);
cl_tf = feedback(C*G,1); %diisi 1 karena unity feedback tidak ada transfer function pada feedbacknya jadi diisi 1
pole(cl_tf)
figure(1)
subplot(2,1,1);
plot(t,y,'r');
subplot(2,1,2);
step(cl_tf,'g');
grid on
ylim([0 2]);