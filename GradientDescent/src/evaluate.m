function [percentage] = evaluate(path_to_testset, w, histogram, count_bins)
  correct_images = 0;
  % construiesc matricea si vectorul cu imaginile din testset
  [X, y] = preprocess(path_to_testset, histogram, count_bins);
  [n m] = size(X);
  X(:,m+1) = 1;
  % scalez pe coloane
  X(:,1:m) = (X(:,1:m) - mean(X(:,1:m))) ./ std(X(:,1:m));
  % verific ce poze sunt considerate corecte
  for i = 1:n
    if w' * X(i,:)' >= 0 && y(i) == 1
      correct_images++;
    elseif w' * X(i,:)' < 0 && y(i) == -1
      correct_images++;
    endif
  endfor
  % calculez procentul
  percentage = correct_images / n;
endfunction