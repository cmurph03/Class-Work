%-------------------------------------------------------------
% Created: 12/03/2021 by Caroline Murphy
%
% Revision History: None
%
% Purpose:  
%   This function creates an impulse response when given the coefficients,
%   sample time, and time span of difference equation.
%
%   Variables:
%   th - output time vector
%   h - impulse response
%   b - filter coefficients for x[n]
%   a - filter coefficients for y[n]
%   T - sample time for th
%   tspan - time span for th vector
%
%
%-------------------------------------------------------------

function [th,h] = myimpresp(b,a,T,tspan)
th = [];
h = [];

if (T < 0)
   disp('Sample time must be greater than 0'); 
   [th,h];
   return
end

if (tspan < 0)
   disp('The time span must be positive'); 
   [th,h];
   return
end

N = 1/T+1;  %number of samples for the filter
dlt = [1 zeros(1,N-1)];  %construct input for filter
h = filter(b,a,dlt);
th = 0:T:tspan;
h = h/T;

end
