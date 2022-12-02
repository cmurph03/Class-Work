%-------------------------------------------------------------
% Created: 10/21/2021 by Caroline Murphy
%
% Revision History: None
%
% Purpose: This script generates and saves an RF signal containing 3 song 
%   snippets.
%   
%   Variables:
%   y - output AM signal
%   t - time vector for signal
%   fc - carrier frequencies
%   BW - bandwidths
%   xi - xV signal index
%   yV - vector to store generated y vectors
%   xV - vector storing possible song vectors
%   RF = Resultant radio frequency
%   
%
%-------------------------------------------------------------

load storysideB;
rolloff = 10;
[fc,BW,xi] = RFparams(5);
RF = 0;
for i = 1:1:3
    if xi(i) == 1
        x = x1;
    elseif xi(i)==2
        x = x2;
    elseif xi(i)==3
        x=x3;
    elseif xi(i)==4
        x=x4;
    elseif xi(i)==5
       x=x5; 
    end

    [y, xLPF] = AMmod(t,x,fc(i),BW(i),rolloff);
    RF = RF + y;
end

save('myRF', 't', 'RF');