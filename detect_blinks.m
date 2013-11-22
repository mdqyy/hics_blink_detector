clear all

% frames per second for video
fps = 30.0;
% window size in seconds 
window_length = 5;
% we convert it to frames
window = window_length*fps;

% threshold
threshold = 1900;

video_path = '/vol/hci2/projects/Aaron/DeceptionVideos/CulturalBenchmarks/CAM2';
shape_path = '/vol/bitbucket/ns2212/Shapes/normalized_shapes';

load('txt.mat')

video_list = dir([video_path '/*avi']);

blink_information = [];

for i=1:length(video_list)

	video_name = strtok(video_list(i).name,'.')
	video_number = str2num(regexp(video_name,'\d*','match','once'))

	shape = load_shape(shape_path,video_name,video_path);
	eyes_distance = calculate_eyes_distance(shape,video_name);
	[nb_blinks,blink_ind] = blink_detector(eyes_distance,threshold);
	[blink_duration_inf] = blink_duration(eyes_distance,threshold);

	current_blink_inf = construct_blink_information(video_number,blink_duration_inf,dataset,length(eyes_distance),fps,window_length);

	blink_information = [blink_information ; current_blink_inf];

end

save('blink_information.mat','blink_information')