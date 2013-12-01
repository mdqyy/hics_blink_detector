function [shape] = facial_feature_extraction(shape_path,video_path,tracker,start_frame,end_frame)

	if strcmp(tracker,'cmu')

		% if shape path is not empty we load the shape
		if ~isempty(shape_path)

			% outputs a cell array result
			load(shape_path)

		% if shape path is empty we have to track the video
		else
	    	
		    % we track the video using the CMU tracker
			result = CMU_tracker(video_path);

	    end

	    
    	% if start and end frame are undefined we track all the video
		if isempty(start_frame), start_frame = 1;             end
		if isempty(end_frame)  , end_frame   = length(result);end


    	% we convert the result of cmu tracker to a matrix
		shape = convert_cmu_cell_to_matrix(result,start_frame,end_frame);

	end

end

function [matrix] = convert_cmu_cell_to_matrix(cell_struct,start_frame,end_frame)

	%nb_frames = length(cell_struct);
	shape_dimensions = size(cell_struct{find(~cellfun('isempty',cell_struct),1)}.pred);

	matrix = zeros([shape_dimensions , end_frame - start_frame + 1],'single');

	for i=start_frame:end_frame

		if ~isempty(cell_struct{i})
			matrix(:,:,i-start_frame+1) = cell_struct{i}.pred;
		end

	end

end