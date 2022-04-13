x = [2 5 1 6];
x = x + 16;
disp(x)

y = x;
y(1:2:end) = y(1:2:end) + 2;
disp(y)

z = sqrt(y)
disp(z)

disp(z.^2)