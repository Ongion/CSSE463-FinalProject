function features = normalizeFeatures(features,featPerCell)


nFeatures = size(features, 2); % 294

% Loop over Lmean, Lstd, Smean, Sstd, Tmean, Tstd
for selectedType = 1:featPerCell
    % extract all values of the given feature from all 49 blocks from all images
    selectedFeature = features(:,selectedType:featPerCell:nFeatures);
    % Find the min and shift the data so that the min is now 0
    minValue = min(min(selectedFeature));
    selectedFeature = selectedFeature-minValue;
 
    % Find the max and divide by it to make the max 1
    maxValue = max(max(selectedFeature));
    selectedFeature = selectedFeature / maxValue;
 
    % We could have combined: f = (f-min)/(max-min)
    
    % Re-insert into the feature matrix
    features(:,selectedType:featPerCell:nFeatures) = selectedFeature;
end
 
features = double(features);