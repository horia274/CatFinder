function [w] = learn(X, y)
  [n m] = size(X);
  % adaug coloana de bias
  X(:,m+1) = ones(n,1);
  % rezolv sistemul
  [Q, R] = Householder(X);
  w = SST(R, Q' * y);
endfunction
