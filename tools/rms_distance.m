function [rms] = rms_distance(matrix_a,matrix_b,dm_of_variables) 

% we have to include the case of inequal matrices

% calculate number of variables
if ~exist('dm_of_variables'), nb_variables = length(matrix_a); 
else nb_variables = size(matrix_a,dm_of_variables); end

% we calculate the squared root of the sum of the squared distanced between 
% two vectors. The function works also for multiple vectors in form of
% matrices where each row is a vector.
rms = sqrt( sum( (matrix_a - matrix_b).^2) / nb_variables );

end