clc 
clear all 
close all 
% Contoh 2.3 
% 
num = [ 0 350 80000]; 
den = [ 250 350 80000]; 
% 
sys1 = tf(num,den) 
[z,p,k] = residue(num,den) 