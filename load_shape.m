function [] = load_shape(shape_path,video_name,video_path)

	% LOADING
	mat = dir([shape_path '/' video_name '*.mat']);
    load([shape_path '/' mat.name])

    % this is specific to the name of the variable that in the mat file
    shape = normalized_shape;

    % if shape path is empty we have to track the video

end