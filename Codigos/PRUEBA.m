
clear all; close all; clc;

f=imread('CT-abdomenal.jpg');
f=double(f(:,:,1)); % normalizando imagen de 0 a 1
f=f/max(max(f));
figure(1)
imshow(f,[]); % mostrar imagen con nuevo tamaño

% Disk for clossing labels
%diskse= strel('disk',5);
%diskse11= strel('disk',11);

%K-MEANS
[L,Centers] = imsegkmeans(uint8(255*f),3);
B = labeloverlay(f,L); % imshow(seg1.*f,[])
figure(2)
imshow(B,[])
title("Labeled Image")

%LABELS
%First label
figure(2)
subplot(3,2,1)
title('First Label')
label_one = L == 1;
imshow(label_one)
% remove false negatives wiht imclose
label_close_one = imclose(label_one,diskse);
subplot(3,2,2)
imshow(label_close_one)

%second label
label_two = L == 2;
subplot(3,2,3)
imshow(label_two)
title('Second Label')
% remove false negatives wiht imclose
label_close_two = imclose(label_two,diskse);
subplot(3,2,4)
imshow(label_close_two)

%Third label
label_three = L == 3;
subplot(3,2,5)
imshow(label_three)
title('Label Three')
% remove false negatives wiht imclose
label_close_three = imclose(label_three,diskse);
subplot(3,2,6)
imshow(label_close_three)

cc = bwconncomp(label_close_three,4)
labeled = labelmatrix(cc);
figure(3)
imshow(labeled,[])
colormap('cool')

 %lefthio =(--index or
%index found== 94, 86
PelvisLabel=(--94);
figure(4)
imshow(labeled==PelvisLabel,[])
B = labeloverlay(f,labeled==PelvisLabel);
imshow(B)
title("Left Hip overlay")



%WATERSHED
edgeC = edge(f,'Canny'); %orillas 
figure(5)
subplot(1,3,1)
imshow(edgeC,[])
D = bwdist(edgeC); %mapa de distancia
subplot(1,3,2)
imshow(D,[])
title('Distance Transform of Binary Image')
L = watershed(D); %usar watershed
dxp=[0,1;-1,0]; %detección de orillas, máscara de roberts
dyp=[1,0;0,-1]; %detección de orillas, máscara de roberts
edgemap = abs(conv2(L,dxp,'same'))+abs(conv2(L,dyp,'same')); %convolución de segmentación
subplot(1,3,3)
imshow(f+edgemap,[0,1]); %muestra imagen con mapa
L(edgeC) = 0;

figure(7)
imshow(L,[])
colormap('cool')

LeftPelvis = L==399
figure(8)
imshow(LeftPelvis)

LeftPelvis_close = imclose(LeftPelvis,diskse);
figure(9)
imshow(LeftPelvis_close)

%Label overlay
B = labeloverlay(f,LeftPelvis_close);
figure(10)
imshow(B)
title("Left Pelvis overlay")

%remove false positives wiht imopen
label_pelvis = imopen(LeftPelvis_close,diskse11);
imshow(label_pelvis)

B = labeloverlay(f,label_pelvis);
figure(11)
imshow(B)
title("Final Left Pelvis Overlay")