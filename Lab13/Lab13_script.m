%-------------------------------------------------------------
% Created: 12/02/2021 by Caroline Murphy
%
% Revision History: None
%
% Purpose:  
%   This scrip.
%
%   Variables:
%   d - horizontal distance down the wall
%   y - robot vertical position
%   w - wall vertical position
%   b - myPID signal output   
%   Kp, Ki, Kd = proportional, integral, and differential tuning variables
%   trans = error of the transient response
%   ss = error of the steady state response
%   
%-------------------------------------------------------------
for tau = 0:1
    
if (tau == 0)
    Kp = 0.8;
    Ki = 0;
    Kd = 115;
else
   Kp = 0.3;
   Ki = 0.00;
   Kd = 30;  
end

[d,y,w] = robot_sim(Kp,Ki,Kd,tau,0,9,0);

%create empty vectors for the transient and ss responses
trans = [];
ss = [];

%calculate error by stepping through d
for n = 1:length(d)
   if (d(n)>20 && d(n)<50)
       err = rmse(y(n),(w(n)+15));
       trans(n) = err;
   end
   if (d(n)>50 && d(n)<100)
       err = rmse(y(n),(w(n)+15));
       ss(n) = err;
   end
end

output = ['RMSE for tau = ', num2str(tau), ': ', num2str(mean(trans)),', ' num2str(mean(ss))];
disp(output);


end



