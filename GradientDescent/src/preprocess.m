function [X, y] = preprocess(path_to_dataset, histogram, count_bins)
  path_cats = strcat(path_to_dataset, 'cats/');
  path_not_cats = strcat(path_to_dataset, 'not_cats/');

  imgs_cat = getImgNames(path_cats);
  imgs_not_cat = getImgNames(path_not_cats);
  [n m] = size(imgs_cat);
  [p q] = size(imgs_not_cat);
  
  X = zeros(n + p, 3 * count_bins);
  y = zeros((n + p), 1);
  y(1:n) = 1;
  y(n + 1 : n + p) = -1;
  
  for i = 1:n
    img = imgs_cat(i,:);
    path_to_image = strcat(path_cats, img);
    if histogram == 'RGB'
      X(i,:) = rgbHistogram(path_to_image, count_bins);
    elseif histogram == 'HSV'
      X(i,:) = hsvHistogram(path_to_image, count_bins);
    endif
  endfor
  
  for i = 1:p
    img = imgs_not_cat(i,:);
    path_to_image = strcat(path_not_cats, img);
    if histogram == 'RGB'
      X(n+i,:) = rgbHistogram(path_to_image, count_bins);
    elseif histogram == 'HSV'
      X(n+i,:) = hsvHistogram(path_to_image, count_bins);
    endif
  endfor
endfunction
