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
dxp1=[0,1;-1,0]; %detecci�n de orillas, m�scara de roberts
dyp1=[1,0;0,-1]; %detecci�n de orillas, m�scara de roberts
edgemap1 = abs(conv2(L1,dxp1,'same'))+abs(conv2(L1,dyp1,'same')); %convoluci�n de segmentaci�n
subplot(1,3,3)
imshow(f1+edgemap1,[0,1]); %muestra imagen con mapa
L(edgeC1) = 0;

%imagen 2
edgeC2 = edge(f2,'Canny'); %orillas 
figure(4)
subplot(1,3,1)
imshow(edgeC2,[])
D2 = bwdist(edgeC2); %mapa de distancia
subplot(1,3,2)
imshow(D2,[])
title('Distance Transform of Binary Image')
L = watershed(D2); %watershed
dxp2=[0,1;-1,0]; %detecci�n de orillas, m�scara de roberts
dyp2=[1,0;0,-1]; %detecci�n de orillas, m�scara de roberts
edgemap2 = abs(conv2(L,dxp2,'same'))+abs(conv2(L,dyp2,'same')); %convoluci�n de segmentaci�n
subplot(1,3,3)
imshow(f2+edgemap2,[0,1]); %muestra imagen con mapa
L(edgeC2) = 0;

%% Pulm�n derecho (1era imagen)

Leftlung= L==479 | L==459 | L==433 | L==578 | L==719 | L==694 | L==710;
imshow(Leftlung,[]);

%% Hueso cadera izquierda (2da imagen)






