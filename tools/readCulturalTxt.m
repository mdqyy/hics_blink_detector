function [dataset] = readCulturalTxT()

% This script reads the file CulturalBenchmarksConditionsTimes.txt
% and extracts the information in a vector of structs called dataset
%
% Cultural Benchmarks is a database provided by Aaron Elkins that
% contains a deception experiment with 220 subjects.
%
% Each subject is asked 24 questions.
% The first 12 are short questions (Yes/No).
% The rest are long descriptive questions.
% The subjects is instructed to tell the truth or lie in each question.
% The short questions have two different sets of instructions.
%
% dataset(i).subject_id: this is the id of the subject of sibject i
% dataset(i).short_condition: this is the condition type
%
% Author: Nick Sorros
% iBUG group

% INITIALIZE

%condition1 = ['D';'T';'D';'D';'T';'T';'T';'D';'T';'T';'D';'D'];
%condition2 = ['D';'T';'T';'T';'D';'D';'T';'D';'D';'D';'T';'T'];
veracity_instruction(:,1) = ['D';'D';'D';'T';'T';'T';'D';'D';'D';'T';'T';'T';'T'];
veracity_instruction(:,2) = ['T';'T';'T';'D';'D';'D';'T';'T';'T';'D';'D';'D';'D'];
file_name = 'data/CulturalBenchmarksConditionsTimes.txt';
file = fopen(file_name);
questions_frames = zeros(13,2);
questions_frames_alternative = zeros(60000,1);

% MAIN

% discard the first line
tline = fgets(file);
% ---------------------

tline = fgets(file);
while (tline~=-1)
    % split the informations on the line
    [subject_id remain]        = strtok(tline);
    [question_type remain]     = strtok(remain);
    [question_number remain]   = strtok(remain);
    [condition remain]         = strtok(remain);
    [~,remain]                 = strtok(remain);
    [~,remain]                 = strtok(remain);
    [~,remain]                 = strtok(remain);
    [start_frame remain]       = strtok(remain);
    [~,remain]                 = strtok(remain);
    [end_frame remain]         = strtok(remain);
    % -----------------------------------------

    % deals with noise in the txt :P
    if isempty(start_frame), start_frame = '1'; end_frame = '2'; end
    % ----------------------------------------
    
    % store informations in a struct
    index = str2num(subject_id); %- 70 + 1
    dataset(index).subject_id = subject_id;
    dataset(index).condition = condition;
    if strcmp(question_type,'"OpenEnded"'), questions_frames(str2num(question_number),:) = [str2num(start_frame) str2num(end_frame)]; end
    if strcmp(question_type,'"OpenEnded"'), questions_frames_alternative(str2num(start_frame):str2num(end_frame)) = str2num(question_number); end
    dataset(index).questions_frames = questions_frames;
    dataset(index).questions_frames2 = questions_frames_alternative;
    dataset(index).veracity = veracity_instruction(:,str2num(condition));
    % --------------------------------
    
    % read next line
    tline = fgets(file);
end

save('txt.mat','dataset')