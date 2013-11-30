function [upper_eye_points,downer_eye_points] = extract_eyes_indices(tracker)

	if strcmp(tracker,'cmu')
		% these points are specific to the tracker you use.
		% FOR CMU TRACKER:
		upper_eye_points  = [21,22,27,28];
		downer_eye_points = [25,24,31,30];
	end

end