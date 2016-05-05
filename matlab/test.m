clc; clear;
errormat=[];

load('../data/some_corresp.mat');
img1=imread('../data/im1.png');
img2=imread('../data/im2.png');
M=max(max(size(img1),size(img2)));
% F=ransacF( pts1, pts2, M );
F = eightpoint( pts1, pts2, M);
F2 = sevenpoint( pts1, pts2, M );
% clearvars MPics

F_noransac=eightpoint( pts1, pts2, M);
displayEpipolarF(img2, img1, F);

load('../data/intrinsics.mat');

E = essentialMatrix(F, K1, K2);
[M2s] = camera2(E);

for i=1:4
    M=M2s(:,:,i);
    M1=K1*M;
    M2=K2*M;
    
    [ P, error ] = triangulate( M1, pts1, M2, pts2 );
    errormat=cat(1,errormat,error);
end


[~,I]=min(errormat);
M=M2s(:,:,I);
M1=K1*M;
M2=K2*M;