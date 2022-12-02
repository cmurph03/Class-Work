%-------------------------------------------------------------
% Created: 12/03/2021 by Caroline Murphy
%
% Revision History: None
%
% Purpose:  
%   This script is to test the myimpresp function with two different T
%   values.
%
%   Variables:
%   th - impulse response time vector
%   h - impulse response
%   b - filter coefficients for x[n]
%   a - filter coefficients for y[n]
%   T - sample time for th
%   
%
%
%-------------------------------------------------------------

[b,a,T,fV] = mycoeff(11);

Z = roots(b); %zeros
P = roots(a); %poles
figure(1); 
plotPZ(Z,P);
title('Pole-Zero Constellation of H(z)');


[th,h] = myimpresp(b,a,T,1);
figure(2);
myFT(th,h,'plot');
figure(3)
[fb,fs] = filter_transition(th,h,1,'bandpass',0.93,0.12,1);

T = 1/44100;
[th,h] = myimpresp(b,a,T,1);
figure(4);
myFT(th,h,'plot');
figure(5)
[fb,fs] = filter_transition(th,h,1,'bandpass',0.93,0.12,1);

