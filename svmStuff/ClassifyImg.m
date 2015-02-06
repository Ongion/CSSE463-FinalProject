function [ class ] = ClassifyImg( gray )

    load('nn.mat');
    feats = extractFeatures(gray);
    
    class=vec2ind(net(transpose(feats)));

end

