
NUM_OF_EACH = 1000;
NUM_FEATURES_PER_CELL = 2;

features = ones(NUM_OF_EACH*10,49*NUM_FEATURES_PER_CELL);
classes = zeros(10, NUM_OF_EACH*10);
for i = 1:10
    
    fileString = ['../digitData/data' int2str(i-1) '.txt']; 
    
    fid = fopen(fileString, 'r');
   
    digitClass = ones(1,NUM_OF_EACH);
    first = (i-1)*NUM_OF_EACH +1;
    second = i*NUM_OF_EACH;
    classes(i,first:second) = digitClass;
    
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
