function [nb_blinks,blink_ind,blink_duration_inf,video_name,video_number,nb_frames] = track_blinks(file_name,file_path,shape_path,threshold,start_frame,end_frame)

% extract the name as it appears on the file
video_name = strtok(file_name,'.');

% extract video number from the name
video_number = extract_video_number(video_name);

% loads shape 
shape = load_shape(shape_path,video_name,file_path);

% calculates distance from upward to downer eye points
eyes_distance = calculate_eyes_distance(shape);

% if start and end frame are undefined we track all the video
if ~exist('start_frame'), start_frame = 1;                     end
if ~exist('end_frame')  , end_frame   = length(eyes_distance); end
	
% the number of frames can be extracted from the dimension of eyes distance
nb_frames = length(eyes_distance);

% run blink detector and takes number of blink and blink indices as output
[nb_blinks,blink_ind] = blink_detector(eyes_distance,threshold,start_frame,end_frame);

% feed eyes distance and blink indices to this function
% to calculate true start and end frames
[blink_duration_inf] = blink_duration(eyes_distance,blink_ind);

end