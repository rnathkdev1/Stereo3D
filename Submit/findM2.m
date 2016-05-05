clc; clear;
% Q2.5 - Todo:

%       2. Obtain the correct M2
%       4. Save the correct M2, p1, p2, R and P to q2_5.mat

errormat=[];

load('../data/some_corresp.mat');
img1=imread('../data/im1.png');
img2=imread('../data/im2.png');
M=max(max(size(img1),size(img2)));
F = eightpoint( pts1, pts2, M);

displayEpipolarF(img1, img2, F);



displayEpipolarF(img1, img2, F);
clearvars M
load('../data/intrinsics.mat');

E = essentialMatrix(F, K1, K2);
[M2s] = camera2(E);
Meye=[eye(3,3), zeros(3,1)];
M1=K1*Meye;

for i=1:4
    M=M2s(:,:,i);
    M2=K2*M;
    [ P, error ] = triangulate( M1, pts1, M2, pts2 );
    errormat=cat(1,errormat,error);
end


[~,I]=min(errormat);
M=M2s(:,:,I);
M1=K1*Meye;
M2=K2*M;
[ P, error ] = triangulate( M1, pts1, M2, pts2 );
save('q2_5.mat','M2','pts1','pts2','P')