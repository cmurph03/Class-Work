%--------------------------------------------------------------------------
% Created: 10/8/20 by William J. Ebel (All Rights Reserved)
% 
% Revision History:   None
% 
% Purpose: This function sets the transient to zero at the same time that
%   the rest of the signal is forced to have zero DC.  
% 
% Variables: 
%   t   - (input) the time vector
%   x   - (input) the signal samples vector (paired with t)
%   tau - (input) the transient duration in seconds
%   y   - (output) the input signal with the start/end transients set to
%                  zero and the inner section of the signal set to zero DC
% 
% function y = transient_zero(t,x,tau)
%--------------------------------------------------------------------------
function y = transient_zero(t,x,tau)

y = [];
if ~isequal(size(t),size(x))
  disp('*** ERROR in transient_zero.  The input signal vectors are not the same length.');
  return;
end
if tau < 0
  disp('*** ERROR in transient_zero.  The input tau must be positive.');
  return;
end
if tau > (max(t)-min(t))/20
  disp('*** ERROR in transient_zero.  The input tau is too large.');
  return;
end

T = t(2)-t(1);
I0 = floor(tau/T);     % number of samples for the transient

y = x;
y(1:I0)         = 0;   % zero the start transient
y(end-I0+1:end) = 0;   % zero the end transient

% set DC to zero for the inner section of the signal
%y(I0+1:end-I0) = y(I0+1:end-I0) - mean(y(I0+1:end-I0));

end