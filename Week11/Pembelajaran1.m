clc
clear all

%% define the system
s = tf('s');
G = 1/(s^2 + 7*s + 10);
pole(G)
[y,t] = step(G);
figure(1)
plot(t,y);

%% find differential of y (menurunkan y nya)
figure(2)
subplot(2,1,1); %gambar (yp) akan disimpan di 2,1,1, pada bagian atas
yp = diff(y); %sinyal (y) yg didapatkan diturunkan satu kali
plot(yp);
%inflection point berada pada ujung

subplot(2,1,2); %gambar (ypp) berada di bawah
ypp = diff(y,2); %sinyal (y) yg didapatkan diturunkan dua kali
plot(ypp);
%inflection point berada pas di persinggungan di 0

%% identify t,y information of inflection point
t_inf1 = fzero(@(T) interp1(t(2:end-1),ypp,T,'linear','extrap'),0);
y_inf1 = interp1(t,y,t_inf1,'linear');
figure(3)
plot(t,y);
hold on
plot(t_inf1,y_inf1,'ro')

%% draw tangent line
h = mean(diff(t)); %rata2 dari turunan t nya
dy = gradient(y,h); %ambil nilai gradiennya
[~,idx] = max(dy);
b = [t([idx-1; idx+1]) ones(2,1)] \ y([idx-1; idx+1]);
tv = [-b(2)/b(1); (1-b(2))/b(1)];
f = [tv ones(2,1)]*b;
figure(4)
plot (t,y);
hold on
plot(t_inf1,y_inf1,'ro') %inflection point
hold on
plot(tv,f,'-r','LineWidth',1.5) %tangent line ditentukan dari tv dan f nya
ylim([0 max(y)])

%% determine of time delay L and time constant T
L = tv(1)
T = tv(2)

%% PID parameter
%P Controller
Kp = T/L;
C1 = Kp
%PI Controller
Kp2 = 0.9*(T/L)
Ti2 = L/0.3
C2 = Kp2*(1+1/(Ti2*s))
%PID Controller
Kp3 = 1.2*T/L
Ti3 = 2*L
Td3 = 0.5*L
C3 = Kp3*(1+1/(Ti3*s)+Td3*s)

%% Closed loop response
%with controller P
c1_tf1 = feedback(C1*G,1)
%with controller PI
c1_tf2 = feedback(C2*G,1)
%with controller PID
c1_tf3 = feedback(C3*G,1)
%1 adalah unity feedback artinya tidak ada sistem tambahan pada blok diagra

%pole (c1_tf3)
figure(5)
plot(t,y,'r');
hold on
step(c1_tf1,'g')
hold on
step(c1_tf2,'y')
hold on
step(c1_tf3)
grid on