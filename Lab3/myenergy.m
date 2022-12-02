%-------------------------------------------------------------
% Created: 9/2/2021 by Caroline Murphy
%
% Revision History: None
%
% Purpose: This function calcultes the energy of a signal over a given time range [a,b].
%   The user inputs also include two vectors, t and x, defining the time
%   vector and the equation x. If b is not defined, it is the end of time
%   vector t.
%
% Variables: 
%   x - vector defining the equation
%   t - time vector
%   a - beginning of specified time range
%   b - end of specified time range
%   E - energy
%   
%-------------------------------------------------------------
function E = myenergy(t,x,a,b)

  % Set the default output variable
  E = [];            
  
  %Test any of the error conditions. 
  if (length(x) ~= length(t)) 
      disp('Vectors x and t are not the same length');
      E;
      return
  end
  
  if(length(t)<2)
      disp('The vector t must have more than 2 values');
      E;
      return
  end
  
  
  % For the following calculations, first nargin is used to check the
  % number of inputs. Depending on the number of inputs, a and b are then
  % checked if they meet the requirements 
  
  
  % Calculate the energy using just the first three inputs if b was not
  % defined
  if(nargin == 3)
      if (a>max(t))
          disp('The start of the time range is greater than t');
          E;
          return
      end
      if(a<min(t))
          a = min(t);
      end
      E = intdef(t, abs(x).^2, a);
      
  % Calculate the energy using just the first two inputs if a and b were not
  % defined
  elseif(nargin ==2)
      E = intdef(t, abs(x).^2);
     
  % If nargin = 4 (ie all four values are filled) 
  else
      if(a>max(t) || b<min(t))
        disp('The time range [a,b] given is outside the bounds of t');
        E;
        return
      end
      if(a>b)
          E = intdef(t, abs(x).^2, b, a);
          return
      end
      if(a<min(t))
          a = min(t);
      end
      if(b>max(t))
          b = max(t);
      end
      E = intdef(t, abs(x).^2,a,b);
  end
  
end
