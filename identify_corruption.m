function [flag] = identify_corruption(video_name,corrupted_videos)

	% extract video number information from the video name
	video_number = extract_video_number(video_name)

	% boolean that returns whether our video is corrupted
	flag         = ismember(video_number,corrupted_videos);

end