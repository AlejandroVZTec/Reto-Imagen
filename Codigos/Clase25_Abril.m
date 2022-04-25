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
[glcm,SI] = graycomatrix(I,'Offset',[2 0],'Symmetric',true);
glcm
imshow(rescale(SI))

%% Segundo ejercicio
%Using LBP Features to Differentiate Images by Texture
brickWall = imread('bricks.jpg');
rotatedBrickWall = imread('bricksRotated.jpg');
carpet = imread('carpet.jpg');
figure
imshow(brickWall)
title('Bricks')

figure
imshow(rotatedBrickWall)
title('Rotated Bricks')

figure
imshow(carpet)
title('Carpet')

lbpBricks1 = extractLBPFeatures(brickWall,'Upright',false);
lbpBricks2 = extractLBPFeatures(rotatedBrickWall,'Upright',false);
lbpCarpet = extractLBPFeatures(carpet,'Upright',false);

brickVsBrick = (lbpBricks1 - lbpBricks2).^2;
brickVsCarpet = (lbpBricks1 - lbpCarpet).^2;

figure
bar([brickVsBrick; brickVsCarpet]','grouped')
title('Squared Error of LBP Histograms')
xlabel('LBP Histogram Bins')
legend('Bricks vs Rotated Bricks','Bricks vs Carpet')

%Apply L1 Normalization to LBP Features

I = imread('gantrycrane.png');
I = im2gray(I);
lbpFeatures = extractLBPFeatures(I,'CellSize',[32 32],'Normalization','None');
numNeighbors = 8;
numBins = numNeighbors*(numNeighbors-1)+3;
lbpCellHists = reshape(lbpFeatures,numBins,[]);
lbpCellHists = bsxfun(@rdivide,lbpCellHists,sum(lbpCellHists));
lbpFeatures = reshape(lbpCellHists,1,[]);









