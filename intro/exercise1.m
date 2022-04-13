A = rand(8, 8);
disp(A)
disp(min(A))
disp(min(A'))
disp(min(A, [], 2))
disp(max(max(A)))
[~, indexes] = max(A)
[maxvalues, ~] = max(A)
[~, maxindex] = max(maxvalues)