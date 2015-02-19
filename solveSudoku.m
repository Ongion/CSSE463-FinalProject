function [solution] = solveSudoku(board)
%SOLVESUDOKU Summary of this function goes here
%   Detailed explanation goes here
    javaSudoku = MatlabSudoku;
    javaMethod('assignBoard',javaSudoku,board);
    javaMethod('doubleToInteger',javaSudoku);
    javaMethod('boardToString',javaSudoku);
    solution = javaMethod('solve',javaSudoku);
    solution = double(solution);
end

