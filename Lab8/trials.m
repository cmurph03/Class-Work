fc = [595,605];
rolloff = 20;


% p = [0.477331442647984,-0.033478230502867];
% a = polyval(p, rolloff);
% tau = 1/a;
% T = 1/2000;
% th = -10:T:10;
% w = mywindow(th/tau, 1);
% B = fc(2) - fc(1);
% f0 = (fc(2)+fc(1))/2;
% fc = B/2;
% %construct band pass filter
% h = 2*fc*sinc(2*fc*th).*w; 
% h = h.*(2*cos(2*pi*f0*th));
% 
% myFT(th,h,'plot');


[t,x] = make_song(1);
[y, tau, th, h] = myfilter(t,x,[595,605],20);