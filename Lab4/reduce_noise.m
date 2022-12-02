%-------------------------------------------------------------
% Created: 9/12/2021 by Caroline Murphy
%
% Revision History: None
%
% Purpose: The function takes a noisy signal and a time vector to output a
% signal with reduced noise using convolution. This funtion is specific to
% a certain signal and is not universal.
%
%   
%   Variables:
%   t - time vector
%   z - noisy signal
%   y - noise-reduced signal
%   T - sample time factor
%   th - time vector for impulse response
%   h - impulse response
%
%-------------------------------------------------------------
function y = reduce_noise(t,z)

%output is initally set to null to account for any invalid input
y = [];

%check input values for validity
if(length(t) ~= length(z))
    disp('Vectors z and t are not the same length');
    y;
end

if(length(t) <= 1)
    disp('Length of vectors must be greater than 1');
    y;
end

%Calculate impuse response (h) using tau = 0.25 and t0 = 0.5 and time vector
%th. The impulse chosen was index 2 as Lab4_data showed it to have the
%lowest error. Normalize h and convolve with z. 
T = t(2)-t(1);
th = -0.7:T:0.7;
h = LTI(th/0.25-0.5, 2);
h = h/intdef(th,h);
y = myconv(t,z,th,h);

end