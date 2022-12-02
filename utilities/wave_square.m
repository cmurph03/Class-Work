%--------------------------------------------------------------------------
% Created: 9/17/12 by William J. Ebel
% 
% Revision History: 
%      Date                Reason
%    10/3/2012    Use the Time Index vector and force T0 = k*T for 
%                 integer k to ensure that the square wave signal does
%                 not run into ambiguity problems. 
%     10/6/15     Added variable checks to give the user more feedback
%      9/5/18     Added an abs() function to construct T.  This allows the
%                 time vector to be time reversed at the call with a proper
%                 time reversal of the result. 
% 
% Purpose: This function returns a sampled version of the continuous-time
%   square wave function with specified period and duty cycle. 
%
%   This function forces T0 to be an integer multiple of T.  This will
%   avoid an issue that can occur at the transition points of the square
%   wave.  Likewise, the duty cycle will create a pulse width that is also
%   forced to be an integer multiple of T.  If T is small relative to the
%   width of each pulse, this should not present a problem with usage. 
% 
% Variables: 
%   t   - input time vector
%   T0  - squarewave period
%   dutycycle - Duty cycle of the square wave.  Must be between 0 and 1.
%               The squarewave pulse width is: 
%                         pulse width = T0*dutycycle
% 
% function y = wave_square(t,T0,dutycycle)
%--------------------------------------------------------------------------
function y = wave_square(t,T0,dutycycle)

y = [];
if length(t) <= 1
	disp('*** ERROR in wave_square. The time vector has insufficient length')
	return
end
if nargin < 2;  T0 = 1;  end
if nargin < 3;  dutycycle = 1/2;  end

if (dutycycle < 0) || (dutycycle > 1)
  disp('*** ERROR in wave_square. must have 0 < dutycycle <= 1.')
	return
end

% Construct the time index vector
T = abs(t(2)-t(1));
n = round(t/T);

% Force the period and pulse width to be an integer multiple of T
nT0 = round(T0/T);

if length(t) < nT0
	disp('*** WARNING in wave_square. Time vector spans less than 1 period.')
end

nmod = mod(n,nT0);
ntau = round(nT0*dutycycle);

y = -ones(1,length(t));   % Default the output to -1
y(nmod < ntau) = 1;       % Set the pulses to 1

end