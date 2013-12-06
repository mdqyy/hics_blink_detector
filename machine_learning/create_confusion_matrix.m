function [confusion_matrix] = create_confusion_matrix(predictions,targets)

	% SOS: We asssume that vector targets contain all unique labels
	unique_labels = unique(targets);

	confusion_matrix = zeros( length(unique_labels) );

	for i=1:length(predictions)

		row = find( unique_labels==targets(i) );

		column = find( unique_labels==predictions(i) );

		confusion_matrix(row,column) = confusion_matrix(row,column) + 1;

	end

end