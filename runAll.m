testing = 'test3.jpg');
img = imread(testing);
imtool(img)
pause
testRun;
pause
getBoard;
soln = solveSudoku(board)
pause
writeToBoard = soln - board;
writeAnswers;
imtool(startOutput)