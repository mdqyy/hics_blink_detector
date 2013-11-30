function [shape] = load_shape(shape_path,video_name,video_path)

	% if shape path is not empty we load the shape
	if ~isempty(shape_path)

		% loading 
		mat = dir([shape_path '/' video_name '*.mat']);
	    load([shape_path '/' mat.name])

	    % this is specific to the name of the variable that in the mat file
	    shape = normalized_shape;

	% if shape path is empty we have to track the video
	else
    	
    	% we track the video using the CMU tracker
		unormalised_shape = CMU_tracker(video_path,video_name);

		shape = normalise_shape(unormalised_shape);

    end
    		

end