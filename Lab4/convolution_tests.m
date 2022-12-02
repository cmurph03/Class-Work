%-------------------------------------------------------------
% Created: 9/9/2021 by Caroline Murphy
%
% Revision History: None
%
% Purpose: Script for checking various impulse functions
%
% Variables created: 
%   
%   t = time vector
%   z = noisy signal
%   x = noiseless signal
%   n = noise level
%   h = impulse function
%   i = LTI index
%   tau = normalizing factor
%   t0 = time shifting factor
%   T = sample time
%-------------------------------------------------------------


vec = 1;
err2 = [];
err3 = [];
tauV = 10.^[-2:0.1:0];



for tau = 10.^[-2:0.1:0]
    n = 1;
    noiseErr2 = [];
    noiseErr3 = [];
    
    for noise = 0:1:10
        [t,z,x] = probe4(3, noise);
        T = t(2)-t(1);
        th = -1:T:1;
        
        % for index 2
        h2 = LTI(th/tau-0.5, 2);
        h2 = h2/intdef(th,h2);
        y2 = myconv(t,z,th,h2);
        noiseErr2(n)= rmse(x,y2);
        
        % for index 3
        h3 = LTI(th/tau+0.5, 3);
        h3 = h3/intdef(th,h3);
        y3 = myconv(t,z,th,h3);
        noiseErr3(n) = rmse(x, y3);
        
        n = n+1;
    end
err2(vec) = mean(noiseErr2);

err3(vec) = mean(noiseErr3);


vec = vec+1;
end
plot(tauV,err2,'b'); hold on; plot(tauV, err3,'g'); hold off;
xlabel('Tau');
ylabel('RMSE');

