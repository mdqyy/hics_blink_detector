function [pos_examples,neg_examples,video_name] = read_dataset_information(data)

pos_examples = data.blinks;
neg_examples = data.noblinks;
video_name   = data.name;

end