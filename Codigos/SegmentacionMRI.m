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
[L1,Centers1] = imsegkmeans(int8(255*f1),2);
B1 = labeloverlay(f1,L1);
imshow(B1)
title("Labeled Image")
imshow(int8(255*f1)<Centers1(1),[])
imshow(int8(255*f1)<Centers1(2),[])
imshow(int8(255*f1)>Centers1(3),[])
edgemap1 = abs(conv2(L1,dxp1,'same'))+abs(conv2(L1,dyp1,'same'));
imshow(f1+edgemap1,[0,1]);

%imagen 2

%% K=3
%imagen 1
[L1,Centers1] = imsegkmeans(int8(255*f1),3);
B1 = labeloverlay(f1,L1);
imshow(B1)
title("Labeled Image")
imshow(int8(255*f1)<Centers1(1),[])
imshow(int8(255*f1)<Centers1(2),[])
imshow(int8(255*f1)>Centers1(3),[])
edgemap1 = abs(conv2(L1,dxp1,'same'))+abs(conv2(L1,dyp1,'same'));
imshow(f1+edgemap1,[0,1]);

%imagen 2

%% K=4
%imagen 1
[L1,Centers1] = imsegkmeans(int8(255*f1),4);
B1 = labeloverlay(f1,L1);
imshow(B1)
title("Labeled Image")
imshow(int8(255*f1)<Centers1(1),[])
imshow(int8(255*f1)<Centers1(2),[])
imshow(int8(255*f1)>Centers1(3),[])
edgemap1 = abs(conv2(L1,dxp1,'same'))+abs(conv2(L1,dyp1,'same'));
imshow(f1+edgemap1,[0,1]);

%imagen 2



%% 