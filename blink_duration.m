function [blink_duration_inf] = blink_duration(eyes_distance,threshold,start_frame,end_frame)

if ~exist('start_frame'), start_frame = 1;                     end
if ~exist('end_frame')  , end_frame   = length(eyes_distance); end

[nb_blinks,blink_ind] = blink_detector(eyes_distance,threshold,start_frame,end_frame);

% initialize output matrix. The dimensions will be the same as blink ind
% since we want to calculate the true start and duration of the blink
blink_duration_inf = zeros(size(blink_ind,1),2);

% initialize windowSize to 5. This is used for filtering.
windowSize = 5;
filtered_signal = filter_signal(eyes_distance,windowSize);

for i=1:nb_blinks

	% we extract start and end frame information from blink ind
	% NOTE that these are different from start and end frame we pass as arguments
	start_frame = blink_ind(i,1); end_frame = blink_ind(i,2);

	% we find the maximum in both directions and take that as the start and end of the blink
	start_blink = find_maximum(eyes_distance,start_frame,'left');
	end_blink   = find_maximum(eyes_distance,end_frame,'right');

	% finally we store the results in our output matrix
	blink_duration_inf(i,:) = [start_blink,end_blink - start_blink + 1]; %[start_blink,end_blink]; 

end

end

function [index] = find_maximum(signal,index,direction)
  
  if strcmp(direction,'right'), change = 1; else change = -1; end;
  new_index = index + change;

  % exception case
  if new_index >= length(signal) |  new_index <= 1, return, end

  % base case 
  % if recursive case does not hold then stop

  % recursive case
  if signal(index+change) > signal(index), index = find_maximum(signal,new_index,direction); end

end

function [filtered_signal] = filter_signal(signal,windowSize)

  % we filter the signal using a mean filter with windowSize
  filtered_signal = filter(ones(1,windowSize)/windowSize,1,signal);

 end