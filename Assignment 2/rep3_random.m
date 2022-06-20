%%%%%%%%%%%
% A script which generates n random initial points
% and visualise results of simulation of a 3d Hopfield network
%%%%%%%%%%

T = [1 1 1; -1 -1 1; 1 -1 -1]';
net = newhop(T);
n=200;
for i=1:n
    a={rands(3,1)}; % generate an initial point
    % simulation of the network for 50 timesteps
    [y,Pf,Af] = sim(net,{1 50},{},a); 
    record=[cell2mat(a) cell2mat(y)]; % formatting results
    start=cell2mat(a); % formatting results 
    plot3(start(1,1),start(2,1),start(3,1),'bx', ...
        record(1,:),record(2,:),record(3,:),'r'); % plot evolution
    hold on;
    % plot the final point with a green circle
    plot3(record(1,50),record(2,50),record(3,50),'gO');  
end
grid on;
legend('initial state','time evolution','attractor','Location', ...
    'northeast');
title('Time evolution in the phase space of 3d Hopfield model');
