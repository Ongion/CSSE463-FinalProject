load('nn.mat');

testX = features(:,tr.testInd);
testT = classes(:,tr.testInd);
testY = net(testX);

realIndices = vec2ind(testT);
testIndices = vec2ind(testY);

numCorrect =sum(realIndices==testIndices);
accuracy = numCorrect/numel(realIndices);

[c, cm] = confusion(testT,testY);
fprintf('Percentage Correct Classification   : %f%%\n', 100*(1-c));
fprintf('Percentage Incorrect Classification : %f%%\n', 100*c);
plotroc(testT,testY);