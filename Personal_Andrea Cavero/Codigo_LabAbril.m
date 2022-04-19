%%18 de abril

%Primera parte
imageSize=[480 640 3];
numClasses=5;
Name='EncoderDepth';
Value=3;
x=unetLayers(imageSize,numClasses,Name,Value);
plot(x);

%Segunda parte
dataSetDir=fullfile(toolboxdir('vision'),'visiondata','triangleImages');
imageDir=fullfile(dataSetDir,'trainingImages');
labelDir=fullfile(dataSetDir,'trainingLabels');

classNames=["triangle" "background"];
labelIDs=[250 0];

imds=imageDatastore(imageDir);
pxds=pixelLabelDatastore(labelDir,classNames,labelIDs);

%Parte 3
y=unetLayers(imageSize, numClasses);
ds = combine(imds,pxds);
options = trainingOptions('sgdm','InitialLearnRate', 1e-3,'MaxEpochs',20,'VerboseFrequency', 10);
net = trainNetwork(ds,y,options);



