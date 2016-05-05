clc;clear;
load('q2_5.mat','M2');
load('../data/intrinsics.mat','K1');
load('q2_1.mat','F');
load('../data/templeCoords.mat');
img1=imread('../data/im1.png');
img2=imread('../data/im2.png');
Meye=[eye(3,3), zeros(3,1)];
M1=K1*Meye;
pts1=[x1,y1];
pts2=[];


for i=1:length(x1)
    i
    x=x1(i);
    y=y1(i);
    [x_, y_] = epipolarCorrespondence( img1, img2, F, x, y);
    pts2=cat(1,pts2,[x_,y_]);
    
end


[P, ~] = triangulate( M1, pts1, M2, pts2 );
scatter3(P(1,:),P(2,:),P(3,:));
save('Final3D.mat');
save('q2_7.mat','F','M1','M2');