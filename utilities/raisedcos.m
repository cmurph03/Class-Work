%--------------------------------------------------------------------------
% Author: William J. Ebel
% Created: 8/24/2015
% Revision History: 
%       Date        Reason
%      9/5/18     Made the raised cosine function default to go over the
%                 time range [-1/2,1/2]
%
% Purpose: This creates a raised-cosine pulse function. 
%
% Variables:
%   t : (input) Time vector over which the window is defined
%   x : (output) The raised cosine time-window samples vector (paired with t)
% 
% function x = raisedcos(t)
%--------------------------------------------------------------------------
function x = raisedcos(t)

x = [];
if length(t) < 2
  disp('*** ERROR in raisedcos.  The time vector must have length greater than 2');
  return;
end
if (min(t) > -1/2) || (max(t) < 1/2)
  disp('*** WARNING in raisedcos.  The time vector does not span [-1/2,1/2]');
end

x = pif(t).*(1+cos(2*pi*t))/2;

end


%--------------------------------------------------------------------------
% Created: 9/11/12 by William J. Ebel
% 
% Revision History: 
%        Date       Reason
%      10/6/15    Added a check to see if the time vector fully supports
%                 the placement of the pi function.  If there is partial
%                 overlap, a warning is issued.  If there is NO overlap
%                 then an error occurs. 
%      9/5/18     Added an abs() function to construct T.  This allows the
%                 time vector to be time reversed at the call with a proper
%                 time reversal of the result. 
% 
% Purpose: This function returns a discrete-time approximation to the
%   continuous-time PI function.  This is constructed so the output is 1 at
%   the discontinuity points which occur at t = -1/2 and t = 1/2. 
% 
% Variables: 
%   t - (input) time vector
%   y - (output) the pi function (paired with the input time vector t)
% 
% function y = pif(t)
%--------------------------------------------------------------------------
function y = pif(t)

y = [];
if length(t) <= 1
	disp('*** ERROR in raisedcos. The input time vector has insufficient length')
	return
end

% Find the time index vector
T = abs(t(2)-t(1));
n = round(t/T);

% Find the time indexs corresponding to the interval t = [-1/2,1/2]
n0 = round((-1/2)/T);
n1 = round((1/2)/T);

% Ensure that the end points are within the time index vector n
if (n0 > n(end)) || (n1 < n(1))
  disp('*** ERROR in raisedcos. The time vector does not span the pi function.')
  return
end
max0 = min(-min(t),max(t));
if max0 < 1/2
  disp('*** WARNING in raisedcos. The pi function has been truncated.')
end

% Construct the PI function
y = zeros(1,length(t));
if n1 >= n0
	I0 = max(1-n(1)+n0,1);
  I1 = min(1-n(1)+n1,length(t));
	y(I0:I1) = 1;
end

end