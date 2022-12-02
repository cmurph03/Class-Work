%--------------------------------------------------------------------------
% Created: 11/28/12 by William J. Ebel (All Rights Reserved)
% 
% Revision History: 
%           Date                Reason
% 
% Purpose: This function returns the crosscorrelation function between two
%   signals.  This function works even if the second function is shorter
%   than the first.  
% 
% Variables: 
%   tx - input time vector associated with the signal vector x
%   x  - input sample vector
%   ty - input time vector associated with the signal vector y
%   y  - input sample vector
%   epsilon - Tolerance to check whether the sample times are the same
%
%   tR - output time vector of delays associated with R
%   R  - output crosscorrelation vector
% 
% function [tR,R] = Rxy(tx,x,ty,y,epsilon)
%--------------------------------------------------------------------------
function [tR,R] = Rxy(tx,x,ty,y,epsilon)

if nargin < 5; epsilon = 1e-5; end

R = [];
if length(tx) <= 1
	disp('*** ERROR in Rxy, tx has insufficient length');
	return
end
if length(tx) ~= length(x)
	disp('*** ERROR in Rxy, tx and x are not the same length.')
	return
end
if length(ty) <= 1
	disp('*** ERROR in Rxy, ty has insufficient length');
	return
end
if length(ty) ~= length(y)
	disp('*** ERROR in Rxy, ty and y are not the same length.')
	return
end

Tx = tx(2)-tx(1);
Ty = ty(2)-ty(1);
if abs(Tx-Ty)/Tx > epsilon
	disp('*** ERROR in Rxy, the sample times for tx and ty are not equal')
	return
end

% Time reverse y
ty = -ty(end:-1:1);
y = y(end:-1:1);

% Create centered versions of each time vector
N2 = round((length(tx)-1)/2);
nx0 = -N2:length(tx)-N2-1;
tx0 = nx0*Tx;

N2 = round((length(ty)-1)/2);
ny0 = -N2:length(ty)-N2-1;
ty0 = ny0*Tx;

R = myconv(tx0,x,ty0,y);
tR = tx0;

end
