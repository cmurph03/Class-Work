%--------------------------------------------------------------------------
% Created: 11/28/12 by William J. Ebel (All Rights Reserved)
% 
% Revision History: 
%           Date                Reason
% 
% Purpose: This function returns the autocorrelation function of a signal.
% 
% Variables: 
%   tx - input time vector associated with the sample vector x
%   x  - input sample vector
%
%   tR - time vector for the autocorrelation vector
%   R  - output autocorrelation vector
% 
% function [tR R] = Rxx(tx,x)
%--------------------------------------------------------------------------
function [tR R] = Rxx(tx,x)

[tR R] = Rxy(tx,x,tx,x);

end