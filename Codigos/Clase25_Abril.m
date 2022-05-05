%25 de abril

%% Primer ejercicio

% Create Gray-Level Co-occurrence Matrix for Grayscale Image
I = imread('cell.tif');
imshow(I)
glcm = graycomatrix(I,'Offset',[2 0])

%Create Gray-Level Co-occurrence Matrix Returning Scaled Image
I = [ 1 1 5 6 8 8; 2 3 5 7 0 2; 0 2 3 5 6 7]
[glcm,SI] = graycomatrix(I,'NumLevels',9,'GrayLimits',[])

%Calculate GLCMs using Four Different Offsets
I = imread('cell.tif');
imshow(I)
offsets = [0 1; -1 1;-1 0;-1 -1];
[glcms,SI] = graycomatrix(I,'Offset',offsets);
imshow(rescale(SI))
whos

%Calculate Symmetric GLCM for Grayscale Image
I = imread('cell.tif');
[glcm,SI] = graycomatrix(I,'Offset',[2 0],'Symmetric',true);
glcm
imshow(rescale(SI))

%% Segundo ejercicio
%Using LBP Features to Differentiate Images by texture
Fur_ = imread('fur.jpg');
fur=rgb2gray(Fur_);

rotatedBrickWall_ = imread('bricksRotated.jpg');
rotatedBrickWall=rgb2gray(rotatedBrickWall_);

carpet_ = imread('carpet.jpg');
carpet=rgb2gray(carpet_);

figure; imshow(fur); title('Fur')
figure; imshow(rotatedBrickWall); title('Rotated Bricks')
figure; imshow(carpet); title('Carpet')


lbpFur = extractLBPFeatures(fur,'Upright',false);
lbpBricks2 = extractLBPFeatures(rotatedBrickWall,'Upright',false);
lbpCarpet = extractLBPFeatures(carpet,'Upright',false);

furVsBrick = (lbpFur - lbpBricks2).^2;
furVsCarpet = (lbpFur - lbpCarpet).^2;

figure
bar([furVsBrick; furVsCarpet]','grouped')
title('Squared Error of LBP Histograms')
xlabel('LBP Histogram Bins')
legend('Fur vs Rotated Bricks','Fur vs Carpet')

%Apply L1 Normalization to LBP Features
I = imread('building.jpg');
I = rgb2gray(I);
lbpFeatures = extractLBPFeatures(I,'CellSize',[32 32],'Normalization','None');
numNeighbors = 8;
numBins = numNeighbors*(numNeighbors-1)+3;
lbpCellHists = reshape(lbpFeatures,numBins,[]);
lbpCellHists = bsxfun(@rdivide,lbpCellHists,sum(lbpCellHists));
lbpFeatures = reshape(lbpCellHists,1,[]);% Utilizar reshape









