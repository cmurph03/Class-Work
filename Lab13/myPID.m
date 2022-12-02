%-------------------------------------------------------------
% Created: 12/02/2021 by Caroline Murphy
%
% Revision History: None
%
% Purpose:  
%   This funtion is a basic discrete-time PID controller.
%
%   Variables:
%   b = myPID signal output
%   a = signal input
%   T = sample time (input)
%   Kp, Ki, Kd = proportional, integral, and differential tuning variables (input)
%   var1 = previous a
%   var2 = current sum
%   
%   
%   
%-------------------------------------------------------------

function b = myPID(Kp,Ki,Kd,T,a)

b = [];

persistent var1 var2;

if (nargin == 0)
    var1=0; var2=0; b=[]; 
    return
end

if (T < 0)
   disp('Sample time must be greater than 0'); 
   b;
   return
end

if (length(a) ~= 1)
   disp('The input a must be a single variable'); 
   b;
   return
end

var2 = var2 + T*a;

b = Kp*a + Ki*var2 + Kd*(a - var1)/T;

var1 = a;


end