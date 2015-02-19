function [outputImage] = solveImage(image)
%SOLVEIMAGE Summary of this function goes here
%   Detailed explanation goes here
    tic
    [binaryBoard, startOutput, corners, tform] = transformBoard(image);
    imtool(binaryBoard)
    inputBoardArray = getBoard(binaryBoard)
    soln = solveSudoku(inputBoardArray)
    writeToBoard = soln - inputBoardArray;
    writeAnswers;
    outputImage = writeBack(image,startOutput,corners,tform);
    toc
end

