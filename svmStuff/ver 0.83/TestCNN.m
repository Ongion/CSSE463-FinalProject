
%Must run ../ FontReader first 
load('../features.mat');
load('cnet.mat');

nImgs = size(imgs,3);

out = zeros(nImgs,1);
for i=1:nImgs
    %imtool(255*(imgs(:,:,i)));
    
    temp = sim(sinet,255*imgs(:,:,i));
    
    out(i,1) = find(temp ==max(temp));
end
