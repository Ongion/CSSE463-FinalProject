function [ newPeaks ] = makeNewPeaks( x, y, theta, rho, peaks )
%MAKENEWPEAKS Summary of this function goes here
%   Detailed explanation goes here

%TODO: MAKE THIS LESS STUPID MAYBE?
% UNTIL THEN: FOR LOOP GOOOOOOOOOOOO
newPeaks = zeros([4,2]);
for i = 1:4
    index = find(theta(peaks(:,2)) == x(i) & rho(peaks(:,1)) == y(i));
    newPeaks(i,:) = peaks(index,:);
end

end

