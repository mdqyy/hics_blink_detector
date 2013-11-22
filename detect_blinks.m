clear all

% frames per second for video
fps = 30.0;
% window size in seconds 
window_size = 5;
% we convert it to frames
window_length = window_size*fps;

% threshold
threshold = 1900;

% these paths are specifics to the video dataset and the folder we store shapes
video_path = '/vol/hci2/projects/Aaron/DeceptionVideos/CulturalBenchmarks/CAM2';
shape_path = '/vol/bitbucket/ns2212/Shapes/normalized_shapes';
txt_path = '.';

% load information from txt file such as question numbers subject id etc
%txt = load_txt(txt_path,'txt.mat');
load('txt.mat')
txt = dataset;

% we create a list with all the videos in our database
video_list = dir([video_path '/*avi']);

% initialize blink information matrix
blink_information = [];

for i=1:length(video_list)

	% extract the name as it appears on the file
	video_name = strtok(video_list(i).name,'.');
	disp(video_name)

	% extract video number from the name
	video_number = extract_video_number(video_name);

	% loads shape 
	shape = load_shape(shape_path,video_name,video_path);

	% calculates distance from upward to downer eye points
	eyes_distance = calculate_eyes_distance(shape,video_name);

	% the number of frames can be extracted from the dimension of eyes distance
	nb_frames = length(eyes_distance);

	% run blink detector and takes number of blink and blink indices as output
	[nb_blinks,blink_ind] = blink_detector(eyes_distance,threshold);

	% feed eyes distance and blink indices to this function
	% to calculate true start and end frames
	[blink_duration_inf] = blink_duration(eyes_distance,blink_ind);

	% construct blink information in the format:
	% [id,blink_count,avg_blink_duration,time,question_number]
	current_blink_inf = construct_blink_information(video_number,blink_duration_inf,txt,nb_frames,fps,window_length);

	% this information is augmented in output matrix
	blink_information = [blink_information ; current_blink_inf];

end

save('blink_information.mat','blink_information')