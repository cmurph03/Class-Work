%-------------------------------------------------------------
% Created: 10/21/2021 by Caroline Murphy
%
% Revision History: None
%
% Purpose:  
%   This function constructs and AM signal from a given audio signal
%
%   Variables:
%   y - output AM signal
%   xLPF - filtered song
%   x - original signal
%   t - time vector for signal
%   fc - carrier frequency
%   rolloff - rolloff for filtering  
%   BW - bandwidth
%   a - lowest x value 
%   fc2 - cutoff frequency
%-------------------------------------------------------------

function [y, xLPF] = AMmod(t,x,fc,BW,rolloff)
xLPF = [];
y = [];

%check if t and x are the same length
if(length(t) ~= length(x))
    disp('Vectors x and t are not the same length');
    [xLPF,y];
    return
end
    
if(length(t) <= 2)
   disp('Vectors must be greater than 2'); 
   [xLPF,y];
   return
end

%determine xLPF and make sure BW and rolloff are suitable
if(BW<0 || rolloff<0)
    disp('Band Width and Rollof should be greater than 0');
   [xLPF,y];
   return;
end
if(rolloff>BW)
   disp('Band Width should be larger than Rollof.');
   [xLPF,y];
   return;
end

xLPF = myfilter_ebel(t,x,BW,rolloff);
   
%find y and make sure values are appropriate
a = abs(min(xLPF));
if(fc<0)
    disp('Carrier frequency must be greater than 0');
    [xLPF,y];
    return
end

y = (a+xLPF).*cos(2*pi*fc*t);

end