%%%SEGMENTACION MRI
clear all; close all; clc;
%% Cargando imagenes
%imagen 1
f1=imread('CT_CHEST.jpeg');
f1=double(f1(:,:,1)); %normalizar imagen de 0 a 1
f1=f1/max(max(f1));
figure(1); imshow(f1,[]); %mostrar imagen

%imagen 2
f2=imread('CT-abdomenal.jpg');
f2=double(f2(:,:,1)); %normalizar imagen de 0 a 1
f2=f2/max(max(f2));
figure(2); imshow(f2,[]); %mostrar imagen

%% Otsu method
%imagen 1
thr1 = graythresh(f1);
seg1 = f1 > thr1;
imshow(seg1,[])
dxp1=[0,1;-1,0];
dyp1=[1,0;0,-1];
edgemap1 = abs(conv2(seg1,dxp1,'same'))+abs(conv2(seg1,dyp1,'same'));
imshow(f1+edgemap1,[0,1]);

%imagen 2
thr2 = graythresh(f2);
seg2 = f2 > thr2;
imshow(seg2,[])
dxp2=[0,1;-1,0];
dyp2=[1,0;0,-1];
edgemap2 = abs(conv2(seg2,dxp2,'same'))+abs(conv2(seg2,dyp2,'same'));
imshow(f2+edgemap2,[0,1]);


%% K Means
%% K=2
%imagen 1
[L1,Centers1] = imsegkmeans(uint8(255*f1),2);
B1 = labeloverlay(f1,L1);
imshow(B1,[]);
title("Labeled Image")

%imagen 2
[L2,Centers2] = imsegkmeans(uint8(255*f2),2);
B2 = labeloverlay(f2,L2);
imshow(B2,[])
title("Labeled Image")

%% K=3
%imagen 1
[L1,Centers1] = imsegkmeans(uint8(255*f1),3);
B1 = labeloverlay(f1,L1);
imshow(B1,[]);
title("Labeled Image")

%imagen 2
[L2,Centers2] = imsegkmeans(uint8(255*f2),3);
B2 = labeloverlay(f2,L2);
imshow(B2,[]);
title("Labeled Image")

%% K=4
%imagen 1
[L1,Centers1] = imsegkmeans(uint8(255*f1),4);
B1 = labeloverlay(f1,L1);
imshow(B1,[]);
title("Labeled Image")

%imagen 2
[L2,Centers2] = imsegkmeans(uint8(255*f2),4);
B2 = labeloverlay(f2,L2);
imshow(B2,[]);
title("Labeled Image")

%% Watersherd Segementation
%imagen 1
edgeC1 = edge(f1,'Canny'); %orillas 
figure(3)
subplot(1,3,1)
imshow(edgeC1,[])
D1 = bwdist(edgeC1); %mapa de distancia
subplot(1,3,2)
imshow(D1,[])
title('Distance Transform of Binary Image')
L1 = watershed(D1); %watershed
dxp1=[0,1;-1,0]; %detección de orillas, máscara de roberts
dyp1=[1,0;0,-1]; %detección de orillas, máscara de roberts
edgemap1 = abs(conv2(L1,dxp1,'same'))+abs(conv2(L1,dyp1,'same')); %convolución de segmentación
subplot(1,3,3)
imshow(f1+edgemap1,[0,1]); %muestra imagen con mapa
L1(edgeC1) = 0;
%%
%imagen 2
edgeC2 = edge(f2,'Canny'); %orillas 
figure(4)
subplot(1,3,1)
imshow(edgeC2,[])
D2 = bwdist(edgeC2); %mapa de distancia
subplot(1,3,2)
imshow(D2,[])
title('Distance Transform of Binary Image')
L2 = watershed(D2); %watershed
dxp2=[0,1;-1,0]; %detección de orillas, máscara de roberts
dyp2=[1,0;0,-1]; %detección de orillas, máscara de roberts
edgemap2 = abs(conv2(L2,dxp2,'same'))+abs(conv2(L2,dyp2,'same')); %convolución de segmentación
subplot(1,3,3)
imshow(f2+edgemap2,[0,1]); %muestra imagen con mapa
L2(edgeC2) = 0;

%% Pulmón derecho (1era imagen)
Leftlung= L1==479 | L1==459 | L1==433 | L1==578 | L1==719 | L1==694 | L1==710;
imshow(Leftlung,[]);

diskse=strel('disk',5);
Leftlung_close=imclose(Leftlung,diskse);
imshow(Leftlung_close)

B_1=labeloverlay(f1,Leftlung_close);
imshow(B_1);
title("Left lung overlay");

disksel1=strel('disk',11);
label_lung=imopen(Leftlung_close,disksel1);
imshow(label_lung);

B_1=labeloverlay(f1,label_lung);
imshow(B_1)
title("Final left lung overlay");

%% Hueso cadera izquierda (2da imagen)
f=imread('CT-abdomenal.jpg');
f=double(f(:,:,1)); % normalizando imagen de 0 a 1
f=f/max(max(f));
figure(1)
imshow(f,[]); % mostrar imagen con nuevo tamaño

% Disk for clossing labels
diskse= strel('disk',5);
diskse11= strel('disk',11);

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
colormap('jet')

%lefthio =(--index or
%index found== 94, 86
PelvisLabel=(--94);
figure(4)
imshow(labeled==PelvisLabel,[])
B = labeloverlay(f,labeled==PelvisLabel);
imshow(B)
title("Left Hip overlay")
















