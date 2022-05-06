
%% RETO - Segmentaci�n

%% FREE SURFER
% Volumes of brain
Sub101 = niftiread("brain101.nii"); %Subject 1
Sub112 = niftiread("brain112.nii"); %Subject 2
Sub121 = niftiread("brain121.nii"); %Subject 3

%Segmentation Files
Seg101 = niftiread("aseg101.nii"); %Subject 1
Seg112 = niftiread("aseg112.nii"); %Subject 2
Seg121 = niftiread("aseg121.nii"); %Subject 3

%% FSL

%Subject 1
SegGrayFSL101 = niftiread("sujeto1_brain_seg_1.nii"); % Gray Matter Segmentation
SegWhiteFSL101 = niftiread("sujeto1_brain_seg_2.nii");% White Matter Segmentation
BrainFSL101 = niftiread("sujeto1_brain.nii");         % Volumes of the brain

%Subject 2
SegGrayFSL112 = niftiread("sujeto12_brain_seg_1.nii"); % Gray Matter Segmentation
SegWhiteFSL112 = niftiread("sujeto12_brain_seg_2.nii");% White Matter Segmentation
BrainFSL112 = niftiread("sujeto12_brain.nii");         % Volumes of the brain

%Subject 3
SegGrayFSL121 = niftiread("sujeto21_brain_seg_1.nii"); % Gray Matter Segmentation
SegWhiteFSL121 = niftiread("sujeto21_brain_seg_2.nii");% White Matter Segmentation
BrainFSL121 = niftiread("sujeto21_brain.nii");         % Volumes of the brain

%R niftiinfo returns the metadata from the header in simplified form. 
info101 = niftiinfo("brain101.nii");
infoseg101 = niftiinfo("aseg101.nii");
info112 = niftiinfo("brain112.nii");
infoseg112 = niftiinfo("aseg112.nii");
info121 = niftiinfo("brain121.nii");
infoseg121 = niftiinfo("aseg121.nii");

%%
%Label selection of white matter, 

cw101 = Seg101 == 2 | Seg101 == 41;% Selección de los labels de materia blanca
cg101 = Seg101 == 3 | Seg101 == 42;% labels de materia gris, freesurfer separa las materias del lado izquierdo y
                                   % derecho, por eso hay cuatro labels en
                                   % total para las materias.
cw112 = Seg112 == 2 | Seg112 == 41;%
cg112 = Seg112 == 3 | Seg112 == 42;%

cw121 = Seg121 == 2 | Seg121 == 41;%
cg121 = Seg121 == 3 | Seg121 == 42;%

cwfsl101 = SegWhiteFSL101 == 1;% Fsl ya tiene un archivo donde solo se segmenta la materia gris y la blanca
cgfsl101 = SegGrayFSL101 == 1;% solo hay que escoger ese archivo y igualar la variable al index 1 
% donde estará la materia 

cwfsl112 = SegWhiteFSL112 == 1;%
cgfsl112 = SegGrayFSL112 == 1;

cwfsl121 = SegWhiteFSL121 == 1;%
cgfsl121 = SegGrayFSL121 == 1;

%% 101 

vol101 = Sub101;
zID101 = size(vol101,3)/2;
zSliceGT101 = labeloverlay(vol101(:,:,138),int16(cg101(:,:,138)));
zSlicePred101 = labeloverlay(vol101(:,:,138),int16(cw101(:,:,138)));
zSliceGtR101 = imrotate(zSliceGT101,-90);
zSlicePredR101 = imrotate(zSlicePred101,-90);

p1101 = imresize(cwfsl101,[256 256]);
Resicwfsl101 = permute(p1101,[1 3 2]);% El fsl cambia las dimensiones del cerebro en comparación con freesurfer
p2101 = imresize(cgfsl101,[256 256]); % es por esto que permute cambia las dimenciones para que coincidan y muestren
Resicgfsl101 = permute(p2101,[1 3 2]); % el mismo punto de vista, sagital, horizontal o en estos casos frontal
pg101 = int16(Resicgfsl101(:,:,138));
pw101 = int16(Resicwfsl101(:,:,138));% Vuelve la variable compatible para que se lea con el volumen

