function [flag] = identify_corruption(video_name,corrupted_videos)

	% regular expression that extracts the id as it is in corrupted videos
	% this is the functions that you should change for different video datasets
	video_number = str2num(cell2mat(regexp(video_name,'\d*','match')));

	% boolena that returns whether our video is corrupted
	flag         = ismember(video_number,corrupted_videos);

end