function [outputImage] = solveImage(image)
%SOLVEIMAGE Summary of this function goes here
%   Detailed explanation goes here
    tic
    [binaryBoard, warpedBoard, corners, tform] = transformBoard(image);
    inputBoardArray = getBoard(binaryBoard);
    soln = solveSudoku(inputBoardArray);
    writeToBoard = soln - inputBoardArray;
    writtenBoard = writeAnswers(warpedBoard, writeToBoard);
    imtool(writtenBoard);
    outputImage = writeBack(image,writtenBoard,corners,tform);
    toc
end

