function [ output ] = writeAnswers( image, writeToBoard )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    output = image;
    for r = 1:9
        for c = 1:9
            if writeToBoard(r,c) ~= 0
                position = [57*(c-1)+16 57*(r-1)+1];
                output = insertText(output,position,num2str(writeToBoard(r,c)),'FontSize',40,'TextColor','red','BoxOpacity',0);
            end
        end
    end
end

