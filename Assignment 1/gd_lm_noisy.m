clear
clc
close all

%%%%%%%%%%%
% A script comparing performance of 'trainlm' and 'traingd'
% trainlm - Levenberg - Marquardt
% traingd - Gradient descent
%%%%%%%%%%%

% configuration
alg1 = 'trainlm'; % first training algorithm to use
alg2 = 'traingd'; % second training algorithm to use
H = 50; % number of neurons in the hidden layer
delta_epochs = [1,15,1000]; % number of epochs to train in each step
epochs = cumsum(delta_epochs);

% generation of examples and targets
dx=0.05; % decrease this value to increase the number of data points
x=0:dx:3*pi;y=sin(x.^2);
sigma=0.2; % standard deviation of added noise
yn=y+sigma*randn(size(y)); % add gaussian noise
t=yn; % targets. Change to yn to train on noisy data

% creation of networks
net1=feedforwardnet(H,alg1); % define the feedfoward net (hidden layers)
net2=feedforwardnet(H,alg2);
net1=configure(net1,x,t); % set the input and output sizes of the net
net2=configure(net2,x,t);
% use training set only (no validation and test split)
net1.divideFcn = 'dividetrain';
net2.divideFcn = 'dividetrain';
net1=init(net1); % initialize the weights (randomly)
% set the same weights and biases for the networks
net2.iw{1,1}=net1.iw{1,1}; 
net2.lw{2,1}=net1.lw{2,1};
net2.b{1}=net1.b{1};
net2.b{2}=net1.b{2};

% training and simulation
% set the number of epochs for training 
net1.trainParam.epochs=delta_epochs(1); 
net2.trainParam.epochs=delta_epochs(1);
net1=train(net1,x,t); % train the networks
net2=train(net2,x,t);
% simulate networks with input vector x
a11=sim(net1,x); a21=sim(net2,x); 

net1.trainParam.epochs=delta_epochs(2);
net2.trainParam.epochs=delta_epochs(2);
net1=train(net1,x,t);
net2=train(net2,x,t);
a12=sim(net1,x); a22=sim(net2,x);

net1.trainParam.epochs=delta_epochs(3);
net2.trainParam.epochs=delta_epochs(3);
net1=train(net1,x,t);
net2=train(net2,x,t);
a13=sim(net1,x); a23=sim(net2,x);

%plots
figure
subplot(3,3,1);
plot(x,t,'bx',x,a11,'r',x,a21,'g');
% plot the sine function and the output of the networks
title([num2str(epochs(1)),' epoch']);
legend('target',alg1,alg2,'Location','north');
subplot(3,3,2);
postregm(a11,y); % perform a linear regression analysis and plot the result
subplot(3,3,3);
postregm(a21,y);

subplot(3,3,4);
plot(x,t,'bx',x,a12,'r',x,a22,'g');
title([num2str(epochs(2)),' epochs']);
legend('target',alg1,alg2,'Location','north');
subplot(3,3,5);
postregm(a12,y);
subplot(3,3,6);
postregm(a22,y);

subplot(3,3,7);
plot(x,t,'bx',x,a13,'r',x,a23,'g');
title([num2str(epochs(3)),' epochs']);
legend('target',alg1,alg2,'Location','north');
subplot(3,3,8);
postregm(a13,y);
subplot(3,3,9);
postregm(a23,y);
