function [question_number] = extract_question_number(database,video_number,i)

	if strcmp(database,'cultural-benchmarks')

		txt = load('txt.mat');

		question_number = txt.dataset(video_number).questions_frames2(i);

	end

end