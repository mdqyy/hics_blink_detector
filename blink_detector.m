function [nb_blinks,blink_ind] = blink_detector(eyes_distance,threshold,start_frame,end_frame)

% we take eyes_distance length as our coordinate frame for frame numbers

% if start and end frame are undefined we track all the video
if ~exist('start_frame'), start_frame = 1;                     end
if ~exist('end_frame')  , end_frame   = length(eyes_distance); end

% initialize number of blinks to zero
nb_blinks = 0;

% logical array with '1' everytime blink distance is above threshold and zero otherwise
above_thres      = eyes_distance(start_frame:end_frame) > threshold;

% convert logical to string
above_thres_str  = char(int8(above_thres)+'0');

% we recognize a blink everytime eyes_distance falls below threshold and then goes up again
% the output is the start and end indices of the blinks we detect.
[start_blink_ind,end_blink_ind] = regexp(above_thres_str,'0+1+');

% convert blink indices information to our output
blink_ind        = [start_blink_ind', end_blink_ind'];
nb_blinks        = size(blink_ind,1);

end

