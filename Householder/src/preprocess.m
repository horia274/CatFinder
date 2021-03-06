function [X, y] = preprocess(path_to_dataset, histogram, count_bins)
  % formez calea catre cele 2 directoare
  path_cats = strcat(path_to_dataset, 'cats/');
  path_not_cats = strcat(path_to_dataset, 'not_cats/');
  % iau toate imaginile din aceste directoare
  imgs_cat = getImgNames(path_cats);
  imgs_not_cat = getImgNames(path_not_cats);
  [n m] = size(imgs_cat);
  [p q] = size(imgs_not_cat);
  % initializez X si y
  X = zeros(n + p, 3 * count_bins);
  y = zeros((n + p), 1);
  % completez vectorul y
  y(1:n) = 1;
  y(n + 1 : n + p) = -1;
  % construiesc matricea X
  % iau toate imaginile din directorul cu pisici
  for i = 1:n
    img = imgs_cat(i,:);
    % formez calea la fiecare imagine
    path_to_image = strcat(path_cats, img);
    % verific tipul histogramei si adaug informatia in matricea X
    if histogram == 'RGB'
      X(i,:) = rgbHistogram(path_to_image, count_bins);
    elseif histogram == 'HSV'
      X(i,:) = hsvHistogram(path_to_image, count_bins);
    endif
  endfor
  % procedez la fel cu directorul fara pisici
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
