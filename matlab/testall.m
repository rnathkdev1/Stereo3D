clc; clear
load('q2_7.mat');

img1=imread('../data/im1.png');
img2=imread('../data/im2.png');

displayEpipolarF(img2, img1, Fcorrect);


