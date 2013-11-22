
% INITIALIZE
clear all
normalized_shape_path = '/vol/bitbucket/ns2212/Shapes/normalized_shapes';
dataset_path = '../Proposed system';
confusion_matrix = zeros(2);
threshold_range = [1000:500:4000];
corrupted_videos = [80,87,88,96,102,103,107:110,123,127,131,132,134];

% LOAD DATASET
disp('loading..')
load([dataset_path '/dataset2.mat']);

for i=1:length(threshold_range)
	threshold = threshold_range(i)

	nb_train_videos = length(dataset);
	for j=1:nb_train_videos

		[positive_examples,negative_examples,video_name] = read_dataset_information(dataset{j});
		shape = load_shape(normalized_shape_path,video_name,video_path);

		if identify_corruption(video_name,corrupted_videos)
			disp('video corrupted')
		else
			disp(video_name)
			true_positive = detect_blinks(positive_examples,threshold,shape,video_name);
			false_positive = detect_blinks(negative_examples,threshold,shape,video_name);

			nb_examples = size(positive_examples,1);
			confusion_matrix = confusion_matrix + [true_positive,nb_examples-true_positive;false_positive,nb_examples-false_positive];
		end
	end

	confusion_matrix
	accuracy(i) = (confusion_matrix(1)+confusion_matrix(4))/(sum(confusion_matrix(:)));
	confusion_matrix = zeros(2);
end

accuracy
optimal_threshold = threshold_range(max(accuracy)==accuracy)