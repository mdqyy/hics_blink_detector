function [pos_examples,neg_examples,video_name] = read_dataset_information(data)

% This function is specific to the data we are feeding
% this means that it has to change everytime compared to 
% how blink information are stored
%
% The assumption here is that we have a struct data that:
% contains a matrix blinks,noblinks and a string name at least
%
% MATRIX BLINKS
% each row of the matrix blinks and no blinks represent a different blink
% first column represent the start frame of blink and second the end
%
% if you follow these convections and you name the matrices: blinks,noblinks
% and the string as name then you can use the function as it is
%
% Author: Nick Sorros
% email:  nsorros@gmail.com

pos_examples = data.blinks;
neg_examples = data.noblinks;
video_name   = data.name;

end