%--------------------------------------------------------------------------
% Created: 9/2/13 by William J. Ebel
% 
% Revision History: 
%       Date        Reason
%      9/5/18     Added an abs() function to construct T.  This allows the
%                 time vector to be time reversed at the call with a proper
%                 time reversal of the result. 
% 
% Purpose: This function simply delays the input signal by the appropriate
%   time delay.  It is assumed that the signal x is zero outside the time
%   range given by the input time vector.  
% 
% Variables: 
%   t   - (input) time vector
%   x   - (input) the samples vector
%   tau - (input) delay (sec) of the input signal x.  A positive tau shifts
%         x to the right.  A negative tau shifts x to the left.
%
%   y   - (output) the samples vector (paired with input vector t)
%   tau - (output) the acutal delay required to be an integer multiple of T
% 
% function [y,tau] = delay(t,x,tau)
%--------------------------------------------------------------------------
function [y,tau] = delay(t,x,tau)

y = [];
if isempty(t)
	disp('*** ERROR in delay, the input time vector is empty');
	return
end
if length(t) == 1
	disp('*** ERROR in delay, you must have length(t) > 1.');
	return
end

T = abs(t(2)-t(1));
Itau = round(tau/T);

y = zeros(1,length(x));
if Itau >= 0
  y(Itau+1:end) = x(1:end-Itau);
elseif Itau < 0
  y(1:end+Itau) = x(1-Itau:end);
end

tau = Itau*T;

end