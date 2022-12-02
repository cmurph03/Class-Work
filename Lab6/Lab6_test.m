
 %calibration
 alphaV = [];
 RratioV = [];
 for N = 1:100
    [t,y,x,alpha,taua,Tship] = probe6(3,0);
    [tR,R] = Rxx(t,y);
    R0 = max(R);
    R(tR<3*Tchip)=0;
    Rtau = max(R);
    Rratio = Rtau/R0;
    
    alphaV(N) = alpha;
    RratioV(N) = Rratio;
 end

p = polyfit(RratioV, alphaV,order);



%tests with bit error rate
[bx, tV] = find_bits(t, x, 3);
[by, tV] = find_bits(t,y,3);