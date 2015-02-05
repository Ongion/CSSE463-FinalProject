clear all;
load('features.mat');

SVMStruct = svmtrain(features, classes);
%SVMModel = fitcecoc(features,classes);

fileString = '../digitData/data0.txt'; 
fid = fopen(fileString, 'r');
[gray, N] = fread(fid, [28 28], 'uchar');
fclose(fid);


img = double(transpose(gray));
testImgFeatures = extractFeatures(img);

Group = svmclassify(SVMStruct,testImgFeatures)
%label = predict(SVMModel,testImgFeatures)