zSliceGT101fsl = labeloverlay(vol101(:,:,138),flip(pg101,2));% El flip se utiliza hacer espejo de la imagen, ya que con
zSlicePred101fsl = labeloverlay(vol101(:,:,138),flip(pw101,2));% una visualización previa nos dimos cuenta que los
zSliceGtR101fsl = imrotate(zSliceGT101fsl,-90);               % lados estaban invertidos entre free y fsl.
zSlicePredR101fsl = imrotate(zSlicePred101fsl,-90);% Rotamos la imagen para mejor visualización de resultados



%% 112 

vol112 = Sub112;% carga o renombre del volumen cerebral de comparación
zID112 = size(vol112,3)/2;
zSliceGT112 = labeloverlay(vol112(:,:,127),int16(cg112(:,:,127)));
zSlicePred112 = labeloverlay(vol112(:,:,127),int16(cw112(:,:,127)));
zSliceGtR112 = imrotate(zSliceGT112,-90);
zSlicePredR112 = imrotate(zSlicePred112,-90);

p1112 = imresize(cwfsl112,[256 256]); % Los archivos de labels del fsl se guardan en un formato 256x182x256
Resicwfsl112 = permute(p1112,[1 3 2]);% mientras que free tiene 256x256x265, el imresize vuleve el arreglo
p2112 = imresize(cgfsl101,[256 256]); % de fsl a la misma dimensión del archivo de labels de freesurfer
Resicgfsl112 = permute(p2112,[1 3 2]);
pg112 = int16(Resicgfsl112(:,:,127));
pw112 = int16(Resicwfsl112(:,:,127));

zSliceGT112fsl = labeloverlay(vol112(:,:,127),flip(pg112,2));% Overlay de las imagenes con slice de freesurfer
zSlicePred112fsl = labeloverlay(vol112(:,:,127),flip(pw112,2));% del cerebro correspondiente con los labels
zSliceGtR112fsl = imrotate(zSliceGT112fsl,-90);
zSlicePredR112fsl = imrotate(zSlicePred112fsl,-90);

%% 121  - fsl 87 free 125
vol121 = Sub121;
zID121 = size(vol121,3)/2;
zSliceGT121 = labeloverlay(vol121(:,:,125),int16(cg121(:,:,125)));
zSlicePred121 = labeloverlay(vol121(:,:,125),int16(cw121(:,:,125)));
zSliceGtR121 = imrotate(zSliceGT121,-90);
zSlicePredR121 = imrotate(zSlicePred121,-90);

p1121 = imresize(cwfsl121,[256 256]);
Resicwfsl121 = permute(p1121,[1 3 2]);
p2121 = imresize(cgfsl121,[256 256]);
Resicgfsl121 = permute(p2121,[1 3 2]);
pg121 = int16(Resicgfsl121(:,:,125));
pw121 = int16(Resicwfsl121(:,:,125));

zSliceGT121fsl = labeloverlay(vol121(:,:,125),flip(pg121,2));
zSlicePred121fsl = labeloverlay(vol121(:,:,125),flip(pw121,2));
zSliceGtR121fsl = imrotate(zSliceGT121fsl,-90);
zSlicePredR121fsl = imrotate(zSlicePred121fsl,-90);

figure (1)
subplot(2,1,1)
montage({zSliceGtR101,zSlicePredR101},Size=[1 2],BorderSize=5) 
title("Gray matter Freesurfer sub 101 (Left) vs. White matter Freesurfer sub 101 (Right)")

subplot(2,1,2)
montage({zSliceGtR101fsl,zSlicePredR101fsl},Size=[1 2],BorderSize=5) 
title("Gray matter Fsl sub 101 (Left) vs. Gray matter Fsl sub 101 (Right)")

figure (2)
subplot(2,1,1)
montage({zSliceGtR112,zSlicePredR112},Size=[1 2],BorderSize=5) 
title("Gray matter Freesurfer sub 112 (Left) vs. White matter Freesurfer sub 112 (Right)")

subplot(2,1,2)
montage({zSliceGtR112fsl,zSlicePredR112fsl},Size=[1 2],BorderSize=5) 
title("Gray matter Fsl sub 112 (Left) vs. Gray matter Fsl sub 112 (Right)")

figure (3)
subplot(2,1,1)
montage({zSliceGtR121,zSlicePredR121},Size=[1 2],BorderSize=5) 
title("Gray matter Freesurfer sub 121 (Left) vs. White matter Freesurfer sub 121 (Right)")

subplot(2,1,2)
montage({zSliceGtR121fsl,zSlicePredR121fsl},Size=[1 2],BorderSize=5) 
title("Gray matter Fsl sub 121 (Left) vs. Gray matter Fsl sub 121 (Right)")

