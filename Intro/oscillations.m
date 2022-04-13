x = 0.01:.001:0.1;

% employ a more elegant solution, 
% which discretizes using logarithimic properties
y = linspace(.01, .1, 100);

z = 10.^linspace(-2, -1, 200);
plot(z, sin(1./z))