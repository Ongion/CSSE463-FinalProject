% The trainingSet is an array of 10 imageSet objects: one for each digit.
% Loop over the trainingSet and extract HOG features from each image. A
% similar procedure will be used to extract features from the testSet.


trainingFeatures = [];
trainingLabels   = [];
classes = zeros(10, 170);

for digit = 1:10
    dirName = ['../New_Fonts/' int2str(digit-1)];
    fileList =dir(dirName);
    
    numImages = size(fileList,1)-2;
    features  = zeros(numImages, 8100, 'single');
    
    digitClass = ones(1,17);
    first = (digit-1)*17 +1;
    second = digit*17;
    classes(digit,first:second) = digitClass;

    for i = 1:numImages

        img = imread([dirName '/' fileList(i+2).name]);
        img = imresize(img, [32, 32]);
        % Apply pre-processing steps
        %lvl = graythresh(255*img);
        %img = im2bw(img, lvl);
        %imtool(img);
        out = extractHOGFeatures(img, 'CellSize', [2 2]);
        features(i, :) = out;
    end

    % Use the imageSet Description as the training labels. The labels are
    % the digits themselves, e.g. '0', '1', '2', etc.
    labels = repmat(digit-1, numImages, 1);

    trainingFeatures = [trainingFeatures; features];   %#ok<AGROW>
    trainingLabels   = [trainingLabels;   labels  ];   %#ok<AGROW>

end

features=trainingFeatures;
clearvars -except features classes
save('features.mat');

