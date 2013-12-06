clear all

addpath( genpath('.') )

% threshold
threshold = 19;

% initialise paths

% if we have tracked the video the video dir can be empty
% if we need to track the video then shape can be empty
video_path = [];
shape_path = 'data/DACA-CB-170.mat';

tracker   = 'cmu';
aam_path  = 'data/trained_precompute_p.mat'; 
database = 'cultural-benchmarks';

start_frame = 1000;
end_frame   = 2000;

% This the main function to track blinks
[nb_blinks,blink_ind,blink_duration_inf,nb_frames] = track_blinks(video_path,shape_path,aam_path,threshold,tracker,start_frame,end_frame);
