function [eyes_distance] = calculate_eyes_distance(shape,tracker)

	% this function is tracker specific and indicates where the upper and downer poins are
    [upper_eye_ind,downer_eye_ind] = extract_eyes_indices(tracker);   

    % calculate root mean squared distance
    eyes_distance = rms_distance(shape(upper_eye_ind,2,:),shape(downer_eye_ind,2,:),1);
    
end