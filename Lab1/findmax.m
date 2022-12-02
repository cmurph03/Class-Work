function [mm ind] = findmax (vec)
mm = [];
ind = [];
[r,c] = size(vec);
if (min(r,c) > 1)
    disp('*** ERROR! function argument must be a veotr')
    return;
end
mm = max(vec);
ind = find(vec == mm);