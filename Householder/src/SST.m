function [x] = SST(A, b)
  [n m] = size(A);
  x = zeros(m,1);
  % parcurg sistemul de la ultima linie
  % folosesc valorile din x determinate la pasii anteriori
  for k = m : -1 : 1
    s = sum(A(k, k + 1 : m) * x(k + 1 : m));
    x(k) = (b(k) - s) / A(k, k);
  endfor
endfunction
    