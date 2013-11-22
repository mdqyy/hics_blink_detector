function [eyes_distance] = calculate_eyes_distance(shape,video_name)
	
	% these points are specific to the tracker you use. FOR CMU TRACKER:
	upper_eye_points  = [21,22,27,28];
	downer_eye_points = [25,24,31,30];

    % calculate the dsquare distance between upper and downwer eye points
    eyes_distance     = sum(squeeze(shape(upper_eye_points,2,:)-shape(downer_eye_points,2,:)).^2);
    
    % to calculate mean euclidean distance
    % eyes_distance = pdist2(shape(upper_eye_points,2,:),shape(downer_eye_points,2,:),'euclidean');
    % mean_eyes_distance = eyes_distance/length(upper_eye_points);

end