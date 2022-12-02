%--------------------------------------------------------------------------
% Created: 8/31/13 by William J. Ebel
% 
% Revision History: None
% 
% Purpose: This function calculates the root-mean-square-error (RMSE)
%   between two vectors.  That is, the square root of the mean of the
%   square of the error (difference) between the two input signals. 
% 
% Variables: 
%   x1 - 1st input signals vector
%   x2 - 2nd input signals vector
%   K  - The RMSE between the two input vectors
% 
% function K = rmse(x1,x2)
%--------------------------------------------------------------------------
function K = rmse(x1,x2)

K = [];
if ~isequal(size(x1),size(x2))
	disp('*** ERROR in rmse, the input vectors do not have the same dimensions')
	return
end
if isempty(x1)
	disp('*** ERROR in rmse, the input vectors are both empty')
	return
end

err = abs(x1(:)-x2(:));
K = sqrt(mean(err.*err));

end