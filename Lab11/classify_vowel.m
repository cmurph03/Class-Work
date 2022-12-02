%-------------------------------------------------------------
% Created: 11/12/2021 by Caroline Murphy
%
% Revision History: None
%
% Purpose:  
%   This function takes a given audio signalvector and time vector then 
%   classifies what vowel it is. 
%
%   Variables:
%   Vchar = vowel character(output)
%   t = time vector (input)
%   x = signal vector (input)
%   decV = decision vector
%   E = spectral band energy of input signal
%   fbnd = frequency band vector
%   
%   
%   
%-------------------------------------------------------------

function Vchar = classify_vowel(t,x)
Vchar = [];

%check if t and x are the same length
if(length(t) ~= length(x))
    disp('Vectors x and t are not the same length');
    Vchar;
    return
end
    
if((length(t) <= 2))
   disp('Vectors must be greater than 2'); 
   Vchar;
   return
end

%convert sginal to spectral band energy vector
fbnd = [50,67,90,120,161,215,289,386,518,693,928,1243,1665,2230,2987,4000];
E = spectral_band_energy(t,x,fbnd);

%Separate out the different speakers
[indx] = nearest_neighbor([E(3),E(15)],[-0.1193 0.2846; 0.1603 0.2861]);
if (indx == 1)
    %speaker 1 & 2
    [indx] = nearest_neighbor([E(5),E(14)],[0.3947 0.1811; 0.1620 0.3204]);
    if(indx == 1)
        %speaker 1
        %split of into 'aeu' (indx1) and 'io' (indx2)
        [indx] = nearest_neighbor([E(4),E(12)],[0.0020 0.0002; 0.0020 0.0018]);
        if(indx == 1)
            %'aeu'
            [indx] = nearest_neighbor([E(14),E(15)],[0.0007 0.0003; 0.0005 0.0003]);
            if (indx == 1)
                Vchar = 'a';        
            else
                %'eu'
                [indx] = nearest_neighbor([E(11),E(15)],[0.0001 0.0002; 0.0002 0.0001]);
                if (indx == 1)
                    Vchar = 'e';
                else
                    Vchar = 'u';
                end
            end
        else
            %'io'
            [indx] = nearest_neighbor([E(9),E(11)],[0.0615 0.0106; 0.0485 0.0197]);
            if (indx == 1)
                Vchar = 'o';        
            else
                Vchar = 'i';
            end
        end
    else
        %speaker 2
        [indx] = nearest_neighbor([E(12),E(13)],[0.0483 0.1123; 0.2143 0.0759]);
        if (indx == 1)
            %'aeu'
            [indx] = nearest_neighbor([E(13),E(15)],[0.0208 0.3344; 0.0600 0.2470]);
            if (indx == 1)
                Vchar = ['e'];
            else
                %'au'
                [indx] = nearest_neighbor([E(8),E(14)],[0.0798 0.4159; 0.1184 0.4595]);
                if (indx == 1)
                    Vchar = ['a'];
                else
                    Vchar = ['u'];
                end
            end
            
        else
            %'io'
            [indx] = nearest_neighbor([E(9),E(11)],[0.0865 0.1849; 0.0323 0.3144]);
            if (indx == 1)
                Vchar = ['o'];
            else
                Vchar = ['i'];
            end
        end
    end
else
    %speaker 3
    [indx] = nearest_neighbor([E(11),E(15)],[0.0012 0.0023; 0.0044 0.0004]);
    if (indx == 1)
        %'aeu'
        [indx] = nearest_neighbor([E(8),E(15)],[0.0438 0.0001; 0.0219 0.0013]);
        if (indx == 1)
            Vchar = ['a'];
        else
            [indx] = nearest_neighbor([E(11),E(12)],[0.0001 0.0001; 0.0001 0.0003]);
            if (indx == 1)
                Vchar = ['e'];
            else
                Vchar = ['u'];
            end
        end
    else
        %'io'
        [indx] = nearest_neighbor([E(12),E(15)],[0.0142 0.0008; 0.0029 0.0007]);
        if (indx == 1)
            Vchar = ['i'];
        else
            Vchar = ['o'];
        end
    end
 end

end