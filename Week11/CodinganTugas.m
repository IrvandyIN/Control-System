clc
clear all


%% Mencari Akarnya
p = [1 -1 -32 -60]
r = roots(p)
%  r =
%     6.8990
%    -3.0000
%    -2.8990

%% Mencari persamaan polinomial
i = sqrt(-1)
r = [-5 -1 -3 -2]
ak = poly(r)

%% define the system
s = tf('s');
G = 1/(s^3 + 9*s^2 + 8*s - 60)
Kp = 121;
Ki = 30;
Kd = 33;
C = (Kd*s^2 + Kp*s + Ki)/s

%% Simulate

[y,t] = step(G);
cl_tf = feedback(C*G,1); %diisi 1 karena unity atau feedback tidak ada transfer function pada feedbacknya jadi diisi 1
kutub = pole(cl_tf)
figure(1)
subplot(2,1,1);
plot(t,y,'r');
subplot(2,1,2);
step(cl_tf,'g');
grid on
ylim([0 2]);