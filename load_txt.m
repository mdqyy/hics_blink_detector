function [txt] = load_txt(txt_path,txt_name)

% loading the txt information
load([txt_path '/' txt_name])

% this has to do with the name of the variable in the mat
txt = dataset

% if txt path is empty we should create it
% next release

end