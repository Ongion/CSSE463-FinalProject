function [ javaInput ] = toJavaClass( boardImg )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

addpath('svmStuff');

javaInput = zeros(9,9);
for i = 1:9
    for j = 1:9
        square = getSquare(boardImg, i,j);
        square = cropSquare(square);
        javaInput(i,j) = ClassifyImg(double(square));
    end
end

end

