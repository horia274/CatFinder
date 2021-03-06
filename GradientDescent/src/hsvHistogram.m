function [sol] = hsvHistogram(path_to_image, count_bins)
  sol = zeros(1,3 * count_bins);
  [h s v] = RGB2HSV(path_to_image);
  
  index = fix(count_bins * h / 1.01) + 1;
  subs = reshape(index, [], 1);
  sol(1 : max(max(index))) = accumarray(subs, 1)';
  
  index = fix(count_bins * s / 1.01) + 1;
  subs = reshape(index, [], 1);
  sol(count_bins + 1 : count_bins + max(max(index))) = accumarray(subs, 1)';
  
  index = fix(count_bins * v / 1.01) + 1;
  subs = reshape(index, [], 1);
  sol(2 * count_bins + 1 : 2 * count_bins + max(max(index))) = accumarray(subs, 1)';
endfunction