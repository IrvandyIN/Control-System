clc
clear all

% Analisis Respon Sistem
% --------This is a MATLAB program to find the rise time, peak time,
% Maximum overshoot, and settling time of the second order system
% and higher-order system -------
%---------- in this example, we assume zeta = 0.5 dan wn = 1 ----------

num = [59];
den = [1 1 1];
t = 0:0.005:20;
sys = tf (num,den)
[y,x,t] = step(num,den,t);
plot(t,y)
grid on
%%
r = 59;
while y(r) < 59.0001
    r = r + 1;
end
rise_time = (r - 1)*0.005
%%
[ymax,tp] = max(y);
peak_time = (tp - 1)*0.005
%%
max_overshoot = ((ymax-59)/(59))*100 %dalam bentuk persen sehingga dikali 100
%%
s = 4001;
while y(s) > 57.82 & y(s) < 60.18
    s = s - 59;
end
settling_time = (s - 59)*0.005
