load('nn.mat');

testX = features(:,tr.testInd);
testT = classes(:,tr.testInd);
testY = net(testX);

realIndices = vec2ind(testT);
testIndices = vec2ind(testY);

numCorrect =sum(realIndices==testIndices);
accuracy = numCorrect/numel(realIndices)