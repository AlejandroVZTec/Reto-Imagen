%%%SEGMENTACION MRI

clear all; close all; clc;
%% Cargando imagenes

%imagen 1
f1=imread('CT_CHEST.jpeg');
f1=double(f1(:,:,1));
f1=f1/max(max(f1));
f1=imresize(f1,0.85);
figure(1)
imshow(f1,[]);

%imagen 2
f2=imread('CT-abdomenal.jpg');
f2=double(f2(:,:,1));
f2=f2/max(max(f2));
f2=imresize(f2,0.85);
figure(1)
imshow(f2,[]);

%% Otsu method

%imagen 1
thr1 = graythresh(f1);
seg1 = f1 > thr1;
imshow(seg1,[])
dxp1=[0,1;-1,0];
dyp1=[1,0;0,-1];
edgemap = abs(conv2(seg1,dxp1,'same'))+abs(conv2(seg1,dyp1,'same'));
imshow(f1+edgemap,[0,1]);

%imagen 2
thr2 = graythresh(f2);
seg2 = f2 > thr2;
imshow(seg2,[])
dxp2=[0,1;-1,0];
dyp2=[1,0;0,-1];
edgemap = abs(conv2(seg2,dxp2,'same'))+abs(conv2(seg2,dyp2,'same'));
imshow(f2+edgemap,[0,1]);

%% K Means



%% 