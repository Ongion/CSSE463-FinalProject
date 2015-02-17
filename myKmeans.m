function [img] = myKmeans(img)
%KMEANS Summary of this function goes here
%   Detailed explanation goes here
    k = 2;
    seed = 0;
    rand('state', seed);
    means = floor(rand(k,3)*255);
    
    height = size(img,1);
    width = size(img,2);
    
    clusters = zeros([height,width]);
    
    for iter = 1:2
        fprintf('Iteration %i',iter)
        for r = 1:height
            for c = 1:width
                pixel = double(squeeze(img(r,c,:)))';
                clusters(r,c) = find_distance(pixel,means);
            end
        end
        means = evaluateMeans(clusters, img);
        fprintf(' done\n')
    end
    for r = 1:height
        for c = 1:width
            img(r,c,:) = means(clusters(r,c),:);
        end
    end
end

