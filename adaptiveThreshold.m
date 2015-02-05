function [ output_img ] = adaptiveThreshold( input_img, thresh, filterSize)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[~,d] = size(size(input_img));
if d == 3
    grayImg = double(rgb2gray(input_img));
else
    grayImg = input_img;
end    
theFilter = fspecial('average',filterSize);
averagedImg = double(filter2(theFilter, grayImg));
output_img = grayImg < averagedImg*thresh;

end

