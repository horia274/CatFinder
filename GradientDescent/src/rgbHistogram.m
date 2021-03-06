function [sol] = rgbHistogram(path_to_image, count_bins)
  sol = zeros(1,3 * count_bins);
  im = imread(path_to_image);
  R = im(:,:,1);
  G = im(:,:,2);
  B = im(:,:,3);

  index = fix(count_bins * double(R(:,:)) / 256) + 1;
  subs = reshape(index, [], 1);
  sol(1 : max(max(index))) = accumarray(subs, 1)';

  index = fix(count_bins * double(G(:,:)) / 256) + 1;
  subs = reshape(index, [], 1);
  sol(count_bins + 1 : count_bins + max(max(index))) = accumarray(subs, 1)';

  index = fix(count_bins * double(B(:,:)) / 256) + 1;
  subs = reshape(index, [], 1);
  sol(2 * count_bins + 1 : 2 * count_bins + max(max(index))) = accumarray(subs, 1)';
endfunction