%%%%%%%%%%%
% A script which generates n random initial points 
% and visualises results of simulation of a 2d Hopfield network
%%%%%%%%%%

T = [1 1; -1 -1; 1 -1]';
net = newhop(T);
n=20;
timesteps=23
for i=1:n
    a={rands(2,1)}; % generate an initial point 
    % simulation of the network for 50 timesteps              
    [y,Pf,Af] = sim(net,{1 timesteps},{},a); 
    record=[cell2mat(a) cell2mat(y)]; % formatting results  
    start=cell2mat(a); % formatting results 
    % plot evolution
    plot(start(1,1),start(2,1),'bx',record(1,:),record(2,:),'r'); 
    hold on;
    % plot the final point with a green circle
    plot(record(1,timesteps),record(2,timesteps),'gO');  
end
legend('initial state','time evolution','attractor','Location', ...
    'northeast');
title('Time evolution in the phase space of 2d Hopfield model');
