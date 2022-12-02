%-------------------------------------------------------------
% Created: 11/11/2021 by Caroline Murphy
%
% Revision History: None
%
% Purpose:  
%   This funtion determines the shortest distance between a given metric
%   vector and a 2x2 decision matrix.  
%
%   Variables:
%   indx = row index of decV that is the closest to m (output)
%   dmin = distance between m and closest vector in decV (output)
%   m = metric vector of an unknown vowel (input)
%   decV = decision vector (input)
%   D1 = distance between first decV and m
%   D2 = distance between second decV and m
%   
%   
%   
%-------------------------------------------------------------

function [indx,dmin] = nearest_neighbor(m,decV)
indx=[];
dmin=[];

%check conditions
if (length(m) ~= 2)
    disp('M must be a vector of length 2');
    [indx,dmin];
    return
end
[x,y] = size(m);
if (x ~= 1 || y ~= 2)
    disp('M must be a vector')
    [indx,dmin];
    return
end
[r,s] = size(decV);
if (r ~= 2 || s ~= 2)
    disp('Decision vector must be a 2x2 matrix')
    [indx,dmin];
    return
end

%calculate distances
D1 = sqrt(power([m(1)-decV(1,1)],2)+ power([m(2)-decV(1,2)],2));
D2 = sqrt(power([m(1)-decV(2,1)],2)+ power([m(2)-decV(2,2)],2));

%Determine index and dmin
if (D1>D2)
    indx = 2;
else
    indx = 1;
end

dmin = min(D1,D2);

end