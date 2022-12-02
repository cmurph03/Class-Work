[t,z,x] = probe4(3,2);
T = t(2)-t(1);
vec = 1;
err2 = [];
err3 = [];

for tau = 10.^(-2:0.1:0)
vec = vec+1;

% with index 2
th = -1:T:1;
h2 = LTI(th/tau-0.5, 2);
h2 = h2/intdef(th,h2);
y2 = myconv(t,z,th,h2);
err2(vec) = rmse(x,y2);
%hold on; plot(t,y,'b');

% with index 3
th = -1:T:1;
h3 = LTI(th/tau+0.5, 3);
h3 = h3/intdef(th,h3);
y3 = myconv(t,z,th,h3);
err3(vec) = rmse(x,y2);
%plot(t,y,'g'); hold off; 

end