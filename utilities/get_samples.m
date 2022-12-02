%--------------------------------------------------------------------------
% Created: 10/25/17 by William J. Ebel
% 
% Revision History: 
%       Date        Reason
%      9/5/18     Added an abs() function to construct T.  This allows the
%                 time vector to be time reversed at the call with a proper
%                 time reversal of the result. 
% 
% Purpose: This function returns one or more sample values from a signal
%   that are specified by their time values.  If the time values are not in
%   the time vector exactly, the closest time vector values are chosen and
%   the sample values of those time values returned. 
% 
% Variables: 
%   t  - input time vector
%   x  - input samples vector (paired with t)
%   tV - time at which the samples are desired
%
%   y - samples from the signal {t,x} that correspond to tV
% 
% function y = get_samples(t,x,tV)
%--------------------------------------------------------------------------
function y = get_samples(t,x,tV)

y = [];
if ~isequal(size(t),size(x))
	disp('*** ERROR in get_samples.  The time vector and samples vector are not the same dimension.');
	return
end
if nargin < 3
	disp('*** ERROR in get_samples.  The input tV is missing from the argument list.');
	disp(' ... this function has the following form:');
  disp('        y = get_samples(t,x,tV)');
	return
end
if isempty(tV)
	return
end
if (min(tV) < min(t)) || (max(tV) > max(t))
	disp('*** ERROR in get_samples.  The time vector tV has samples out of bounds.');
	return
end  

% Find the sample time and the index vector
T = abs(t(2)-t(1));
n = round(t/T);

% Find the indexes that correspond to the time vector tV
nV = round(tV/T) - n(1) + 1;

% Extract the samples based on the vector indexes
y = x(nV);

end