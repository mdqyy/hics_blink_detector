function [rms] = calculate_eyes_distance(shape)
	
	% these points are specific to the tracker you use. FOR CMU TRACKER:
	upper_eye_points  = [21,22,27,28];
	downer_eye_points = [25,24,31,30];

    % calculate the dsquare distance between upper and downwer eye points
    % eyes_distance     = sum(squeeze(shape(upper_eye_points,2,:)-shape(downer_eye_points,2,:)).^2);

    % calculate root mean squared distance
    rms = rms_distance(shape(upper_eye_points,2,:),shape(downer_eye_points,2,:));

end