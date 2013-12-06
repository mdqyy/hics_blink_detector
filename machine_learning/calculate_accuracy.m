function [ blink_accuracy blink_duration_accuracy] = calculate_accuracy( blink_matrix,indices, threshold, tracker, aam_path )

    nb_examples = length(indices);

    targets              = zeros(nb_examples,1);
    predictions          = zeros(nb_examples,1);
    blink_duration_error = zeros(nb_examples,1);
    
    for j=1:length(indices)

        disp(j)

        video_path  = blink_matrix{indices(j)}.video_path;
        shape_path  = blink_matrix{indices(j)}.shape_path;
        start_frame = blink_matrix{indices(j)}.start_frame;
        end_frame   = blink_matrix{indices(j)}.end_frame;
        target      = blink_matrix{indices(j)}.target;
            
        targets(j) = target;
            
        [nb_blinks blink_duration] = track_blinks(video_path,shape_path,aam_path,threshold,tracker,start_frame,end_frame);

        predictions(j) = min( nb_blinks,1 ) ;
        
        if nb_blinks > 0,
            blink_duration_error(j) = sum( ( [start_frame end_frame] - blink_duration( 1,:) ) .^2 );
        end
        
    end

    confusion = create_confusion_matrix(targets,predictions);
        
    blink_accuracy = confusion_to_accuracy(confusion);
        
    blink_duration_accuracy = sqrt( sum( blink_duration_error ) );

end

