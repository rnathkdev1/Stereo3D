clc; clear;

load('../data/some_corresp.mat');
img1=imread('../data/im1.png');
img2=imread('../data/im2.png');
load('q2_1.mat');
[coordsIM1, coordsIM2] = epipolarMatchGUI(img1, img2, F);
save('q2_6.mat','F','coordsIM1','coordsIM2');


load('../data/templeCoords.mat');
[ P, error ] = triangulate( M1, p1, M2, p2 );


