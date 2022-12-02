%-------------------------------------------------------------
% Created: 9/23/2021 by Caroline Murphy
%
% Revision History: None
%
% Purpose: This script calculates a calibration curve for a signal with echo.
%    The calibration curve is calculated using the lowest noise level of a 
%    given signal and the autoroccelation function. The script also
%    performs a binary data estimation and calculates the bit error rate
%
%
%   Variables:
%   t - time vector
%   y - signal with echo
%   x - signal without echo 
%   alpha - echo strength 
%   tau - echo delay 
%   p - function mapping the Rratio versus alpha
%   tR - time vector of autocorrelation funtion
%   R - R value of autocorrelation function
%   BER - bit error rate
%
%-------------------------------------------------------------
 
%calibration curve 
 clear all;
 n=175;
 alphaV = zeros(1,n);
 RratioV = zeros(1,n);
 
 for N = 1:n
     [t,y,x,alpha,tau,Tchip] = probe6(3,0);
     [tR,R] = Rxx(t,y);
     R0 = max(R);
     %set all values less than 3*Tchip to 0 to find the peak to the right
     %(Rtau)
     R(tR<3*Tchip)=0;
     Rtau = max(R);
     Rratio = Rtau/R0;
     
     alphaV(N) = alpha;
     RratioV(N) = Rratio;
   
 end
figure(1);
plot(RratioV, alphaV, '.');
p = polyfit(RratioV, alphaV,2);
RratioV = sort(RratioV);
fit = polyval(p,RratioV);
hold on; plot(RratioV, fit,'r'); hold off;
xlabel('Rratio');
ylabel('alpha');
title('Rratio vs. Alpha');


%Binary Data Estimation
%clear all;
BERy = zeros(1,11);
BERz = zeros(1,11);
i = 1;
for LVL = 0:10
    [t,y,x,alpha0,tau0,Tchip] = probe6(3,LVL);
    [alpha,tau,z] = remove_echo(t,y);
    [bx, tV] = find_bits(t,x,3);
    [by, tV] = find_bits(t,y,3);
    [bz, tV] = find_bits(t,z,3);
    Nerry = sum(abs(by-bx));
    Nerrz = sum(abs(bz-bx));
    Nbits = length(bx);
    BERy(i) = Nerry/Nbits;
    BERz(i) = Nerrz/Nbits;
    i = i+1;
end
bt = 0:1:10;
figure(2);
plot(bt,BERy, 'b'); hold on; plot(bt,BERz, 'r');
xlabel('Level of Noise');
ylabel('BER');
title('Bit-error-rate');