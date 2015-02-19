function [board] = getBoard(image)
%GETBOARD Summary of this function goes here
%   Detailed explanation goes here
board = zeros(9,9);

for r = 1:9
    for c = 1:9
        result = ocr(cropSquare(getSquare(image, r, c)),'CharacterSet', '123456789', 'TextLayout','Block');
        if numel(result.WordConfidences) > 0 % If we've detected at least one word...
            maxIndex = find(result.WordConfidences == max(result.WordConfidences),1);
            board(r,c) = result.Words{maxIndex} - 48; % result is a character, subtract 48 to get numeric value
        end
    end
end
            


end

