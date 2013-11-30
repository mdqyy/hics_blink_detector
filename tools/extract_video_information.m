function [video_name,video_number] = extract_video_information(video_path,database)

	if strmcmp(datbase,'cultural-benchmarks')

		% regular expression that extracts the video name from video path
		video_name = regexp(video_path,'[\w\-]+\d{3}','match','once')

		% regular expression that extracts the id as it appears in the video name
		video_number = str2num(regexp(video_name,'\d*','match','once'));
		
	end

end