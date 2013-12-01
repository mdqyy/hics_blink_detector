function [nb_blinks,blink_ind,blink_duration_inf,nb_frames] = track_blinks(video_path,shape_path,aam_path,threshold,tracker,start_frame,end_frame)

% This is the main function to track blinks with this blink detector
% 
% INPUT:  video_path: this is the absolut path to the video file
%
%		  shape_path: 	this is the absolut path to the shape file
%					  	that the tracker has tracker but can be empty
%
%		  aam_path:   	this is the absolut path to the trained AAM
%					  	model that is going to be used to normalise shape
%
%		  threshold	  	represents the threshold under the system 
%					  	recongizes a blink
% 
%		  tracker:     	string representing the tracker we will use
%					   	to track facial points
%
%		  start_frame: 	the first frame from the video that we will track
%		  end_frame:	the last frame
%
% OUTPUT: nb_blinks:		  the number of blinks contained between first and last frame
%
%         blink_ind:          is a two columns matrix, the first column
%                             of which represents the start frame of the 
%                             blink and the second the end.	
%
% 		  blink_duration_inf: is a column vector where each row represents
%                             the duration for each blink in blink ind
%		  nb_frames:
%
% Authos: Nick Sorros
% email:  nsorros@gmail.com

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