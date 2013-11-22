function [video_number] = extract_video_number(video_name)
	
	% regular expression that extracts the id as it is in corrupted videos
	% this is the functions that you should change for different video datasets
	video_number = str2num(regexp(video_name,'\d*','match','once'));

end