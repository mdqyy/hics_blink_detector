% INITIALIZE
clear all

addpath(genpath('.'))

blink_dataset_path = 'data/blink_dataset.mat';
aam_path = 'data/trained_precompute_p.mat';

shape_dir = '/vol/bitbucket/ns2212/Shapes/shapes';
video_dir = '/vol/hci2/projects/Aaron/DeceptionVideos/CulturalBenchmarks/CAM2';

database = 'cultural-benchmarks';
corrupted_videos = [80,87,88,96,102,103,107:110,123,127,131,132,134];

threshold_range = [10:5:40];

tracker = 'cmu';

blink_matrix = convert_blink_dataset_to_matrix(blink_dataset_path,video_dir,shape_dir,corrupted_videos,database);

[trainInd,testInd,~] = dividerand(length(blink_matrix),0.8,0.2,0);

[optimal_threshold] = find_optimal_threshold(blink_matrix,trainInd,threshold_range, tracker, aam_path)

accuracy = calculate_accuracy( blink_matrix,testInd, optimal_threshold )