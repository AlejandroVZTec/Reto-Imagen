%% Segmentación U-NET
%%18 de abril
%% Entrenando el modelo
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

%% Evaluar qué tan bien entrenado está el modelo

% Train the network
net = trainNetwork(ds,y,options);

% Specify test images and labels
testImagesDir = fullfile(dataSetDir,'testImages');
testimds = imageDatastore(testImagesDir);
testLabelsDir = fullfile(dataSetDir,'testLabels');

pxdsTruth = pixelLabelDatastore(testLabelsDir,classNames,labelIDs);
pxdsResults = semanticseg(testimds,net,"WriteLocation",tempdir); %preguntar
metrics = evaluateSemanticSegmentation(your predictions,ground truth); %preguntar

%  Inspect class metrcis
metrics.ClassMetrics

% Display confusion matrix
metrics.ConfusionMatrix

% Visualize the normalized confusion matrix as a confusion chart in a figure window.
figure
cm = confusionchart(metrics.ConfusionMatrix.Variables, classNames, Normalization='row-normalized');
cm.Title = 'Normalized Confusion Matrix (%)';

imageIoU = metrics.ImageMetrics.MeanIoU;
figure (3)
histogram(imageIoU)
title('Image Mean IoU');

%% 
% Find the test image with the lowest IoU.
[minIoU, worstImageIndex] = min(imageIoU);
minIoU = minIoU(1);
worstImageIndex = worstImageIndex(1);

% Read the test image with the worst IoU, its ground truth labels, and its predicted labels for comparison.
worstTestImage = readimage(imds,worstImageIndex);
worstTrueLabels = readimage(pxdsTruth,worstImageIndex);
worstPredictedLabels = readimage(pxdsResults,worstImageIndex);

% Convert the label images to images that can be displayed in a figure window.
worstTrueLabelImage = im2uint8(worstTrueLabels == classNames(1));
worstPredictedLabelImage = im2uint8(worstPredictedLabels == classNames(1));

% Display the worst test image, the ground truth, and the prediction.
worstMontage = cat(4,worstTestImage,worstTrueLabelImage,worstPredictedLabelImage);
WorstMontage = imresize(worstMontage,4,"nearest");

figure (4)
montage(worstMontage,'Size',[1 3])
title(['Test Image vs. Truth vs. Prediction. IoU = ' num2str(minIoU)])





