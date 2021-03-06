function [w] = learn(X, y, lr, epochs)
  [n m] = size(X);
  % adaug termenii bias
  X(:,m+1) = 1;
  % pornez cu valori random pentru w
  w = 0.2 * rand(m + 1, 1) - 0.1;
  % scalez coloanele din X
  X(:,1:m) = (X(:,1:m) - mean(X(:,1:m))) ./ std(X(:,1:m));
  
  % repet algortimul pentru a forma w
  for epoch = 1:epochs
    % iau 64 permutari random din intervalul 1,n
    k = randperm(n, 64);
    % extrag liniile random si etichetele corespunzatoare
    X_batch = X(k,:);
    y_batch = y(k);
    % folosesc formula din enunt
    s = (X_batch * w - y_batch) .* X_batch;
    w = w - lr * sum(s)' / n;
  endfor
endfunction
