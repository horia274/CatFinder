function [Q, R] = Householder(A)
[m n] = size(A);
  Q = eye(m);
  for i = 1:n
    % construiesc reflectorul Householder
    v = zeros(m,1);
    v(i+1:m) = A(i+1:m,i);
    v(i) = A(i,i) - sign(A(i,i)) * norm(A(i:m,i));
    H = eye(m) - 2 * v * v' / norm(v)^2;
    % actualizez matricile Q si R
    A = H * A;
    Q = Q * H';
    R = A;
  endfor
endfunction