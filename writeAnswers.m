for r = 1:9
    for c = 1:9
        if writeToBoard(r,c) ~= 0
            position = [57*(c-1)+16 57*(r-1)+1];
            startOutput = insertText(startOutput,position,num2str(writeToBoard(r,c)),'FontSize',50,'TextColor','red','BoxOpacity',0);
        end
    end
end