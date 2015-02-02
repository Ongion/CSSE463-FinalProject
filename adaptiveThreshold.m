function [ output_img ] = adaptiveThreshold( input_img, thresh, fs)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

grayImg = double(rgb2gray(input_img));
theFilter = fspecial('average',fs);
averagedImg = double(filter2(theFilter, grayImg));
output_img = grayImg < averagedImg*thresh;

end

