function [rms] = rms_distance(vector_a,vector_b) 

rms = sqrt( sum( (vector_a - vector_b).^2) / length(vector_a) );

end