clc
clear all

%% define the system
s = tf('s');
G = 1/(s^3 + 8*s^2 + 12*s)
%G = 1/((s+2)*(s+1))
figure(1)
rlocus(G)
Kcr = 30;
Pcr = 2.8099;

%% step response
figure(2)
[y,t] = step(G);
plot(t,y);
%% checking closed-loop tf 1
Kp = 30;
c1 = feedback(Kp*G,1)
step(c1)

%% PID Controller
Kp = 0.6*Kcr;
T1 = 0.5*Pcr;
Td = 0.125*Pcr;
C = Kp*(1 + 1/(T1*s) + Td*s)

%% Simulation with PID
c1_tf = feedback(C*G,1);
figure(2)
plot(t,y,'r');
hold on
step(c1_tf,'g')
