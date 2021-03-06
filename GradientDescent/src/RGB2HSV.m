function [h s v] = RGB2HSV(path_to_image)
  im = imread(path_to_image);
  R = double(im(:,:,1));
  G = double(im(:,:,2));
  B = double(im(:,:,3));
  R /= 255;
  G /= 255;
  B /= 255;
  r = reshape(R, [], 1);
  g = reshape(G, [], 1);
  b = reshape(B, [], 1);
  cmax = max(r, max(g, b));
  cmin = min(r, min(g, b));
  delta = cmax - cmin;
  
  h(delta == 0) = 0;
  h(delta != 0 & cmax == r) = 60 * mod((g(delta != 0 & cmax == r) - b(delta != 0 & cmax == r)) ./ delta(delta != 0 & cmax == r), 6);
  h(delta != 0 & cmax == g) = 60 * ((b(delta != 0 & cmax == g) - r(delta != 0 & cmax == g)) ./ delta(delta != 0 & cmax == g) +2);
  h(delta != 0 & cmax == b) = 60 * ((r(delta != 0 & cmax == b) - g(delta != 0 & cmax == b)) ./ delta(delta != 0 & cmax == b) + 4);
  h /= 360;
  s(cmax == 0) = 0;
  s(cmax != 0) = delta(cmax != 0) ./ cmax(cmax != 0);
  v = cmax;
endfunction