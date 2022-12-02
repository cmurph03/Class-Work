%--------------------------------------------------------------------------
% Created: 12/2/12 by William J. Ebel
% 
% Revision History:   None
% 
% Purpose: This function creates a triangle function for the given input
%   time vector.  The triangle function has a base width of 2 and is unity
%   at t = 0. 
% 
% Variables: 
%   t - (input) time vector
%   y - (output) sinc samples vector (corresponds to the input t vector)
% 
% function y = triangle(t)
%--------------------------------------------------------------------------
function y = triangle(t)

y = [];
if length(t) <= 1
	disp('*** ERROR in triangle. The input time vector has insufficient length.')
	return
end

if (min(t) > -1) || (max(t) < 1)
	disp('*** WARNING in triangle. The triangle signal has been truncated.')
end

% Construct the triangle signal
y = ones(1,length(t));
y = y-abs(t);
y(y<0) = 0;

end