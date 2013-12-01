function [nb_blinks,blink_ind] = blink_detector(eyes_distance,threshold)

% INPUT:  eyes_distance       is a vector that represents the distance
%                             between upper and downer eye points
%
%		  threshold			  represents the threshold under the system 
%							  recongizes a blink
%
% OUTPUT: nb_blinks			  number of blinks contained in the vector
%							  eyes distance
%
%         blink_ind           is a two columns matrix, the first column
%                             of which represents the start frame of the 
%                             blink and the second the end.
%
% Author: Nick Sorros
% email:  nsorros@gmail.com

% initialize number of blinks to zero
nb_blinks = 0;

% logical array with '1' everytime blink distance is above threshold and zero otherwise
above_thres      = eyes_distance > threshold;

% convert logical to string
above_thres_str  = char(int8(above_thres)+'0');

% we recognize a blink everytime eyes_distance falls below threshold and then goes up again
% the output is the start and end indices of the blinks we detect.
[start_blink_ind,end_blink_ind] = regexp(above_thres_str,'0+1');

% convert blink indices information to our output
blink_ind        = [start_blink_ind', end_blink_ind'];
nb_blinks        = length(start_blink_ind);

end

