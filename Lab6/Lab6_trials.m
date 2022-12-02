[t,y,x,alpha0,tau0,Tchip] = probe6(3,0);
[tR,R] = Rxx(t,y);
plot(tR,R);
xlim([-1 1]);

p = [5.634074024785496,-2.251487464583151,0.550028883677176];
R0 = max(R);
R(tR<=.075)=0;
Rtau = max(R);
J = find(R == Rtau);
tau = tR(J);
Rratio = Rtau/R0;
alpha = polyval(p,Rratio);