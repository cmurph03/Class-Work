%--------------------------------------------------------------------------
% Created: 9/11/12 by William J. Ebel
% 
% Revision History: 
%        Date       Reason
%      9/20/12    Changed the 'find' check to operate on the index
%                 vector n rather than the double time vector t.  This
%                 eliminates roundoff error problems. 
%      10/3/12    If the time index n == 0 does not exist, then the
%                 zero dcV should be returned.  This was added. 
%      10/6/15    Added a check to see if t = 0 exists, if it doesn't, an
%                 error is generated because the time vector does not
%                 span the delta function location.  This has been an
%                 issue for the echo cancellation project. 
%      9/5/18     Added an abs() function to construct T.  This allows the
%                 time vector to be time reversed at the call with a proper
%                 time reversal of the result. 
% 
% Purpose: This function returns a discrete-time approximation to the
%   continuous-time delta function.  The delta function is approximated by
%
%       delta_epsilon(t) = (1/epsilon)PI(t/epsilon)
%
%   where epsilon = T (the sample time).  By approximating the delta
%   function this way, when this signal is sampled, it will result in a
%   single sample of size 1/T.  In this way, the delta function weight
%   times the sample time gives the correct delta function weight of 1. 
% 
% Variables: 
%   t - input time vector
%   dV - output delta function vector
% 
% function dV = dc(t)
%--------------------------------------------------------------------------
function dV = dc(t)

dV = [];
if length(t) <= 1
  disp('*** ERROR in dc. The input time vector has insufficient length')
  return
end

% Construct the index vector from the time vector
T = abs(t(2)-t(1));
n = round(t/T);

II = find(n == 0);

if isempty(II)
	disp('*** ERROR in dc. The delta function is outside the time vector.')
elseif length(II) > 1
	disp('*** WARNING in dc. Multiple locations found for the delta function.')
  II = II(1);
end

dV = zeros(1,length(t));
dV(II) = 1/T;

end