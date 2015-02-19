function [ top, bottom, left, right ] = findBorder( x, y, range,maxY )
%FINDBORDER Summary of this function goes here
%   Detailed explanation goes here

    % Since there's a discontinuity at -90 degrees and 90 degrees, we have
    % to check both. Unfortunately, if we want the MAX at -90 degrees, we
    % want the MIN at 90 degrees.
    
    topFind = max([y(x < (-90 + range)),maxY-y(x > (90 - range))]);
    top = find(y == topFind);
    if numel(top) == 0
        top = find(y == maxY - topFind);
    end
    bottomFind = min([y(x < (-90 + range)),maxY-y(x > (90 - range))]);
    bottom = find(y == bottomFind);
    if numel(bottom) == 0
        bottom = find(y == maxY - bottomFind);
    end
    right = find(y==(max(y(abs(x) < range))));
    left = find(y==(min(y(abs(x) < range))));


end

