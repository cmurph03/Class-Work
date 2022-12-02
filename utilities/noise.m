%--------------------------------------------------------------------------
% Created: 1/25/13 by William J. Ebel
% 
% Revision History: None
% 
% Purpose: This function creates a gaussian noise signal with zero mean and
%   with the standard deviation, stdv, set by the user.  If stdv is not
%   set, then it is set to 1.  
% 
% Variables: 
%   t    - (input) time vector
%   stdv - (input) standard deviation of the gaussian noise
%
%   n    - (output) gaussian noise samples (paired with input vector t) 
% 
% function n = noise(t,stdv)
%--------------------------------------------------------------------------
function n = noise(t,stdv)

y = [];
if length(t) <= 1
	disp('*** ERROR in noise, the input time vector has insufficient length')
	return
end

if nargin < 2; stdv = 1; end

rand('twister',sum(100*clock));
N = length(t);

n = stdv*randn(1,N);

end
