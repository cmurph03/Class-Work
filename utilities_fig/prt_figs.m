%-------------------------------------------------------------
% Created: 7/11/06
%
% Revision History: 
%       Date             Reason
%     2/20/07     Added silent_flg to the arg list
%     7/28/10     Modified fig_offset, entered # is the 1st fig #
%     1/31/12     Made all the command line arguments optional with
%                 obvious defaults. 
%     3/4/12      Made the printed file name is the same as the figure
%                 name. Also modified the resolution of the 'png'
%                 extension to be 200 dpi. 
%     4/27/12     Changed the test for the figure name to properly
%                 insert the right number of zeros
%    10/23/15     Increased the figure number by 1 to match what
%                 actually is displayed in the figure window.
%    11/15/15     Changed the figure number offset calculation to work
%                 with matlab version 2014 and later.
%     1/30/17     Added 2016 to the version number check
%     1/27/18     Added a test to see if the current figure to be
%                 printed to a file contains an image.  If it does, then
%                 the printed resolution is modified so the printed
%                 image has the same resolution as the plotted image
%     2/27/18     Modified the detection of an image plot in order to
%                 use the imwrite command to print the image to a file.
%                 This is both faster and gives the correct output dim.
%     11/9/18     Eliminated the 'ver' variable which was not used
%
% Purpose: Prints all the existing figures. The file extension
%   can be either 'jpg', 'jpeg' or 'eps'.  If the extension is 'eps',
%   then the 'eps' figures are converted to mif (framemaker)
%   format. There is a problem converting to mif when the 
%   figure is a 3-D plot.  The eps_to_mif batch file deletes
%   the '.eps' extension from all files in the directory.  But
%   this changes the names of the 'bmp' (or something like that)
%   that are placed in the figure directory which are used by
%   framemaker to construct the 'mif' file.  
%
% Variables: 
%    ext - file extension for the printed figures, can be 
%              'mif' (first converted to eps, then to mif)
%              'eps'
%              'jpeg' (picture file)
%              'fig'  (MATLAB figure file)
%    folder - directory where the figures are placed.  This
%             is relative to the current MATLAB directory. 
%    nmappend - character array appended to the file names
%   
% function [] = prt_figs(ext,folder,nmappend,fig_offset,silent_flg)
%-------------------------------------------------------------
function [] = prt_figs(ext,folder,nmappend,fig_offset,silent_flg)

%---------------
% Set the default values of the input parameters if not specified
if nargin < 5; silent_flg = 1;     end
if nargin < 4; fig_offset = 0;     end
if nargin < 3; nmappend   = '';    end
if nargin < 2; folder     = '';    end
if nargin < 1; ext        = 'mif'; end

if (strcmp(ext,'mif') || strcmp(ext,'fm'))
  ext = 'eps';
end

% --------- Find all the created figures ------------
hs = findobj('Type','figure');
hs = sort(hs);

% --------- Print the figures ------------
if strcmp(ext,'ps');   printflg = '-dpsc2';     end
if strcmp(ext,'pdf');  printflg = '-dpdf';      end
if strcmp(ext,'eps');  printflg = '-depsc2';    end
if strcmp(ext,'png');  printflg = '-dpng -r200'; end
if strcmp(ext,'jpg');  printflg = '-djpeg';     end
if strcmp(ext,'jpeg'); printflg = '-djpeg100';  end

% --------- Create the output directory ---------
if ~isempty(folder)
  if (exist(folder,'dir') == 0)
    mkdir(folder);
  end
  currentdir = pwd;
  eval(['cd ' folder]);
else
  currentdir = [];
end

% --- Loop for each figure and print
for kk = 1:length(hs)
  disp(['*** Plotting figure ' num2str(hs(kk).Number) ' ***'])
  fg = figure(hs(kk));

% See if this figure contains an image (imflg = true)
  imh = imhandles(fg);
  imflg = false;
  if ~isempty(imh);  imflg = true;  end

% Create the output file name.  Make sure that the fig number is
% a 4 digit number so that the filenames are sequenced right by
% the Pics2AVI program.
  nm = get(gcf,'name');

  if ~isempty(nm)
% Strip out any colons or spaces (make the figure name a valid file name)
    while ~isempty(strfind(nm,':'))
      II = strfind(nm,':');
      nm = [nm(1:II-1) nm(II+1:end)];
    end
    while ~isempty(strfind(nm,' '))
      II = strfind(nm,' ');
      nm = [nm(1:II-1) nm(II+1:end)];
    end
  else
% Create the figure index, matlab changed the format for this in 2014
    if isnumeric(hs(kk))
      kfig = hs(kk) + fig_offset;         % Works up to version 2014
    else
      kfig = hs(kk).Number + fig_offset;  % Works with version 2014 and later
    end

% Resize the figure name so they all have the same length.  This is
% beneficial when making movies from a set of images
    if     kfig < 10;     nm = [nmappend 'fig000' num2str(kfig) '.' ext];
    elseif kfig < 100;    nm = [nmappend 'fig00'  num2str(kfig) '.' ext];
    elseif kfig < 1000;   nm = [nmappend 'fig0'   num2str(kfig) '.' ext];
    else                  nm = [nmappend 'fig'    num2str(kfig) '.' ext];
    end
  end
  name_raw = nm;

% NOTE:  1/29/18  If this is an image, use the matlab 'imwrite' function
% to print it to a file.  I'm guessing this is faster and with no
% distortion of any kind.  I'm not sure if the printing method as
% implemented below would provide any distortion, but imwrite surely would
% not. 
%   Upon further thought, using imwrite would require that the image array
% be extracted from the plot before using imwrite, since it requires an
% array.  I'm sure this could be done but it is not obvious to me right now
% how to do this. 
  if imflg  
    A = getimage(fg);
%    name = [name_raw '.' ext];
    imwrite(A,name_raw,ext);
  else  
    set(gcf,'PaperPositionMode','auto');

    if strcmp(ext,'fig')
      saveas(gcf,name_raw,'fig');
    else
      cmd = ['print ' printflg ' ' name_raw];
      if (silent_flg == 0); disp(['cmd = <' cmd '>']), end
      eval(cmd); 
      if (silent_flg == 0)
        disp(['*** Printing fig ' num2str(hs(kk)) ': >> ' cmd])
      end
    end
  end
end

% Change back to the original directory
if ~isempty(currentdir)
  eval(['cd ''' currentdir ' '' ']);
end

end