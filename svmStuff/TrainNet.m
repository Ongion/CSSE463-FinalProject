clear all;
load('features.mat');

features=transpose(features);

net = patternnet(100);
view(net)

[net, tr] = train(net,features,classes);
nntraintool
plotperform(tr)


save ('nn.mat');
