clc
clear all
close all


%% Mencari persamaan polinomial
i = sqrt(-1)
% r = [-5 -2.5 -0.1]
% r = [-10 5 -0.2]%Asli
% r = [-10 -5 -0.2]%Asli new
r = [-6 3 -0.2]%Asli new 2
ak = poly(r)

%%
num = [1];
den = [1 3.2 -17.4 -3.6]; 
[A,B,C,D] = tf2ss(num,den)
%%
Ahat = [ A zeros(3,1) 
        -C	0 ]
Bhat = [B
        0]
%%
J = [-1+j*sqrt(2) -1-j*sqrt(2) -6 -6];
Khat = acker(Ahat,Bhat,J)
K = Khat(1,1:3)
kI = -Khat(1,4)

%%
AA = [ A-B*K B*kI
        -C   0 ]
BB = [0
      0
      0
      1];
CC = [C 0];
DD = [0];

%%
t = 0:0.005:10;
[y,x,t] = step(AA,BB,CC,DD,1,t);

x1 = [1 0 0 0]*x';
x2 = [0 1 0 0]*x';
x3 = [0 0 1 0]*x';
x4 = [0 0 0 1]*x';
subplot(2,2,1); plot(t,x1); grid
title('x1 versus t')
xlabel('t Sec'); ylabel('x1')
subplot(2,2,2); plot(t,x2); grid
title('x2 versus t')
xlabel('t Sec'); ylabel('x2')
subplot(2,2,3); plot(t,x3); grid
title('x3 versus t')
xlabel('t Sec'); ylabel('x3')
subplot(2,2,4); plot(t,x4); grid
title('x4 versus t')
xlabel('t Sec'); ylabel('x4')

%% Grafik ketika open loop
sys = tf (num,den)
t = 0:0.005:10;
[y,x,t] = step(num,den,t);
plot(t,y)
grid on
title('Respon Open Loop')


%%
r = 1;
while x3(r) < 1.0001
    r = r + 1;
end
rise_time = (r - 1)*0.005

%%
d = 1;
while x3(d) < 0.5
     d = d+1;
end
delay_time = (d-1)*0.005
%%
[ymax,tp] = max(x3);
peak_time = (tp - 1)*0.005
%%
max_overshoot = ((ymax-1)/(1))*100 %dalam bentuk persen sehingga dikali 100
%%
s = 2001;
while x3(s) > 0.98 & x3(s) < 1.02
    s = s - 1;
end
settling_time = (s - 1)*0.005