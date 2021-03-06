function [percentage] = evaluate(path_to_testset, w, histogram, count_bins)
  correct_images = 0;
  % construiesc calea catre directorul cu pisici
  path_cats = strcat(path_to_testset, 'cats/');
  % extrag toate imaginile din acest director
  imgs_cat = getImgNames(path_cats);
  [n m] = size(imgs_cat);
  % iau fiecare imagine
  for i = 1:n
    img = imgs_cat(i,:);
    % construiesc calea
    path_to_image = strcat(path_cats, img);
    % verific tipul histogramei
    if histogram == 'RGB'
      x = rgbHistogram(path_to_image, count_bins);
    elseif histogram == 'HSV'
      x = hsvHistogram(path_to_image, count_bins);
    endif
    % adaug bias-ul
    x(3 * count_bins + 1) = 1;
    % verific daca este o pisica
    if w' * x' >= 0
      correct_images++;
    endif
  endfor
  % procedez la fel pentru directorul fara pisici
  path_not_cats = strcat(path_to_testset, 'not_cats/');
  imgs_not_cat = getImgNames(path_not_cats);
  [p q] = size(imgs_not_cat);
  for i = 1:p
    img = imgs_not_cat(i,:);
    path_to_image = strcat(path_not_cats, img);
    if histogram == 'RGB'
      x = rgbHistogram(path_to_image, count_bins);
    elseif histogram == 'HSV'
      x = hsvHistogram(path_to_image, count_bins);
    endif
    x(3 * count_bins + 1) = 1;
    if w' * x' < 0
      correct_images++;
    endif
  endfor
  % calculez procentul
  percentage = correct_images / (n + p);
endfunction