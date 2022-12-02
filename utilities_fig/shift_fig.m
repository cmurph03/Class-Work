%-------------------------------------------------------------
% Created: 2/21/07
%
% Revision History:  None
%
% Purpose: Moves the current figure to a new location on the screen
%
% Variables: 
%    Ncols - Number of columns for the figure
%    Nrows - Number of rows for the figure
%
% function [] = shift_fig(xshft,yshft)
%-------------------------------------------------------------
function [] = shift_fig(xshft,yshft)

scrn = get(0,'ScreenSize');
screen_width = scrn(3);
screen_height = scrn(4);
set(0,'Units','pixels');

pos = get(gcf,'Position');

pos(1) = pos(1) + xshft;
pos(2) = pos(2) + yshft;

set(gcf,'Position',pos);

