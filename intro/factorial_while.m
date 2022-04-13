% sample script for while loop
e = 0;
i = 0;
cont = true;

while cont
    e = e + 1/my_factorial(i);
    if i > 10
        cont = false;
    end
    i = i + 1;
end

disp(e)