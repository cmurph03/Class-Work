%-------------------------------------------------------------
% Created: 10/21/2021 by Caroline Murphy
%
% Revision History: None
%
% Purpose:  
%   This demodulates an AM signal
%
%   Variables:
%   z - demodulated AM signal
%   RF - RF signal
%   t - time vector for signal
%   fc - carrier frequency
%   BW - bandwidth
%   rolloff - rolloff for filtering
%   
%   
%   x - original signal
%   a - lowest x value 
%   fc2 - cutoff frequency
%-------------------------------------------------------------

function z = AMdemod(t,RF,fc,BW,rolloff)
z = [];

%check conditions
if(length(t) ~= length(RF))
    disp('Vectors t and RF are not the same length');
    z;
    return
end   
if(length(t) <= 2)
   disp('Vectors must be greater than 2'); 
   z;
   return
end
if(BW/2<0 || rolloff<0)
    disp('Cutoff frequency and Rollof should be greater than 0');
   [xLPF,y];
   return;
end
if(rolloff>BW)
   disp('Cutoff frequency should be larger than Rollof.');
   [xLPF,y];
   return;
end
if(fc<0)
    disp('Carrier frequency must be greater than 0');
    [xLPF,y];
    return
end

%Band pass filter the RF signal to get 1 AM modulated signal
y = myfilter_ebel(t,RF,[fc-BW/2, fc+BW/2],rolloff);
%multiply by cosine
d = y.*(2*cos(2*pi*fc*t));
%do a low pass filter
dLPF = myfilter_ebel(t,d,BW,rolloff);
%subract off the mean
z = dLPF - mean(dLPF);

end