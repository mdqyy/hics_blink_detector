function [ similarity_pose_free_shape ] = remove_pose_similarities( shape, mean_shape, similarity_vecs, pose_eigenvecs )
%remove_pose_similarities This function removes pose and similarities from
%a given shape
% 
% Parameters
% ----------
% texture         : texture of the new image, array of size n_pixels
% shape           : shape of the new image, array of size n_edges
% similarity_vecs : matrix of size (n_pixels, 4)
%                   (we represent the similarities with 4 eigenvectors)
% pose_eigenvecs  : matrix of size (n_pixels, N) where N is between 1 and 6
%                   (6 eigenvecs are enough to represent 3D poses in a 2D
%                   image)
%
% RETURNS
% -------
% similarity_pose_free_shape: original shape with pose and similarities
%                             removed
% warped_texture            : original texture warped onto the similarity
%                             and pose free shape

% flattening the shape
shape = shape(:);

% Remove similarity by projecting on the orthogonal of the similarity space
% (which is represented by 4 eigen-vectors)
mean_shape = squeeze(mean_shape);
mean_shape = mean_shape(:);

similarity_pose_free_shape = shape - similarity_vecs*(similarity_vecs'*(shape - mean_shape)) + mean_shape;
similarity_pose_free_shape = similarity_pose_free_shape - pose_eigenvecs*(pose_eigenvecs'*(similarity_pose_free_shape - mean_shape)) + mean_shape;

end




