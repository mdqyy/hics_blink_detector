function [matrix] = convert_blink_dataset_to_matrix(blink_dataset_path,video_dir,shape_dir,corrupted_videos,database)

load(blink_dataset_path)

index = 1;

nb_videos = length(blink_dataset);
for i=1:nb_videos
	video_mat = dir([video_dir '/' blink_dataset{i}.name '*.avi']);
	shape_mat = dir([shape_dir '/' blink_dataset{i}.name '*.mat']);

    [~,video_number] = extract_video_information([video_dir '/' video_mat.name],database);
    
	if ismember(video_number,corrupted_videos)
		disp('video corupted')
	else
		nb_rows = size(blink_dataset{i}.blinks,1);
		for j=1:nb_rows

			matrix{index}.start_frame  = blink_dataset{i}.blinks(j,1);
			matrix{index}.end_frame    = blink_dataset{i}.blinks(j,2);
			matrix{index}.video_path   = [video_dir '/' video_mat.name];
			matrix{index}.shape_path   = [shape_dir '/' shape_mat.name]; 
			matrix{index}.target       = 1;

			index = index + 1;
		end

		for j=1:nb_rows

			matrix{index}.start_frame  = blink_dataset{i}.noblinks(j,1);
			matrix{index}.end_frame    = blink_dataset{i}.noblinks(j,2);
			matrix{index}.video_path   = [video_dir '/' video_mat.name];
			matrix{index}.shape_path   = [shape_dir '/' shape_mat.name]; 
			matrix{index}.target       = 0;

			index = index + 1;
		end
	end

end

end