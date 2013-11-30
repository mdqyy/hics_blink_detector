function [result] = CMU_tracker(video_path,start_frame,end_frame)

% imports the path to the CMU code
addpath('~/Dropbox/Research/Code/SUPERVISED-DESCENT/')

input = video_path;

disp('Initializing tracker...');
[DM,TM,option] = xx_initialize;

% check input
if exist(input,'file') == 2 % if it is a file
  cap = cv.VideoCapture(input);
  frame_w = cap.get('FrameWidth');
  frame_h = cap.get('FrameHeight');
else
  error('Input file not exist');
end

pred   = [];
t = 1;

%% tracking and detection
while true
  
  im = cap.read;
  
  if isempty(im), 
    warning('EOF'); 
    break ;
  end
  
  % main function for tracking. previous prediction is used as an input to
  % initialize the tracker for the next frame.
  [pred,pose] = xx_track_detect(DM,TM,im,pred,option);
  if ~isempty(pred) > 0 %and pose presumably
    result{t}.pred = pred;
    result{t}.pose = pose;
  end
  
  
  t = t + 1;
  
end



end