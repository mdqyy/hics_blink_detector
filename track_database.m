clear all

addpath('tools/')
addpath('eyes_localisation/')
addpath('feature_extraction/')

% frames per second for video
fps = 30.0;
% window size in seconds 
window_size = 5;
% we convert it to frames
window_length = window_size*fps;

% threshold
threshold = 22;

% these paths are specifics to the video dataset and the folder we store shapes
video_dir = '/vol/hci2/projects/Aaron/DeceptionVideos/CulturalBenchmarks/CAM2';
shape_dir = '/vol/bitbucket/ns2212/Shapes/shapes';
extension = 'avi';
tracker   = 'cmu';
aam_path  = './data/trained_precompute_p.mat'; 
txt_path = '.';
database = 'cultural-benchmarks';

% load information from txt file such as question numbers subject id etc
% txt = load_txt(txt_path,'txt.mat');
% load('txt.mat')
% txt = dataset;

% we create a list with all the videos in our database
video_list = dir( [ video_dir '/' '*.' extension] );

% initialize blink information matrix
blink_information = [];

for i=1:length(video_list)

	% construct the path for the video
	video_path = [ video_dir '/' video_list(i).name ];

	% extract the video name and number from the video path
	[video_name,video_number] = extract_video_information(video_path,database);

	% constructs the shape path if exists
	[shape_path] = extract_shape_information(shape_dir,video_name);

	% main function to track blink count and duration
	[nb_blinks,blink_ind,blink_duration_inf,nb_frames] = track_blinks(video_path,shape_path,aam_path,threshold,tracker,[],[]);

	disp(video_name)

	% construct blink information in the format:
	% [id,blink_count,avg_blink_duration,time,question_number]
	current_blink_inf = construct_blink_information(video_number,blink_duration_inf, ...
													database,nb_frames,fps,window_length);

	% this information is augmented in output matrix
	blink_information = [blink_information ; current_blink_inf];

end

save('blink_information.mat','blink_information')