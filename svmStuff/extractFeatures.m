function features = extractFeatures(img)
    
    features = ones(1,98);
    
    dimensions = size(img);
    nRows = dimensions(1);
    nCols = dimensions(2);
    
    rowsPerBlock = floor(nRows / 7);
    colsPerBlock = floor(nCols / 7);
    
    for j=1:7
        for k=1:7
        firstRow = (j-1) * rowsPerBlock + 1;
        lastRow = j * rowsPerBlock;
        firstCol = (k-1) * colsPerBlock + 1;
        lastCol = k * colsPerBlock;
               
        cell = img(firstRow:lastRow, firstCol:lastCol);
                
        cellMean = mean(mean(cell));
        cellStd = std(cell(:));
               
                
        blockIndex = (7 * (j-1)) + (k-1);
        firstFeatureIndex = 2 * (blockIndex) + 1;
                
        features(1, firstFeatureIndex) = cellMean;
        features(1, firstFeatureIndex + 1) = cellStd;
        
        end
    end
        
end