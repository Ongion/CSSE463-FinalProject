function [ single_square ] = getSquare( sudoku_board,row,column )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

[h,w,~] = size(sudoku_board);
square_width = w/9;
square_height = h/9;

sq_h = floor(square_height*(row-1)+1):ceil(square_height*row-1);
sq_w = floor(square_width*(column-1)+1):ceil(square_width*column-1);
single_square = sudoku_board(sq_h,sq_w,:);


end

