%--------------------------------------------------------------------------
% Created: 8/31/13 by William J. Ebel
% 
% Revision History: None
% 
% Purpose: This function returns a subset of the input signal.  This is
%   useful for sizing a signal appropriately for a subsequent operation. 
% 
% Variables: 
%   t - (sec) input time vector
%   x - input samples vector
%   a - (sec) left side of the time interval
%   b - (sec) left side of the time interval
%
%   y - output samples vector (pairs with the input t vector)
% 
% function [ty,y] = subsig(t,x,a,b)
%--------------------------------------------------------------------------
function [ty,y] = subsig(t,x,a,b)

% Check for illegal conditions on the input arguments
y = [];
if length(t) <= 1;  return;  end
if length(t) ~= length(x)
	disp('*** ERROR in subsig. t and x are not the same dimension.')
	return
end
if nargin < 4
	disp('*** ERROR in subsig.m, the full interval is not specified.')
	return
end

% Force the time interval left-side to be less than the right-side
if (a > b); c = a; a = b; b = c; end

% Convert the time vector into an index vector
T = t(2)-t(1);
n = round(t/T);

% Determine the index range for the subsignal to extract
na = round(a/T);
nb = round(b/T);

% Check for out of bound conditions
if na < n(1)
	disp(['*** WARNING in subsig, the left-side is out of bounds, setting to ' num2str(t(1))])
	na = n(1);
end
if nb > n(end)
	disp(['*** WARNING in subsig, the right-side is out of bounds, setting to ' num2str(t(end))])
	nb = n(end);
end

% Construct the subsignal
II = 1-n(1)+(na:nb);
y  = x(II);
ty = t(II);

end