% my student number: r0874279
d1=7;
d2=4;
d3=2;
d4=7;
d5=9;

% part 1
load("Data_Problem1_regression.mat");
TNew = (d1*T1 + d2*T3 + d3*T3 + d4*T4 + d5*T5)/(d1+d2+d3+d4+d5);
% training set
temp = datasample([X1 X2 TNew],1000,1);
trainingX = temp(:,1:2).';
trainingY = temp(:,3).';
trainingP = con2seq(trainingX);
trainingT = con2seq(trainingY);
% validation set
temp = datasample([X1 X2 TNew],1000,1);
validationX = temp(:,1:2).';
validationY = temp(:,3).';
validationP = con2seq(validationX);
validationT = con2seq(validationY);
% test set
temp = datasample([X1 X2 TNew],1000,1);
testX = temp(:,1:2).';
testY = temp(:,3).';
testP = con2seq(testX);
testT = con2seq(testY);

% create network
net = feedforwardnet(7,'trainlm');
net.trainParam.epochs=1000;
[net,tr]=train(net,trainingP,trainingT);
postregm(cell2mat(sim(net,trainingP)),trainingY);
postregm(cell2mat(sim(net,validationP)),validationY);

% train the best NN multiple times
i=32;
net = feedforwardnet(i,'trainlm');
net.trainParam.epochs=1000;
[net,tr] = train(net,trainingP,trainingT);
simulationTraining = sim(net,trainingP);
mseTraining = mean((trainingY-cell2mat(simulationTraining)).^2);
simulationValidation = sim(net,validationP);
mseValidation = mean((validationY-cell2mat(simulationValidation)).^2);
for j = 1:10
    tempnets = feedforwardnet(i,'trainlm');
    tempnets.trainParam.epochs=1000;
    [tempnets,temptr] = train(tempnets,trainingP,trainingT);
    tempsimulationTraining = sim(tempnets,trainingP);
    tempmseTraining = mean((trainingY- ...
        cell2mat(tempsimulationTraining)).^2);
    tempsimulationValidation=sim(tempnets,validationP);
    tempmseValidation = mean((validationY- ...
        cell2mat(tempsimulationValidation)).^2);
    if tempmseValidation<mseValidation
        nets = tempnets;
        tr = temptr;
        simulationTraining=tempsimulationTraining;
        mseTraining = tempmseTraining;
        simulationValidation=tempsimulationValidation;
        mseValidation = tempmseValidation;
    end
end
mseValidation;

% test set error
mseTest = mean((testY-cell2mat(sim(net,testP))).^2);

% plot test set surface
x = testX(1,:).';
y = testX(2,:).';
xlin = linspace(min(x),max(x),33);
ylin = linspace(min(y),max(y),33);
[X,Y] = meshgrid(xlin,ylin);
f = scatteredInterpolant(x,y,testY.');
Z = f(X,Y);
figure
mesh(X,Y,Z) % interpolated
axis tight; hold on
title('Test Set Surface')

% plot NN surface
x=testX(1,:).';
y=testX(2,:).';
xlin = linspace(min(x),max(x),33);
ylin = linspace(min(y),max(y),33);
[X,Y] = meshgrid(xlin,ylin);
outRows = size(X, 1);
outCols = size(Y, 2);
Z = zeros(outRows, outCols);
for row = 1:outRows
    for col = 1:outCols
        input = [X(row, col); Y(row, col)];
        simulated = sim(net,input);
        Z(row, col) = simulated;
    end
end
figure
mesh(X,Y,Z,'FaceAlpha',0.7);
axis tight; hold on
title('Neural Network Surface')

% plot MSE on the test set
disp(mseValidation)
disp(mseTest)
