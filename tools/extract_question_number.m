function [question_number] = extract_question_number(database,video_number,i)

	if strcmp(database,'cultural-benchmarks')

		%txt = readCulturalTxt();
		load('txt.mat')
		txt = dataset;

		question_number = txt(video_number).questions_frames2(i);

	end

end