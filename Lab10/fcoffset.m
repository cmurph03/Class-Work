%-------------------------------------------------------------
% Created: 11/2/2021 by Caroline Murphy
%
% Revision History: None
%
% Purpose: This script explores the effect using the wrong carrier
% frequency to demodulate a signal
%   
%   Variables:
%   y - output AM signal
%   t - time vector for signal
%   fc - carrier frequencies
%   BW - bandwidths
%   xi - xV signal index
%   rmseV - vector to store calculated errors
%   xV - vector storing possible song vectors
%   z - demodulated signal
%   
%
%-------------------------------------------------------------

load('myRF');
rolloff = 10;
[fc,BW,xi] = RFparams(5);

offset = 0:100:1000; 
rmseV = zeros(1,11);
i = 1;
load storysideB;
[y2, xLPF2] = AMmod(t,x3,fc(2),BW(2),rolloff);   

for dfc = offset
    
    z2 = AMdemod(t,RF,(fc(2)+dfc),BW(2),rolloff);
    %myplay(t,z2);
    rmseV(i) = rmse(z2,xLPF2);
    i = i+1;
end

plot(offset, rmseV);
xlabel('Carrier Frequency Offset (Hz)');
ylabel('Percent error');
title('Error of Demodulation Given Carrier Frequency Offset');

%start hearing interfernce/static noise as the offset increases
