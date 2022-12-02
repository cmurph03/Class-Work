%--------------------------------------------------------------------------
% Created: 9/17/12 by William J. Ebel
% 
% Revision History: 
%     10/2/13   Corrected the small argument approximation
% 
% Purpose: This function returns a sampled version of the continuous-time
%   sinc function, defined by:
%
%       sinc(t) = sin(pi*t)/(pi*t)
% 
% Variables: 
%   t - input/output time vector
%   y - output sample vector of the sinc signal
% 
% function y = sinc(t)
%--------------------------------------------------------------------------
function y = sinc(t)

y = [];
if length(t) <= 1
	disp('*** ERROR in sinc. The input time vector has insufficient length')
	return
end
max0 = min(-min(t),max(t));
if max0 < 1
	disp('*** WARNING in sinc. The main lobe has been truncated')
end

y = zeros(1,length(t));

I0 = find(abs(t) >= 0.00001);
y(I0) = sin(pi*t(I0))./(pi*t(I0));

I1 = find(abs(t) < 0.00001);
t0 = t(I1);
y(I1) = 1 - pi*pi*t0.*t0/6 + (pi^4)*t0.*t0.*t0.*t0/120;

end
