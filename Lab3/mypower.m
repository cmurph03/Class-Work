%-------------------------------------------------------------
% Created: 9/2/2021 by Caroline Murphy
%
% Revision History: None
%
% Purpose: This function calcultes the power of a signal over a given 
%   time range [a,b]. The user inputs also include two vectors, t and x,  
%   defining the time vector and the equation x. If b is not defined, it 
%   is the end of time vector t.
%
% Variables: 
%   x - vector defining the equation
%   t - time vector
%   a - beginning of specified time range
%   b - end of specified time range
%   P - power
%   
%-------------------------------------------------------------
function P = mypower(t,x,a,b)

  % Set the default output variable
  P = [];            
  
  %Test any of the error conditions. 
  if (length(x) ~= length(t)) 
      disp('Vectors x and t are not the same length');
      P;
      return
  end
  
  if(length(t)<2)
      disp('The vector t must have more than 2 values');
      P;
      return
  end
  
  
  % For the following calculations, first nargin is used to check the
  % number of inputs. Depending on the number of inputs, a and b are then
  % checked if they meet the requirements and will not cause any
  % mathematical errors (such as dividing by 0)
  
  
  % Calculate the power using just the first three inputs if b was not
  % defined
  if(nargin == 3)
      if (a>max(t))
          disp('The start of the time range is greater than t');
          P;
          return
      end
      if(a<min(t))
          a = min(t);
      end
      P = intdef(t, abs(x).^2, a)/(max(t) - a);
      
  % Calculate the power using just the first two inputs if a and b were not
  % defined
  elseif(nargin ==2)
      P = intdef(t, abs(x).^2)/(max(t) - min(t));
     
  % If nargin = 4 (ie all four values are filled) 
  else
      if(a>max(t) || b<min(t))
        disp('The time range [a,b] given is outside the bounds of t');
        P;
        return
      end
      if(a == b)
          disp('Invalid time range');
          P;
          return
      end
      if(a>b)
          P = intdef(t, abs(x).^2, b, a)/(a-b);
          return
      end
      if(a<min(t))
          a = min(t);
      end
      if(b>max(t))
          b = max(t);
      end
      P = intdef(t, abs(x).^2,a,b)/(b-a);
  end
  
end