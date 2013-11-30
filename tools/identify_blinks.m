function [nb_blinks] = identify_blinks(examples,threshold,shape,video_name)

% initialize number of blinks to zero
nb_blinks = 0;

% calculate the difference from upper to downer eye points
eyes_distance = calculate_eyes_distance(shape);

nb_examples = size(examples,1);
for i=1:nb_examples

	% We extract the frame information from the matrix examples	
	start_frame = examples(i,1); end_frame = examples(i,2);

	% We measure the blinks using our blink detector
	nb_blinks = nb_blinks + blink_detector(eyes_distance,threshold,start_frame,end_frame);

end

end