%% Sub101 volumes

viewPnlTruth = uipanel(figure(4),Title="Freesurfer White matter 101 Volume");
hTruth = labelvolshow(int16(cw101),vol101,Parent=viewPnlTruth, ...
    LabelColor=[0 0 0; 1 0 0],VolumeThreshold=0.2);
hTruth.LabelVisibility(1) = 0;

viewPnlTruth = uipanel(figure(5),Title="Freesurfer Gray matter 101 Volume");
hTruth = labelvolshow(int16(cg101),vol101,Parent=viewPnlTruth, ...
    LabelColor=[0 0 0; 0 0 1],VolumeThreshold=0.2);
hTruth.LabelVisibility(1) = 0;

%%
cwfV101 = int16(imresize(cwfsl101,[256 256]));
cgfV101 = int16(imresize(cgfsl101,[256 256]));

viewPnlTruth = uipanel(figure(6),Title="Fsl White matter 101 Volume");
hTruth = labelvolshow(imrotate3(cwfV101,90,[0 1 0]),vol101,Parent=viewPnlTruth, ...
    LabelColor=[0 0 0; 1 0 0],VolumeThreshold=0.2);
hTruth.LabelVisibility(1) = 0;

viewPnlTruth = uipanel(figure(7),Title="Fsl Gray matter 101 Volume");
hTruth = labelvolshow(imrotate3(cgfV101,90,[0 1 0]),vol101,Parent=viewPnlTruth, ...
    LabelColor=[0 0 0; 0 0 1],VolumeThreshold=0.2);
hTruth.LabelVisibility(1) = 0;

%% Sub112 volumes

viewPnlTruth = uipanel(figure(8),Title="Freesurfer White matter 101 Volume");
hTruth = labelvolshow(int16(cw112),vol112,Parent=viewPnlTruth, ...
    LabelColor=[0 0 0; 1 0 0],VolumeThreshold=0.2);
hTruth.LabelVisibility(1) = 0;

viewPnlTruth = uipanel(figure(9),Title="Freesurfer Gray matter 101 Volume");
hTruth = labelvolshow(int16(cg112),vol112,Parent=viewPnlTruth, ...
    LabelColor=[0 0 0; 0 0 1],VolumeThreshold=0.2);
hTruth.LabelVisibility(1) = 0;
%%

cwfV112 = int16(imresize(cwfsl112,[256 256]));
cgfV112 = int16(imresize(cgfsl112,[256 256]));

viewPnlTruth = uipanel(figure(10),Title="Fsl White matter 101 Volume");
hTruth = labelvolshow(imrotate3(cwfV112,90,[0 1 0]),vol112,Parent=viewPnlTruth, ...
    LabelColor=[0 0 0; 1 0 0],VolumeThreshold=0.2);
hTruth.LabelVisibility(1) = 0;

viewPnlTruth = uipanel(figure(11),Title="Fsl Gray matter 101 Volume");
hTruth = labelvolshow(imrotate3(cgfV112,90,[0 1 0]),vol112,Parent=viewPnlTruth, ...
    LabelColor=[0 0 0; 0 0 1],VolumeThreshold=0.2);
hTruth.LabelVisibility(1) = 0;

%% Sub121 volumes

viewPnlTruth = uipanel(figure(12),Title="Freesurfer White matter 101 Volume");
hTruth = labelvolshow(int16(cw121),vol121,Parent=viewPnlTruth, ...
    LabelColor=[0 0 0; 1 0 0],VolumeThreshold=0.2);
hTruth.LabelVisibility(1) = 0;

viewPnlTruth = uipanel(figure(13),Title="Freesurfer Gray matter 101 Volume");
hTruth = labelvolshow(int16(cg121),vol121,Parent=viewPnlTruth, ...
    LabelColor=[0 0 0; 0 0 1],VolumeThreshold=0.2);
hTruth.LabelVisibility(1) = 0;

%%
cwfV121 = int16(imresize(cwfsl121,[256 256]));
cgfV121 = int16(imresize(cgfsl121,[256 256]));

viewPnlTruth = uipanel(figure(14),Title="Fsl White matter 121 Volume");
hTruth = labelvolshow(imrotate3(cwfV121,90,[0 1 0]),vol121,Parent=viewPnlTruth, ...
    LabelColor=[0 0 0; 1 0 0],VolumeThreshold=0.2);
