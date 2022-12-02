%-------------------------------------------------------------
% Created: 10/7/2021 by Caroline Murphy
%
% Revision History: None
%
% Purpose: This function takes a signal with interference and uses a band
% pass or a low pass filter to return as signal that isolates or removes the 
% interference 
%   
%   Variables:
%   y - filtered signal
%   x - original signal
%   t - time vector for signal
%   fc - cutoff frequency
%   h - impulse response
%   th - time vector for impulse response
%   p - function mapping the rolloff and tau 
%   w - window for filter
%   B - bandwidth
%   f0 - center of badpass filter
%
%-------------------------------------------------------------
function [y, tau, th, h] = myfilter(t,x,fc,rolloff)

%set initial values to null
y=[];
tau=[];
th=[];
h=[];

%check if t and x are the same length
if(length(t) ~= length(x))
    disp('Vectors y and t are not the same length');
    [y, tau, th, h]
    return
end
    
if(length(t) <= 2)
   disp('Vectors must be greater than 2'); 
   [y, tau, th, h];
   return
end

%establish calibration curve and start filter set-up
p = [-2.943896762540695e-06,0.001100488081946,0.415644761341843,0.684644553804533];
a = polyval(p, rolloff);
tau = 1/a;
T = t(2)-t(1);
th = -3:T:3;
w = mywindow(th/tau, 1);

%check fc if scalar or two component to decide if low pass or band pass
%filter will be used

%band pass filter    
if(length(fc) == 2)
    %make sure min(fc) is greater than rolloff and all are positive
    if(min(fc)<rolloff)
        disp('Cutoff frequency should be larger than Rollof.');
        [y, tau, th, h];
        return;
    end
    if(min(fc)<0 || rolloff<0)
        disp('Cutoff frequency and Rollof should be greater than 0');
        [y, tau, th, h];
        return;
    end
    B = fc(2) - fc(1);
    f0 = (fc(2)+fc(1))/2;
    fc = B/2;
    %construct band pass filter
    hI = 2*fc*sinc(2*fc*th).*w; 
    h = hI.*(2*cos(2*pi*f0*th));
else
    %make sure fc is greater than rollof and both are positive
    if(fc<0 || rolloff<0)
        disp('Cutoff frequency and Rollof should be greater than 0');
        [y, tau, th, h];
        return;
    end
    if(rolloff>fc)
        disp('Cutoff frequency should be larger than Rollof.');
        [y, tau, th, h];
        return;
    end
    
    %construct low Pass filter
    h = 2*fc*sinc(2*fc*th).*w;   
end
%perform filtering operation and remove filer transients 
y = myconv(t,x,th,h);
y = transient_zero(t,y,tau);
end