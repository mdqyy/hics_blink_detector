function [ accuracy ] = calculate_accuracy( blink_matrix,indices, threshold, tracker, aam_path )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here


    for j=1:length(indices)

        disp(j)

        video_path  = blink_matrix{indices(j)}.video_path;
        shape_path  = blink_matrix{indices(j)}.shape_path;
        start_frame = blink_matrix{indices(j)}.start_frame;
        end_frame   = blink_matrix{indices(j)}.end_frame;
        target      = blink_matrix{indices(j)}.target;
            
        targets(j) = target;
            
        nb_blinks = track_blinks(video_path,shape_path,aam_path,threshold,tracker,start_frame,end_frame);

        predictions(j) = round( sigmf( nb_blinks,[1 1] ) );

    end

    confusion = create_confusion_matrix(targets,predictions);
        
    accuracy = confusion_to_accuracy(confusion);
        


end

