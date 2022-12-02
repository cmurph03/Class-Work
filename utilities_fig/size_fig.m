%-------------------------------------------------------------
% Created: 1/18/14  by William J. Ebel (All Rights Reserved)
%
% Revision History:  None
%
% Purpose:  Scale the figure window relative to its default size.  If the
%   arguments are both 1, then the figure is not changed in size.  If the
%   arguments are (2,1), then the width of the figure window is doubled and
%   the height is unchanged.  This function always keeps the top of the
%   window at the same height on the screen.  
%
% Variables: 
%    Sx - Scale in the horizontal screen direction
%    Sy - Scale in the vertical screen direction
%
% function pos = Size_fig(Sx,Sy)
%-------------------------------------------------------------
function pos = Size_fig(Sx,Sy)

% Get the current figure window position
% pos = [left bottom width height]
pos = get(gcf,'Position');

width  = Sx*pos(3);
height = Sy*pos(4);
bottom = round(pos(2) - (height-pos(4)));
left   = round(pos(1) - (width-pos(3))/2);

pos = [left bottom width height];
set(gcf,'Position',pos);

end