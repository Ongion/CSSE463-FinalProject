clear all;
input = imread('testSudoku.jpg');
resizedInput = imresize(input, 1);
threshed = adaptiveThreshold(resizedInput,0.90, 50);

labeledImg = bwlabel(threshed);

blobInfo = regionprops(threshed,'area');

allAreas = [blobInfo.Area];
[sortedAreas, sortIndexes] = sort(allAreas,'descend');
%imshow(threshed);
hopefullyBoard = labeledImg == sortIndexes(1);

[H, theta, rho] = hough(hopefullyBoard);

figure, imshow(imadjust(mat2gray(H)),[],'XData',theta,'YData',rho,...
        'InitialMagnification','fit');
xlabel('\theta (degrees)'), ylabel('\rho');
axis on, axis normal, hold on;
colormap(hot)

%There shouldn't be more than 20 lines in a sudoku board
peaks = houghpeaks(H,20); 


x = theta(peaks(:,2));
y = rho(peaks(:,1));

[top,bottom,left,right] = findBorder(x,y,10);


x = x([top,bottom,left,right]);
y = y([top,bottom,left,right]);

peaks = makeNewPeaks(x, y, theta, rho, peaks);

plot(x,y,'s','color','black');

lines = houghlines(hopefullyBoard,theta,rho,peaks);

slopes = -cos(x*pi/180)./sin(x*pi/180);
intercepts = y./sin(x*pi/180);

% Corners listed as (x,y), in order TopLeft, BottomLeft, BottomRight, TopRight
corners = zeros(4,2);
corners(1,1) = (intercepts(3)-intercepts(1))/(slopes(1)-slopes(3));
corners(1,2) = slopes(1)*corners(1,1)+intercepts(1);
corners(2,1) = (intercepts(3)-intercepts(2))/(slopes(2)-slopes(3));
corners(2,2) = slopes(2)*corners(2,1)+intercepts(2);
corners(3,1) = (intercepts(4)-intercepts(2))/(slopes(2)-slopes(4));
corners(3,2) = slopes(2)*corners(3,1)+intercepts(2);
corners(4,1) = (intercepts(4)-intercepts(1))/(slopes(1)-slopes(4));
corners(4,2) = slopes(1)*corners(4,1)+intercepts(1);


%tform = projective2d([corners(1,1),corners(1,2),corners(2,1);
%                                   corners(2,2),corners(3,1),corners(3,2);
%                                   corners(4,1),corners(4,2),1]);


Xp = [1;1;512;512];
Yp = [1;512;512;1];

tform = fitgeotrans(corners,[Xp,Yp],'projective');
[warpedImage, Rout] = imwarp(resizedInput,tform);
nY = floor(abs(Rout.XWorldLimits(1)))+3;
nX = floor(abs(Rout.YWorldLimits(1)))+3;
nX = nX:nX+511;
nY = nY:nY+511;
output = warpedImage(nX,nY,:);
imtool(output);