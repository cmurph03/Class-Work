%--------------------------------------------------------------------------
% Created: 9/11/12 by William J. Ebel
% 
% Revision History: 
%       Date        Reason
%      9/5/18     Added an abs() function to construct T.  This allows the
%                 time vector to be time reversed at the call with a proper
%                 time reversal of the result. 
% 
% Purpose: This function returns the accumulated sum of the input vector.
%   This is an approximation to the continuous-time integral of the
%   continuous-time approximation of the input signal. 
% 
% Variables: 
%   t - input time vector
%   y - output the unit step vector
% 
% function y = intc(t,x)
%--------------------------------------------------------------------------
function y = intc(t,x)

y = [];
if isempty(t)
	disp('*** ERROR in intc, the input time vector is empty');
	return
end
if length(t) == 1
	disp('*** ERROR in intc, you must have length(t) > 1.');
	return
end

T = abs(t(2)-t(1));
y = T*cumsum(x);

end