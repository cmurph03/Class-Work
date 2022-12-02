%-------------------------------------------------------------
% Created: 7/11/06
%
% Revision History: 
%          Date             Reason
%           None
%
% Purpose: Cycles through the figures, diplaying each one
%   in succession.
%
% function [] = cycle_figs(nmstart)
%-------------------------------------------------------------
function [] = cycle_figs(nmstart)

if nargin == 0; nmstart = ''; end

nmlen = length(nmstart);

hs = findobj('Type','figure');

hs = sort(hs);
if (length(hs) == 0)
  disp('*** NOTE: There are no figures to cycle')
  return;
end

n = 0;
while(1)
  if (n > 0)
    for j = 1:length(hs)
      figure(hs(j));
      pause(n);
    end
  else
    if (nmstart > 0)
      for j = 1:length(hs)
        nm = get(hs(j),'name');
        if (nmstart == nm(1:nmlen))
          figure(hs(j));
          pause;
        end
      end
    else
      for j = 1:length(hs)
        nm = get(hs(j),'name');
        figure(hs(j));
        pause;
      end
    end
  end
end
