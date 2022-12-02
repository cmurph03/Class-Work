%--------------------------------------------------------------------------
% Created: 9/17/12 by William J. Ebel
% 
% Revision History: 
%       Date        Reason
%      9/5/18     Added an abs() function to construct T.  This allows the
%                 time vector to be time reversed at the call with a proper
%                 time reversal of the result. 
% 
% Purpose: This function simply time reverses the input signal.  The time
%   vector for the output signal is the same as for the input signal.  
%   Therefore, care needs to be taken that the reversed signal does not go
%   outside the range of the time vector. 
% 
% Variables: 
%   t   - input time vector
%   x   - input signal vector
%   y   - output signal vector (goes with vector t)
% 
% function y = reverse(t,x)
%--------------------------------------------------------------------------
function y = reverse(t,x)

y = [];
if length(t) <= 1
	disp('*** ERROR in reverse. The input time vector has insufficient length.')
	return
end
if (max(t) <= 0) || (min(t) > 0)
	disp('*** WARNING in reverse');
  disp('    ... the time vector is one-sided, the output vector is zero.')
end

% time reverse the time vector
T = abs(t(2) - t(1));
n = round(t/T);
ny = -n(end:-1:1);

% Set y to zero
y = zeros(1,length(x)); 

% Reverse the appropriate part of x and place in y
if n(1) < ny(1)
  I0 = find(abs(n-ny(1)) == min(abs(n-ny(1))));  I0 = I0(1);
  y(I0:end) = x(end:-1:I0);
elseif n(end) >= ny(end)
  I0 = find(abs(n-ny(end)) == min(abs(n-ny(end))));  I0 = I0(1);
  y(1:I0) = x(I0:-1:1);
end

end