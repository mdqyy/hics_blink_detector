function [ output_args ] = read_file( file_path, video_number )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

file = fopen(file_name);

% discard the first line
tline = fgets(file);
% ---------------------

%if isempty(video_number), read_all = true; else read_all = false; end

while(tline)
   
    curr_video_number = str2num( regexpr(tline,'\d+','match','once') );
    
    if strcmp( video_number, curr_video_number ) | read_all
       
        
        
    end
    
end

end

