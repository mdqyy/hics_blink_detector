function [normalized_shape] = normalise_shape(shape,AAM_model_path)

scale = 1;
load(AAM_model_path)

% CHECK IF WE CAN WRITE THIS FUNCTION VECTORIZED

normalized_shape = zeros(size(shape),'single');
for i=1:size(shape,3)
  
    
	test_shape = double( shape(:,:,i) );

	similarity_eigenvecs = shape_space{scale}.similarity_eigenvecs;
	pose_eigenvecs = shape_space{scale}.eigenvecs(:,1:2);
	mean_shape = data.mean_shape(scale, :, :);

	unshifted_normalized_shape = remove_pose_similarities(test_shape,mean_shape,similarity_eigenvecs,pose_eigenvecs);
	unshifted_normalized_shape = reshape(unshifted_normalized_shape, [], 2);
   

    % store the result
    normalized_shape(:,:,i) = unshifted_normalized_shape;
end

end