%-------------------------------------------------------------
% Created: 9/23/2021 by Caroline Murphy
%
% Revision History: None
%
% Purpose: Given a singal with and echo, the function estimates the echo
% parameters of tau and alpha. The function then elimates the echo in the
% given signal and outputs a new signal {t,z}
%   
%   Variables:
%   t - time vector
%   y - signal with echo
%   z - signal with echo removed
%   alpha - echo strength estimate
%   tau - echo delay estimate
%   p - function mapping the Rratio versus alpha
%
%-------------------------------------------------------------
function [alpha,tau,z] = remove_echo(t,y)
    
    z=[];
    alpha = [];
    tau = [];
    
    %check input values for validity
    if(length(t) ~= length(y))
        disp('Vectors y and t are not the same length');
        [z, alpha, tau]
        return
    end
    
    if(length(t) <= 2)
       disp('Vectors must be greater than 2'); 
       [z, alpha, tau]
       return
    end
    
    %calibration funtion
    p = [5.634074024785496,-2.251487464583151,0.5350028883677176];
    
    %Calculate Rxx  
    [tR,R] = Rxx(t,y);
    R0 = max(R);
    %Below tR = 0.0.075 (or 3*Tchip), set all values of R to 0 and find second peak to
    %determine tau and alpha
    R(tR<=.075)=0;
    Rtau = max(R);
    J = find(R == Rtau);
    tau = tR(J);
    Rratio = Rtau/R0;
    alpha = polyval(p,Rratio);
    
    %make sure alpha and tau are within the appropriate range
    %will generally get an appropriate value of alpha within 2 trials
    if ((alpha < 0.3) || (alpha > 0.8)) 
        [tR,R] = Rxx(t,y);
        R0 = max(R);
        R(tR<=.075)=0;
        Rtau = max(R);
        J = find(R == Rtau);
        tau = tR(J);
        Rratio = Rtau/R0;
        alpha = polyval(p,Rratio);
    end
   
    if((tau<0.1) || (tau>0.3))
       disp('Tau not within appropriate range');
       return;
    end
    
    hi = dc(t)- alpha*dc(t-tau);
    %hi = hi/intdef(t,hi);
    z = myconv(t,y,t,hi); 
    
    

end