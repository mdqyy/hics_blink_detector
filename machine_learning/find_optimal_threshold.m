function [optimal_threshold] = find_optimal_threshold(blink_matrix,indices,threshold_range, tracker, aam_path)

    for i=1:length(threshold_range)
    
        threshold = threshold_range(i);

        disp(threshold)
        
        accuracy(i) = calculate_accuracy( blink_matrix,indices, threshold ,tracker ,aam_path);
        
    end

    optimal_threshold = threshold_range(max(accuracy)==accuracy);
    
end