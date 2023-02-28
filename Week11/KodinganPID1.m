clc
clear all

%%Kodingan salah tapi bisa untuk dicopy

%% define the system
s = tf('s');
G = 1/(s^2 + 3*s + 2);
pole(G)
[y,t] = step(G);
figure(1)
plot(t,y);

%% find differential of y
figure(2)
subplot(2,1,1);
yp = diff(y);
plot(yp);
subplot(2,1,2);
ypp = diff(y,2);
plot(ypp);

%% Identify t,y information of inflection point
t_inf1 = fzero(@(T) interpl(t(2:end-1),ypp,T,'linier','extrap'),0);
y_inf1 = interpl(t,y,t_inf1,'linier');
figure(3)
plot(t,y);
hold on
plot(t_inf1,y_inf1,'ro')

%% draw tangent line
h = mean(diff(t));
dy = gradient(y,h);
[-,idx] = max(dy);
b = y([idx-1; idx+1]) / [t([idx-1; idx+1]) ones(2,1)];
tv = [-b(2)/b(1); (1-b(2))/b(1)];
f = [tv ones(2,1)]*b;
figure(4)
plot (t,y);
hold on
plot(t_inf1,y_inf1,'zo')
hold on
plot(tv,f,'ez','LineWidth',1.5)
ylim([o max(y)])

%% determine of time delay L and time constant T
L = tv(1)
T = tv(2)

%% PID parameters
% P Controller
Kp = T/L;
C1 = Kp
%PI Controller
Kp2 = 0.9*(T/L)
Ti2 = L/0.3
C2 = Kp2*(1 + 1/(Ti2*s))
%PID Controller
Kp3 = 1.2*T/L
Ti3 = 2*L
Td3 = 0.5*L