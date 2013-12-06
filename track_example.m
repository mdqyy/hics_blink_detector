clear all

addpath('tools/')
addpath('eyes_localisation/')
addpath('feature_extraction/')

% threshold
threshold = 19;

% initialise paths
video_path = '/data/';
shape_path = '/data/shapes/';
tracker   = 'cmu';
aam_path  = '/data/'; 
database = 'cultural-benchmarks';

% This the main function to track blinks
[nb_blinks,blink_ind,blink_duration_inf,nb_frames] = track_blinks(video_path,shape_path,aam_path,threshold,tracker,[],[]);