hTruth.LabelVisibility(1) = 0;

viewPnlTruth = uipanel(figure(15),Title="Fsl Gray matter 121 Volume");
hTruth = labelvolshow(imrotate3(cgfV121,90,[0 1 0]),vol121,Parent=viewPnlTruth, ...
    LabelColor=[0 0 0; 0 0 1],VolumeThreshold=0.2);
hTruth.LabelVisibility(1) = 0;

%%
% Al tener desajustado los ejes o la pocisión de los volúmenes de los
% labels causó en un principio resultados Dice más bajos de los actuales,
% Con el procedimieto de explicado en la 101 se reajustaron las dimenciones
% del archivo de fsl y en esta parte solo se realiza el flip y la rotación
% necesaria para la coincidencia de los volúmenes y una mejor lectura Dice.

diceResultWhite101 = dice(flip(imrotate(cw101,-90),2),imrotate(Resicwfsl101,90));
diceResultGray101 = dice(flip(imrotate(cw101,-90),2),imrotate(Resicgfsl101,90));

diceResultWhite112 = dice(flip(imrotate(cw112,-90),2),imrotate(Resicwfsl112,90));
diceResultGray112 = dice(flip(imrotate(cw112,-90),2),imrotate(Resicgfsl112,90));

diceResultWhite121 = dice(flip(imrotate(cw121,-90),2),imrotate(Resicwfsl121,90));
diceResultGray121 = dice(flip(imrotate(cw121,-90),2),imrotate(Resicgfsl121,90));

%Visualización de coincidencia de los volumenes de los labels,
% para acceder a los otros pacientes y comparar esas segmentaciones solo
% cambiar el numero despues de cw- , cg- , Resicwfsl- y Resicgfsl- a los
% corresponientes con el paciente.
figure(8); 
imshow(flip(imrotate(cw112(:,:,138),-90),2)); title('Free');
figure(9); 
imshow(imrotate(Resicwfsl112(:,:,138),90)); title('Fsl');

figure(10); 
imshow(flip(imrotate(cg112(:,:,138),-90),2)); title('Free');
figure(11); 
imshow(imrotate(Resicgfsl112(:,:,138),90)); title('Fsl');





%%
% figure()
% minMRI = min(Sub101(:));
% maxMRI = max(Sub101(:));
% montage(reshape(uint16(Sub101),[size(Sub101,1), size(Sub101,2), 1, size(Sub101,3)]));
% set(gca, "clim", [0 100]);
% 
% mriTemp = Sub101(:,:,100);
% lb = 50;
% ub = 100;
% mriTemp(mriTemp <= lb) = 0;
% mriTemp(mriTemp >= ub) = 0;
% mriTemp(end -60:end,:) = 0;
% 
% imA = imadjust(mriTemp);
% figure(7)
% montage(imA);


% figure(2)
% viewPnlPred = uipanel(figure,Title="Predicted Labeled Volume");
% hPred = labelvolshow(Seg101,vol3d,Parent=viewPnlPred, ...
%     LabelColor=[0 0 0;1 0 0],VolumeThreshold=0.68);
% hPred.LabelVisibility(1) = 0;

% tool = imtool3D(Sub101);
% tool.setMask(Seg101);
%P1 = labelsToBinary(Seg101);

%% 
% c1 = Seg121(:,:,125);
% %Sujeto 121 freesurf = slice 125, fsl = 89
% %c2 = BrainFSL121(:,:,88); %n is the slice number that you want to visualize.
% Vmax = max(SegWhiteFSL121,[],'all'); % Maximum value in the whole scan
% Vmin = min(SegWhiteFSL121,[],'all'); % Minimum value in the whole scan
% 
% Va101_prime = (SegWhiteFSL121-Vmin)./(Vmax-Vmin); % Normalization -> values between 0 and 1
% dim = size(Va101_prime); % Dimensions of the volume
% % ; %n is the slice number that you want to visualize.
% sliceY = 89;
% 
% horizontal = reshape(Va101_prime(:,sliceY,:),[dim(3) dim(1)]); % Horizontal view
% 
% %De 52 a 217 
% cr1 = reshape(imrotate(flip(c1,1),-90),[dim(3) dim(1)]);
% figure(3)
% imshow(cwfree,[])
% colormap jet
% 
% % cr2 = imrotate(horizontal,90);
% figure(4)
% imshow(imrotate(cwfsl121,-90),[])
% colormap jet
