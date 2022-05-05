imagesize = [480 640 3];
the_output_of_uneLayers = unetLayers(imagesize,5,'EncoderDepth',3);
plot(the_output_of_uneLayers)


dataSetDir = fullfile(toolboxdir('vision'),'visiondata','triangleImages');
imageDir = fullfile(dataSetDir,'trainingImages');
labelDir = fullfile(dataSetDir,'trainingLabels');
classNames = ["triangle","background"];
labelIDs = [255 0];
imds = imageDatastore(imageDir);
pxds = pixelLabelDatastore(labelDir,classNames,labelIDs);