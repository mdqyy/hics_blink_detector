function [accuracy,recall,precision,f_one] = confusion_to_accuracy(confusion_matrix)

	[rows cols] = size(confusion_matrix);
	
	accuracy = trace(confusion_matrix) / sum( confusion_matrix(:) );

	for i = 1:rows
	    recall(i)    = confusion_matrix(i,i) / (sum(confusion_matrix(i,:))+eps);
	    precision(i) = confusion_matrix(i,i) / (sum(confusion_matrix(:,i))+eps);
	end

	f_one = '';
	

end