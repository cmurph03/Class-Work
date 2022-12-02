%-------------------------------------------------------------
% Created: 9/9/2021 by Caroline Murphy
%
% Revision History: 9/12/2021 - Updated to comply better with requirements
%
% Purpose: A script to determine the best value of tau for the reduce noise
% function. The script output is a single graph with the root mean squared
% error versus tau for 2 different impulse responses. 
%
% Variables created: 
%   
%   t = time vector
%   z = noisy signal
%   x = noiseless signal
%   n = noise level
%   th = time vector for impulse response
%   h2, h3 = impulse function for indexes 2 and 3
%   y2, y3 = convolution result for indexes 2 and 3
%   tauV = normalizing factor vector
%   tau = normalizing factor within loop
%   vec = current index for normalizing factor loop
%   n = current index for noise level loop
%   T = sample time factor
%   err2, err3 = tau RMSE vector for indexes 2 and 3
%   noiseErr2, noiseErr3 = noise error vector at for indexes 2 and 3 
%-------------------------------------------------------------

%Current vector index of tau loop
vec = 1;

%Variables to be graphed. Each tau loop adds another error value to err2
%and err3
err2 = [];
err3 = [];
tauV = 10.^[-2:0.1:0];

%For each tau loop, n, noiseErr2 and noiseErr3 are reset to 1 and [].
%Within the noise loop, the probe vectors are calculated for that noise
%level. The impulse responses for two different indexes are calculated and
%convolved then the RMSE is calculated compared to the noiseless signal x.
%The average RMSE for all noise levels at a specific tau are then added to
%the error vectors to be graphed.
for tau = 10.^[-2:0.1:0]
    n = 1;
    noiseErr2 = [];
    noiseErr3 = [];
    
    for noise = 0:1:10
        [t,z,x] = probe4(3, noise);
        T = t(2)-t(1);
        th = -0.7:T:0.7;
        
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
title('RMSE vs. Tau');

saveas(gcf, 'rmse_tau.png');
