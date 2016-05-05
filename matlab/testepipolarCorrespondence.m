clc; clear;

load('../data/some_corresp.mat');
img1=imread('../data/im1.png');
img2=imread('../data/im2.png');
M=max(max(size(img1),size(img2)));
F = eightpoint( pts1, pts2, M);

[ x2, y2 ] = epipolarCorrespondence( img1, img2, F, 200, 200 );
