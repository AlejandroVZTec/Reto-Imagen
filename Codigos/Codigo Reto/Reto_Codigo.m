%% RETO - Segmentación
%% Cargando archivos
% FREE SURFER
%Subject 101
SegGrayFree101 = niftiread("grey-101-FSurfer.nii"); % Gray Matter Segmentation
SegWhiteFree101 = niftiread("white-101-FSurfer.nii");% White Matter Segmentation

%Subject 108
SegGrayFree108 = niftiread("grey-108-FSurfer.nii"); % Gray Matter Segmentation
SegWhiteFree108 = niftiread("white-108-FSurfer.nii");% White Matter Segmentation

%Subject 109
SegGrayFree109 = niftiread("grey-109-FSurfer.nii"); % Gray Matter Segmentation
SegWhiteFree109 = niftiread("white-109-FSurfer.nii");% White Matter Segmentation

%FSL
%Subject 101
SegGrayFSL101 = niftiread("sub-101_brain_pve_1.nii"); % Gray Matter Segmentation
SegWhiteFSL101 = niftiread("sub-101_brain_pve_2.nii");% White Matter Segmentation

%Subject 102
SegGrayFSL108 = niftiread("sub-108_brain_pve_1.nii"); % Gray Matter Segmentation
SegWhiteFSL108 = niftiread("sub-108_brain_pve_2.nii");% White Matter Segmentation

%Subject 103
SegGrayFSL109 = niftiread("sub-109_brain_pve_1.nii"); % Gray Matter Segmentation
SegWhiteFSL109 = niftiread("sub-109_brain_pve_2.nii");% White Matter Segmentation

%% Selección de labels
%Labels Free Surfer
    %Sujeto 101
cwfree101 = SegWhiteFSL101 == 1; 
cgfree101 = SegGrayFSL101 == 1;
    %Sujeto 108
cwfree108 = SegWhiteFSL108 == 1;
cgfree108 = SegGrayFSL108 == 1;
    %Sujeto 109
cwfree109 = SegWhiteFSL109 == 1;
cgfree109 = SegGrayFSL109 == 1;

%Labels FSL
    %Sujeto 101
cwfsl101 = SegWhiteFSL101 == 1; 
cgfsl101 = SegGrayFSL101 == 1;
    %Sujeto 108
cwfsl108 = SegWhiteFSL108 == 1;
cgfsl108 = SegGrayFSL108 == 1;
    %Sujeto 109
cwfsl109 = SegWhiteFSL109 == 1;
cgfsl109 = SegGrayFSL109 == 1;

%% Evaluacion DICE
%Sujeto 101
diceResultWhite101 = dice(flip(imrotate(cwfree101,-90),2),imrotate(cwfsl101,90));
diceResultGray101 = dice(flip(imrotate(cgfree101,-90),2),imrotate(cgfsl101,90));

%Sujeto 108
diceResultWhite108 = dice(flip(imrotate(cwfree108,-90),2),imrotate(cwfsl108,90));
diceResultGray108 = dice(flip(imrotate(cgfree108,-90),2),imrotate(cgfsl108,90));

%Sujeto 109
diceResultWhite109 = dice(flip(imrotate(cwfree109,-90),2),imrotate(cwfsl109,90));
diceResultGray109 = dice(flip(imrotate(cgfree109,-90),2),imrotate(cgfsl109,90));

%% Graficar segmentaciones
%--Materia Gris
%Sujeto 101
figure(1); imshow(flip(imrotate(cgfree101(:,:,138),-90),2)); title('Free-Sujeto 101');
figure(2); imshow(imrotate(cgfsl101(:,:,138),-90)); title('Fsl-Sujeto 101');

%Sujeto 108
figure(3); 
imshow(flip(imrotate(cgfree108(:,:,138),-90),2)); title('Free-Sujeto 108');
figure(4); 
imshow(imrotate(cgfsl108(:,:,138),90)); title('Fsl-Sujeto 108');

%Sujeto 109
figure(5); 
imshow(flip(imrotate(cgfree109(:,:,138),-90),2)); title('Free-Sujeto 109');
figure(6); 
imshow(imrotate(cgfsl109(:,:,138),-90)); title('Fsl-Sujeto 109');

%--Materia Blanca
%Sujeto 101
figure(7); 
imshow(flip(imrotate(cgfree101(:,:,138),-90),2)); title('Free-Sujeto 101');
figure(8); 
imshow(imrotate(cwfsl101(:,:,138),-90)); title('Fsl-Sujeto 101');

%Sujeto 108
figure(9); 
imshow(flip(imrotate(cgfree108(:,:,138),-90),2)); title('Free-Sujeto 108');
figure(10); 
imshow(imrotate(cgfsl108(:,:,138),-90)); title('Fsl-Sujeto 108');

%Sujeto 109
figure(11); 
imshow(flip(imrotate(cgfree109(:,:,138),-90),2)); title('Free-Sujeto 109');
figure(12); 
imshow(imrotate(cgfsl109(:,:,138),-90)); title('Fsl-Sujeto 109');

