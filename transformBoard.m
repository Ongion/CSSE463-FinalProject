function [output, startOutput, corners, tform] = transformBoard(image)
%TRANSFORMBOARD Summary of this function goes here
%   Detailed explanation goes here

threshed = adaptiveThreshold(image,0.90, 50);

labeledImg = bwlabel(threshed);

blobInfo = regionprops(threshed,'area');

allAreas = [blobInfo.Area];
[~, sortIndexes] = sort(allAreas,'descend');
hopefullyBoard = labeledImg == sortIndexes(1);

[H, theta, rho] = hough(hopefullyBoard);
maxY = max(rho(:));

 figure, imshow(imadjust(mat2gray(H)),[],'XData',theta,'YData',rho,...
         'InitialMagnification','fit');
 xlabel('\theta (degrees)'), ylabel('\rho');
 axis on, axis normal, hold on;
 colormap(hot)

%There shouldn't be more than 20 lines in a sudoku board
peaks = houghpeaks(H,20);


x = theta(peaks(:,2));
y = rho(peaks(:,1));

[top,bottom,left,right] = findBorder(x,y,30,maxY);


x = x([top,bottom,left,right]);
y = y([top,bottom,left,right]);

% peaks = makeNewPeaks(x, y, theta, rho, peaks);
% 
 plot(x,y,'s','color','black');
 hold off
% 
% lines = houghlines(hopefullyBoard,theta,rho,peaks)

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
[warpedImage, Rout] = imwarp(image,tform);
nY = floor(abs(Rout.XWorldLimits(1)))+3;
nX = floor(abs(Rout.YWorldLimits(1)))+3;
nX = nX:nX+511;
nY = nY:nY+511;
startOutput = warpedImage(nX,nY,:);
threshedOut = adaptiveThreshold(startOutput,0.87, 25);
smallRemoved = bwareaopen(threshedOut,100);
bigOnly = bwareaopen(threshedOut,600);
output = xor(smallRemoved,bigOnly);

% % Use the 'CharacterSet' parameter to constrain OCR
% results = ocr(output, 'CharacterSet', '123456789', 'TextLayout','Block');
% 
% % Sort the character confidences
% [sortedConf, sortedIndex] = sort(results.CharacterConfidences, 'descend');
% 
% % Keep indices associated with non-NaN confidences values
% indexesNaNsRemoved = sortedIndex( ~isnan(sortedConf) & 0.5 <= sortedConf);
% 
% % Get the top ten indexes
% %topTenIndexes = indexesNaNsRemoved(1:10);
% 
% % Select the top ten results
% digits = num2cell(results.Text(indexesNaNsRemoved));
% bboxes = results.CharacterBoundingBoxes(indexesNaNsRemoved, :);
% 
% Idigits = insertObjectAnnotation(startOutput, 'rectangle', bboxes, digits);
% 
% figure;
% imshow(Idigits);


end

