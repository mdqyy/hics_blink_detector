clear all

% threshold
threshold = 22

% these paths are specifics to the video dataset and the folder we store shapes
video_path = '/vol/hci2/projects/Aaron/DeceptionVideos/CulturalBenchmarks/CAM2';
shape_path = '/vol/bitbucket/ns2212/Shapes/normalized_shapes';

load('../aaron.mat')

load('txt.mat')

video_list = unique(blink_information(:,1));

nb_videos = length(video_list);
for i=1:nb_videos
	video_number = video_list(i);
	file_name = ['DACA-CB-' num2str(video_number,'%03d') '.avi'];
	disp(file_name)

	ind              = find(blink_information(:,1)==video_list(i));
	old_nb_blinks(i) = sum(blink_information(ind,2));

	question_frames = dataset(video_number).questions_frames(1);
	start_frame = question_frames(1);

	new_nb_blinks(i) = track_blinks(file_name,video_path,shape_path,threshold,start_frame);
end

rms = sqrt(sum((old_nb_blinks-new_nb_blinks).^2)/nb_videos)