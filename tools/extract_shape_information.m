function [shape_path] = extract_shape_information(shape_dir,video_name)

	mat = dir([shape_dir '/' video_name '*.mat']);

	if isempty(mat)

		shape_path = []; 

	else 

		shape_path = [shape_dir '/' mat.name]; 

	end

end