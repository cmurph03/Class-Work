%-------------------------------------------------------------
% Created: 10/21/2021 by Caroline Murphy
%
% Revision History: None
%
% Purpose: This script tests the AMdemod function and compares the results 
%   to the original signal before the AMmod and makeRF functions were used.
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

load('myRF');
rolloff = 10;
[fc,BW,xi] = RFparams(5);
 
z1 = AMdemod(t,RF,fc(1),BW(1),rolloff);
z2 = AMdemod(t,RF,fc(2),BW(2),rolloff);
z3 = AMdemod(t,RF,fc(3),BW(3),rolloff);
 
load storysideB;
[y1, xLPF1] = AMmod(t,x1,fc(1),BW(1),rolloff);
[y2, xLPF2] = AMmod(t,x3,fc(2),BW(2),rolloff);   
[y3, xLPF3] = AMmod(t,x2,fc(3),BW(3),rolloff);

err1 = rmse(z1,xLPF1);
err2 = rmse(z2,xLPF2);
err3 = rmse(z3,xLPF3);

error = [err1, err2, err3];
errorTable = table(error);

% myplay(t,z1,4);
% myplay(t,z2,4);
% myplay(t,z3,4);
%sounds muffled
