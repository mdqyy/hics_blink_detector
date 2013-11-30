function [nb_blinks,blink_ind,blink_duration_inf,nb_frames] = track_blinks(video_path,shape_path,aam_path,threshold,tracker,start_frame,end_frame)


% facial feature points tracking
unormalised_shape = facial_feature_extraction(shape_path,video_path,tracker,start_frame,end_frame);

% we normalise the shape to remove pose and scale variations
normalised_shape = normalise_shape(unormalised_shape,aam_path);

% calculates distance from upward to downer eye points
eyes_distance = calculate_eyes_distance(normalised_shape,tracker);

% the number of frames can be extracted from the dimension of eyes distance
nb_frames = length(eyes_distance);

% run blink detector and takes number of blink and blink indices as output
[nb_blinks,blink_ind] = blink_detector(eyes_distance,threshold);

% feed eyes distance and blink indices to this function
% to calculate true start and end frames
[blink_duration_inf] = blink_duration(eyes_distance,blink_ind);

end