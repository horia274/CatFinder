function [sol] = rgbHistogram(path_to_image, count_bins)
  sol = zeros(1,3 * count_bins);
  im = imread(path_to_image);
  
  % formez matricile R G B
  R = im(:,:,1);
  G = im(:,:,2);
  B = im(:,:,3);
  
  % construiesc o matrice index, ce contine indicii i, astfel incat
  % pixelul corespunzator din R, sa se afle in intervalul cerut
  index = fix(count_bins * double(R(:,:)) / 256) + 1;
  % transform aceasta matrice intr-un vector coloana
  subs = reshape(index, [], 1);
  % numar cati indici sunt de fiecare tip si completez vectorul sol
  sol(1 : max(max(index))) = accumarray(subs, 1)';

  % procedez la fel pentru matricile G si B
  index = fix(count_bins * double(G(:,:)) / 256) + 1;
  subs = reshape(index, [], 1);
  sol(count_bins + 1 : count_bins + max(max(index))) = accumarray(subs, 1)';

  index = fix(count_bins * double(B(:,:)) / 256) + 1;
  subs = reshape(index, [], 1);
  sol(2 * count_bins + 1 : 2 * count_bins + max(max(index))) = accumarray(subs, 1)';
endfunction