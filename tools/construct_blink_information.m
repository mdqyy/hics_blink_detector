function [current_blink_inf] = construct_blink_information(video_number,blink_duration_inf,database,nb_frames,fps,window_length)

% we extract the blink start information and duration
% from the matrix blink_duration_inf. 1st and 2nd column
blink_start_ind = blink_duration_inf(:,1);
blink_duration  = blink_duration_inf(:,2);

% we initialize the output matrix
current_blink_inf = [];

for i=1:window_length:nb_frames-window_length
	
	% we find the indices that are inside the window
	ind = find(blink_start_ind >= i & blink_start_ind < i + window_length);

	% we calculate the number of blinks in the window
	blink_count = length(ind);

	% we calculate the mean blink duration in the window
	mean_blink_duration = 0;
	if blink_count~=0, mean_blink_duration = mean(blink_duration(ind))/fps; end

	% extracts question number from txt file of relevant database
	question_number = extract_question_number(database,video_number,i);

	% we calculate the temporal output matrix. the format is:
	% [id,blink_count,avg_blink_duration,time,question_number]
	temp_blink_inf = [video_number,blink_count,mean_blink_duration,i/fps];
	
	% we augment the output matrix and we continue
	current_blink_inf = [current_blink_inf;temp_blink_inf];

end

end