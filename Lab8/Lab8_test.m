%-------------------------------------------------------------
% Created: 10/7/2021 by Caroline Murphy
%
% Revision History: None
%
% Purpose: This script has three parts: the calibration curve, the error
% calculation, and the practical application of the myfilter.m function.
% The first part develops a calibration curve to calculate tau when given a
% rolloff by stepping through cutoff frequency values. The error 
% calculation is to determine the efficacy of the calibration curve by 
% comparing a given rolloff with the calculated rolloff for a range of 
% frequencies. The final section utilizes the myfilter.m function that was
% developed using the calibration curve previously calculated. A section of
% a song with interference is given and the rolloff value and frequency
% cutoff range is chosen to remove the intereference. 
%
%
%   Variables:
%   Part 1
%   tauV - tau values ranging from 0.01 to 1
%   rollv - vector to store calculated rolloff values
%   w - window for filter
%   h - impulse response
%   th - time vector for impulse response
%   [fp, fs] - cutoff frequency range
%   roll - calculated rolloff value
%   p - function mapping the rolloff and tau 
%   fit - plottable calibration curve line
%   
%   New Variables in Part 2
%   fcV - Vector with fc values ranging from 100 to 10000
%   rollt - calculated rolloff value
%   rollVest - Vector storing rollt values for each fc
%   error - error of the rolloff calculation for given frequencies
%    
%   New Variables in Part 3
%   x - signal for the song with interference
%   t - time vector for signal
%   y - signal filtered for just the interference
%   z - singal for the song with interference removed
%-------------------------------------------------------------


clear all; 
%Calibration Curve found by steping though values of tau and calculating
%rolloff. The rolloff and 1/tau are plotted and a curve of best fit is
%calcualted. 
a =1:2:100;
tauV = 1./a;
i = 1;
fc = 200;
T = 1/2000;
rollv = zeros(1,length(tauV));
for tau = tauV
    th = -100*tau:T:100*tau;
    w = mywindow(th/tau, 1);
    hI = 2*fc*sinc(2*fc*th);
    h = hI.*w;
    [fp,fs] = filter_transition(th, h);
    roll = fs-fp;
    rollv(i) = roll;
    figure(1);
    i = i+1;
end

p = polyfit(rollv, 1./tauV,3);
figure(1);
plot(rollv,1./tauV,'.b');

rollv = sort(rollv);
fit = polyval(p,rollv);
hold on; plot(rollv,fit, 'r'); hold off;
xlabel('Rolloff');
ylabel('1/tau');
title('Impulse Response Tau Calibration');


%test mapping across fc. use rolloff = 10Hz, create an fcV
%ranging from 100:100:1000. Generate a low pass filter response for eah
%then use filter_transitions and store results in rollVest. Plot the
%percent error versus fcV by using 100*abs(10-rollVest)/10
rolloff = 10;
fcV = 100:100:10000;
rollVest = zeros(1,length(fcV));
%establish constants used in each loop.
p = [-1.056661867096087e-06,6.425688183607073e-04,0.442447143158633,0.396123755127929];
a = polyval(p, rolloff);
tau = 1/a;
T = 1/22000;  
th = -4:T:4;
w = mywindow(th/tau, 1);

i=1;
for fc = fcV
    hI = 2*fc*sinc(2*fc*th);
    h = hI.*w;
    
    %find actual rolloff
    [fp,fs] = filter_transition(th,h);
    rollt = fs-fp;
    rollVest(i) = rollt;
    i = i+1;
end
error = 100.*abs(rolloff-rollVest)./10;
figure(2)
plot(fcV, error);
xlabel('Cut off Frequency');
ylabel('Percent error');
title('Error of Rolloff Given Cut off Frequency');

% %Utilize myfilter function by filtering out interference in a song snippet
% clear all;
% [t,x] = make_song(1);
% %myplay(t,x,4);
% figure(3);
% myFT(t,x,'plot','frange', [0,700]);
% froll = 5;
% [y, tau, th, h] = myfilter(t,x,[585,615],froll);
% z = x-y;
% figure(4);
% myFT(t,z,'plot','frange', [0,700]);
% %myplay(t,z);