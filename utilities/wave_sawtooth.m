%--------------------------------------------------------------------------
% Created: 9/17/12 by William J. Ebel
% 
% Revision History: 
%       Date      Reason
%     10/6/15    Added variable checks to give the user more feedback
%      9/5/18    Added an abs() function to construct T.  This allows the
%                time vector to be time reversed at the call with a proper
%                time reversal of the result. 
% 
% Purpose: This function returns a sampled version of the continuous-time
%   sawtooth wave function with specified period. 
% 
% Variables: 
%   t   - input time vector
%   T0  - squarewave period
% 
% function x = wave_sawtooth(t,T0)
%--------------------------------------------------------------------------
function x = wave_sawtooth(t,T0)

x = [];
if length(t) <= 1
	disp('*** ERROR in wave_sawtooth. The time vector has insufficient length.')
	return
end
if nargin < 2;  T0 = 1;  end

% Construct the time index vector
T = abs(t(2)-t(1));
n = round(t/T);

% Force the period to be an integer multiple of T
nT0 = round(T0/T);

if length(t) < nT0
	disp('*** WARNING in wave_sawtooth. Time vector spans less than 1 period.')
end

% Construct the sawtooth
x = zeros(1,length(t));
nmod = mod(n,nT0);
tmod = T*nmod;

x = (1/T0)*tmod;

end