function [ top, bottom, left, right ] = findBorder( x, y, range )
%FINDBORDER Summary of this function goes here
%   Detailed explanation goes here

    top = find(y==(max(y(x < (-90 + range) | x > (90 - range)))));
    bottom = find(y==(min(y(x < (-90 + range) | x > (90 - range)))));
    left = find(y==(max(y(abs(x) < range))));
    right = find(y==(min(y(abs(x) < range))));


end

