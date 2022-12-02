%-------------------------------------------------------------
% Created: 9/3/2021 by Caroline Murphy
%
% Revision History: None
%
% Purpose: This script is used to define a singal to test the functions for
% Lab 3. A graph of the signal will be displayed along with the calculated
% energy and power values.
%
% Variables created: 
%   t - time vector for the signal
%   x - sample vector for th signal
%   a - left-side of the time interval for calculation
%   b - right-side of the time interval for calculation
%   E - energy
%   Eth - Theortical value of energy over time interval [a,b]
%   Eperc - % error between estimated and theoretical values for energy
%   P - power
%   Pth - Theortical value of power over time interval [a,b]
%   Pperc - % error between estimated and theoretical values for power
%-------------------------------------------------------------

disp('Lab3')
%Generating the signal
[t,x,a,b] = mysignal(2);

% Plotting the signal and setting up the plot
plot(t,x);
xlabel('time (sec)');
ylabel('signal x(t)');
title('Test Signal');
axis([min(t)-1, max(t)+1, min(x)-0.1, max(x)+0.1]);

%Calculating power and energy
P = mypower(t,x,a,b);
E = myenergy(t,x,a,b);
disp(['P = ', num2str(P)]);
disp(['E = ', num2str(E)]);

%Calculating percent error
Eth = 12.0045;
Pth = 3.0011;
Eperc = 100*(abs(Eth - E)/Eth);
Pperc = 100*(abs(Pth - P)/Pth);


