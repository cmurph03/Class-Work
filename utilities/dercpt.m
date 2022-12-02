%--------------------------------------------------------------------------
% Created: 9/11/12 by William J. Ebel
% 
% Revision History: 
%       Date        Reason
%      9/5/18     Added an abs() function to construct T.  This allows the
%                 time vector to be time reversed at the call with a proper
%                 time reversal of the result. 
% 
% Purpose: This function returns the first-order backward difference of the
%   input vector.  This is an approximation to the continuous-time
%   derivative of the continuous-time approximation of the input signal. 
% 
% Variables: 
%   t  - input time vector
%   x  - input samples vector
%   t0 - time at which the derivative is desired
%
%   y - output first order backward difference at time t0
% 
% function y = dercpt(t,x,t0)
%--------------------------------------------------------------------------
function y = dercpt(t,x,t0)

y = [];
if isempty(t)
	disp('*** ERROR in dercpt, the input time vector is empty');
	return
end
if length(t) == 1
	disp('*** ERROR in dercpt, you must have length(t) > 1.');
	return
end

T = abs(t(2)-t(1));
n = round(t/T);

n0 = round(t0/T);
II = find(n == n0);

if II > 1;  y = x(II) - x(II-1);
else        y = x(II);
end

end