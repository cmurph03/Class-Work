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
% Purpose: This function returns a sampled version of the continuous-time
%   unit-step function.  The value of the unit step at t = 0 is 1.
% 
% Variables: 
%   t  - (input) time vector
%   uV - (output) the unit step vector (paired with the input time vector)
% 
% function uV = uc(t)
%--------------------------------------------------------------------------
function uV = uc(t)

uV = [];
if length(t) <= 1
	disp('*** ERROR in uc.  The input time vector has insufficient length')
	return
end

T = abs(t(2)-t(1));
uV = zeros(1,length(t));
n = round(t/T);
uV(n >= 0) = 1;

end
