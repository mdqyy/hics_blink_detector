function [current_blink_inf] = construct_blink_information(video_number,blink_duration_inf,txt,nb_frames,fps,window_length)

blink_start_ind = blink_duration_inf(:,1);
blink_duration  = blink_duration_inf(:,2);

blink_inf = zeros(nb_frames,2);
blink_inf(blink_start_ind,:) = [ones(size(blink_duration)),blink_duration];

current_blink_inf = [];

for i=1:window_length:nb_frames-window_length
	
	blink_count = sum(blink_inf(i:i+window_length-1,2));
	mean_blink_duration = mean(blink_inf(i:i+window_length-1,2))/fps;

	temp = [video_number,blink_count,mean_blink_duration,i/fps,txt(video_number).questions_frames2(i)];
	current_blink_inf = [current_blink_inf;temp];

end

end