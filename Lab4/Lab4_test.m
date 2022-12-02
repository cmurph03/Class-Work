%-------------------------------------------------------------
% Created: 9/14/2021 by Caroline Murphy
%
% Revision History: 
%
% Purpose: A script to test the reduce_noise.m function.
%
% Variables created: 
%   
%   t = time vector
%   z = noisy signal
%   x = noiseless signal
%   n = noise level
%   y = convolution result 
%    
%-------------------------------------------------------------

%Loop through the different noise levels, generating a signal each time,
%applying the reduce_noise funtion, plotting the orginal and modified
%signals, then exporting the plots as png files
for LVL = [0,5,10]
  [t,z,x] = probe4(3, LVL);
  
  y = reduce_noise(t,z);
  
  plot(t,x,'b'); hold on; plot(t,y,'r'); hold off;
  xlabel('time(sec)');
  ylabel('amplitude');
  title(['Noise Level ' num2str(LVL)]);
  
  saveas(gcf, ['LvL' num2str(LVL) '.png']);
  
end

    
    
    
    