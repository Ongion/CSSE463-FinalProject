clear all;
input = imread('testSudoku.jpg');
resizedInput = imresize(input, 1/3);
threshed = adaptiveThreshold(resizedInput,0.9, 10);

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

peaks = houghpeaks(H,27);


x = theta(peaks(:,2));
y = rho(peaks(:,1));

[top,bottom,left,right] = findBorder(x,y,10);


x = x([top,bottom,left,right]);
y = y([top,bottom,left,right]);

peaks = makeNewPeaks(x, y, theta, rho, peaks);

plot(x,y,'s','color','black');

lines = houghlines(hopefullyBoard,theta,rho,peaks);

figure, imshow(resizedInput), hold on
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end


