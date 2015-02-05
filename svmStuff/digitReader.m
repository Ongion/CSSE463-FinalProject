
NUM_OF_EACH = 5;
NUM_FEATURES_PER_CELL = 2;

features = ones(NUM_OF_EACH*10,49*NUM_FEATURES_PER_CELL);
classes = ones(NUM_OF_EACH*10, 1);
for i = 1:10
    
    fileString = ['../digitData/data' int2str(i-1) '.txt']; 
    
    fid = fopen(fileString, 'r');
   
    digitClass = ones(NUM_OF_EACH,1) * (i-1);
    first = (i-1)*NUM_OF_EACH +1;
    second = i*NUM_OF_EACH;
    classes(first:second,:) = digitClass;
    
    for h = 1:NUM_OF_EACH
        [gray, N] = fread(fid, [28 28], 'uchar');
        img = double(transpose(gray));
        %imtool(img)
        
        imageindex = (i-1)*NUM_OF_EACH +h;
        
        features(imageindex,:) = extractFeatures(img);
    end
    fclose(fid);
end




features = normalizeFeatures(features, NUM_FEATURES_PER_CELL);
clearvars -except features classes
save('features.mat');
clear all
