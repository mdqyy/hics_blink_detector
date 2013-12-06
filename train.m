% INITIALIZE
clear all

% add all folders to the path
addpath(genpath('.'))

% initialise path to our data
blink_dataset_path = 'data/blink_dataset.mat';
aam_path = 'data/trained_precompute_p.mat';

% initialise directories for the rest of our data
shape_dir = '/vol/bitbucket/ns2212/Shapes/shapes';
video_dir = '/vol/hci2/projects/Aaron/DeceptionVideos/CulturalBenchmarks/CAM2';

% define which database we are working on
database = 'cultural-benchmarks';

% some videos may be badly tracked with the traker. It happens :P
corrupted_videos = [80,87,88,96,102,103,107:110,123,127,131,132,134];

% we will try to find which of these thresholds is optimal
threshold_range = [10:5:40];

% define which tracker we will use
tracker = 'cmu';

%
blink_matrix = convert_blink_dataset_to_matrix(blink_dataset_path,video_dir,shape_dir,corrupted_videos,database);

% randomply split our data to train and test
[trainInd,testInd,~] = dividerand(length(blink_matrix),0.8,0.2,0);

% use train to find optimal threshold
[optimal_threshold] = find_optimal_threshold(blink_matrix,trainInd,threshold_range, tracker, aam_path)

% and test to take an unbiased measure of the accuracy
[blink_accuracy blink_duration_accuracy] = calculate_accuracy( blink_matrix,testInd, optimal_threshold )