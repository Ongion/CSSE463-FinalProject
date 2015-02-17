function [ croppedSquare ] = cropSquare( square )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

hCropScale = 7;
wCropScale = 7;

[h,w,~] = size(square);
hScale = floor(h/hCropScale);
wScale = floor(w/wCropScale);

rect = [wScale, hScale, w - 2*wScale, h - 2*hScale];
croppedSquare = imcrop(square, rect); 

end

