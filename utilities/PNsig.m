%--------------------------------------------------------------------------
% Created: 11/28/12 by William J. Ebel
% 
% Revision History: 
%       Date        Reason
%      9/5/18     Added an abs() function to construct T.  This allows the
%                 time vector to be time reversed at the call with a proper
%                 time reversal of the result. 
% 
% Purpose: This function generates a pseudo-noise signal. 
%
% Variables: 
%   t     - (input) time vector, in seconds
%   Tchip - (input) time, in seconds, for each PN chip
%
%   y     - output signal (pseudo-noise)
% 
% function y = PNsig(t,Tchip)
%--------------------------------------------------------------------------
function y = PNsig(t,Tchip)

y = [];
if length(t) <= 1
	disp('*** ERROR in PNsig, the input time vector has insufficient length')
	return
end

if nargin < 2; Tchip = 1; end

rand('twister',sum(100*clock));

T = abs(t(2)-t(1));  % sample time
n = round(t/T);      % index time vector
n = n - n(1);        % set the starting index to zero
Nn = length(n);      % find the number of time samples

Nchip = round(Tchip/T);                 % samples/chip, force it to be an integer
Nchips = floor((max(n)-min(n))/Nchip);  % Find the number of chips
Ichip  = find(rand(1,Nchips) < 1/2);    % Starting index for each -1 chip
n0chip = round((Ichip-1)*Nchip);        % find the starting position of each -1 chip

y = ones(1,Nn);             % Initialize the output signal vector
I0 = n0chip+1;              % Initialize the -1 chip index vector
y(I0) = -1;
for k0 = 1:Nchip-1
  y(I0+k0) = -1;
end

end