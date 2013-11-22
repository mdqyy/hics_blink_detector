clear all

% frames per second for video
fps = 30.0;
% window size in seconds 
window_size = 5;
% we convert it to frames
window_length = window_size*fps;

% threshold
threshold = 22;

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

	[nb_blinks,blink_ind,blink_duration_inf,video_name,video_number,nb_frames] = track_blinks(video_list(i).name,video_path,shape_path,threshold);

	disp(video_name)

	% construct blink information in the format:
	% [id,blink_count,avg_blink_duration,time,question_number]
	current_blink_inf = construct_blink_information(video_number,blink_duration_inf, ...
													txt,nb_frames,fps,window_length);

	% this information is augmented in output matrix
	blink_information = [blink_information ; current_blink_inf];

end

save('blink_information.mat','blink_information')