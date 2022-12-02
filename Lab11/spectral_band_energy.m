%-------------------------------------------------------------
% Created: 11/11/2021 by Caroline Murphy
%
% Revision History: None
%
% Purpose:  
%   This function constructs the spectral band energies for a given signal
%   over a set of frequency bands
%
%   Variables:
%   E = spectral energy vector (output)
%   t = time vector (input)
%   x = signal vector (input)
%   fbnd = frequency band vector (input)
%   [f,Xf] = fourier transform
%   Xmag = spectral magnitude
%   
%   
%   
%-------------------------------------------------------------

function E = spectral_band_energy(t,x,fbnd)
E = [];

%check if t and x are the same length
if(length(t) ~= length(x))
    disp('Vectors x and t are not the same length');
    E;
    return
end
    
if((length(t) <= 2) || (length(fbnd) < 2))
   disp('Vectors must be greater than 2'); 
   E;
   return
end

if(fbnd(1) ~= 50 || fbnd(end) ~= 4000)
    disp('The minimum frequency band must be 50 and the max 4000');
    E;
    return
end

[f,Xf] = myFT(t,x);
Xmag = abs(Xf);
E = zeros(1,length(fbnd)-1);

for n = 1:1:length(fbnd)
   if n>1
       E(n-1)=intdef(f,Xmag.*Xmag,fbnd(n-1),fbnd(n));
   end
    
end

E = E/sum(E);


end