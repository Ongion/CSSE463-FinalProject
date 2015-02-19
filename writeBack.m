function [ outputImage ] = writeBack(image, solvedBoard, corners, tform )
%WRITEBACK Summary of this function goes here
%   Detailed explanation goes here
    
    invtform = invert(tform);
    warpedBack = imwarp(solvedBoard,invtform);
    corners = floor(corners);
    top = min(corners(:,2));
    left = min(corners(:,1));
    [topOffset, leftOffset, ~] = size(warpedBack);
    outputImage = image;
    writeBackMask = repmat(sum(double(warpedBack),3) ~= 0,[1,1,3]);
    writeBackSpot = outputImage(top:top+topOffset-1,left:left+leftOffset-1,:);
    size(writeBackSpot)
    size(warpedBack)
    writeBackSpot(writeBackMask) = warpedBack(writeBackMask);
    outputImage(top:top+topOffset-1,left:left+leftOffset-1,:) = writeBackSpot;
    
end

