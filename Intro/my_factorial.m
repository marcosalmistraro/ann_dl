function f = my_factorial(n)
    if n == 0
        f = 1;
    else
        f = n * my_factorial(n-1);
    end
end