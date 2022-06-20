P = [2 1 -2 1; 2 -2 2 1];
T = [0 1 0 1];
TF = 'hardlim'; % transfer function
LF = 'learnp' % perceptron learning rule

net = newp(P, T, TF, LF);

net.IW{1, 1};
net.b{1, 1};
net.IW{1, 1} = rand(1, 2);
net.b{1, 1} = rand(1, 1);

net.trainParam.epochs = 20;
sim(net, [1; -0.3]) % evaluate network for a given input vector

a=sim(net,P);
[m,b,r]=postreg(a,T); % display results
