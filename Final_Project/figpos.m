%--------------------------------------------------------------------------
% Created: 3/26/2014 by William J. Ebel (All Rights Reserved)
%
% Revision History:  
%         Date           Reason
%       1/18/18      Modified to actually work?
%       2/28/19      Modified to work with matlab R2018b (not backward
%                    compatible.  Also modified it so it will execute the
%                    figure position file if it exists, or will create one.
%       4/16/19      Modified to allow figures to be deleted and/or added
%                    after the user is prompted to rearrange them.  This
%                    will guaranty that this function won't fail.
%
% Purpose: This function finds all the open matlab figure window positions
%   and stores a set of commands in a matlab script.  If this script is run
%   again with the same filename argument and the filename exists, then
%   this function will execute the script to place the figures accordingly.    
%
% Variables: 
%   filenm - (input) Filename to save the figure positions
% 
% function [] = figpos(filenm)
%--------------------------------------------------------------------------
function [] = figpos(filenm)

if nargin == 0
  disp('*** ERROR in figpos.  There must be one argument, a string representing a filename.')
  return;
end

if ~ischar(filenm)
  disp('*** ERROR in figpos.  The input must be a string representing a filename.')
  return;
end

% Reconstitute the filename with '.m' extension
[~, filebase, ext] = fileparts(filenm);
filenm = [filebase '.m'];

if ~isempty(ext) && ~strcmpi(ext,'m')
  disp('*** WARNING in figpos.  The input file name extension is incorrect and ignored')
  disp(['    ... using matlab script:  ' filenm])
  return;
end

if strcmpi(filebase,'figpos') || strcmpi(filebase,'figpos.m')
  disp('*** ERROR in figpos.  The input file name cannot be figpos.m')
  return;
end

%----------------------------
% Get all the figure information
hs = findobj('type','figure');
hs = sort(hs);

if isempty(hs)
  disp('*** ERROR in figpos.  There are no figure positions to save')
  return;
end

%----------------------------
% If the figure position file exists, then execute it to set all the figure
% positions.
if exist(filenm,'file')
  eval(filebase);
  return;
end

%----------------------------
% Prompt the user to readjust the figure positions if desired
disp('... place the figures where you want them, then press any key to continue ...');
disp(['    If you wish to reset the figure positions, delete the file ''' filenm ''' and rerun']);
pause

hs = findobj('type','figure');
hs = sort(hs);

%----------------------------
% Store the new figure positions as an executable matlab script

figV = zeros(1,length(hs));
for kk = 1:length(hs)
  if ishandle(hs(kk))
    figV(kk) = hs(kk).Number;
  end
end

figV = sort(figV);

% open the diary file and store the commands to set the figure positions
diary(filenm);

disp('%% Set these figure positions by executing this matlab script');
for kk = 1:length(figV)
  if ishandle(figV(kk))
    figure(figV(kk));
    fpos = get(figV(kk),'position');
    out = sprintf('if ishandle(%d); set(%d,''position'',[%d %d %d %d]); figure(%d); end',figV(kk),figV(kk),fpos(:),figV(kk));
    disp(out)
  end
end

diary off;

end