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
%   t - input time vector
%   y - output the unit step vector
% 
% function y = derc(t,x)
%--------------------------------------------------------------------------
function y = derc(t,x)

y = [];
if isempty(t)
	disp('*** ERROR! In derc.m, the input time vector is empty');
	return
end
if length(t) == 1
	disp('*** ERROR! In derc.m, you must have length(t) > 1.');
	return
end

T = abs(t(2)-t(1));

% Find the derivative using the first order backward difference
y = zeros(1,length(x));
y(2:end) = (x(2:end) - x(1:end-1))/T;
y(1) = x(1)/T;

end