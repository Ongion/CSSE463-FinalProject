NUM_OF_EACH=17;
NUM_FEATURES_PER_CELL = 2;

features = ones(NUM_OF_EACH*10,49*NUM_FEATURES_PER_CELL);
classes = zeros(10, NUM_OF_EACH*10);
imgs = zeros(32,32,NUM_OF_EACH*10);
labels = ones(NUM_OF_EACH*10,1);

for i = 1:10
    
    %fileString = ['../digitData/data' int2str(i-1) '.txt']; 
    dirName = ['../New_Fonts/' int2str(i-1)];
    %fid = fopen(fileString, 'r');
    fileList =dir(dirName);
    %dirName
    %size(fileList,1)
    digitClass = ones(1,NUM_OF_EACH);
    first = (i-1)*NUM_OF_EACH +1;
    second = i*NUM_OF_EACH;
    classes(i,first:second) = digitClass;
    
    for h = 1:NUM_OF_EACH
        %[gray, N] = fread(fid, [28 28], 'uchar');
        gray = imread([dirName '/' fileList(h+2).name]);
        img = double(gray);
        imgs(:,:,(i-1)*NUM_OF_EACH+h) = imresize(gray, [32, 32]);
        labels((i-1)*NUM_OF_EACH+h,1) = i-1;
        %imtool(img)
        
        imageindex = (i-1)*NUM_OF_EACH +h;
        
        features(imageindex,:) = extractFeatures(img);
    end
    %fclose(fid);
end




features = normalizeFeatures(features, NUM_FEATURES_PER_CELL);
clearvars -except features classes imgs labels
save('features.mat');
clear all
