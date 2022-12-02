%--------------------------------------------------------------------------
% Created: 9/11/12 by William J. Ebel
% 
% Revision History: 
%        Date       Reason
%      9/20/12    Changed the 'find' check to operate on the index
%                 vector n rather than the double time vector t.  This
%                 eliminates roundoff error problems. 
%      9/5/18     Added an abs() function to construct T.  This allows the
%                 time vector to be time reversed at the call with a proper
%                 time reversal of the result. 
% 
% Purpose: This function returns a sampled verions of the continuous-time
%   unit-ramp function with a left shift of the sample time.  The reason
%   the left shift is introduced is so that the intc and derc functions
%   when used with this ramp signal will result in the correct function. 
% 
% Variables: 
%   t  - (input) time vector
%   rV - (output) the unit ramp vector (paired with the input vector t)
% 
% function rV = rc(t)
%--------------------------------------------------------------------------
function rV = rc(t)

rV = [];
if length(t) <= 1
	disp('*** ERROR in rc. The input time vector has insufficient length.')
	return
end

T = abs(t(2)-t(1));
rV = t+T;

n = round(t/T);

if max(n) <= 0
	disp('*** WARNING in rc. The time vector does not overlap the ramp line.')
end

rV(n < 0) = 0;

end