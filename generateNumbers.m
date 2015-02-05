for d = 0:9
    digit = int2str(d);
    dir = strcat('Fonts\data',digit);
    fid = fopen(dir,'r');
    for i = 1:1000
        [temp,~] = fread(fid,[28 28],'uchar');
        filename = strcat('Fonts\',digit,'\',int2str(i),'.png');
        imwrite(fliplr(rot90(temp,3)),filename);
    end
end