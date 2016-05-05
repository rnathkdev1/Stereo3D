function [ F ] = eightpoint_nosave( pts1, pts2, M)
% eightpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.1 - Todo:
%     Implement the eightpoint algorithm
%     Generate a matrix F from some '../data/some_corresp.mat'
%     Save F, M, pts1, pts2 to q2_1.mat

%     Write F and display the output of displayEpipolarF in your writeup

%% Creating the A matrix
pts1=pts1';
pts2=pts2';
pts1=[pts1;ones(1,length(pts1))];
pts2=[pts2;ones(1,length(pts2))];
% Normalizing the image
T=[2/M, 0 ,-1; 0, 2/M, -1; 0 0 1];

pts1=T*pts1;
pts2=T*pts2;

% Pts 1 has non primed components and 2 has primed components.
Pts1=[pts1(1,:);pts1(1,:);pts1(1,:);pts1(2,:);pts1(2,:);pts1(2,:);ones(3,length(pts1))];
Pts2=repmat(pts2,[3,1]);

A=(Pts1.*Pts2)';
[~, ~, V]=svd(A);

% Enforcing the singularity condition, we have
F=reshape(V(:,9),3,3)';
[U, D, V]=svd(F);
D(end,end)=0;
F=U*D*V';
F = refineF(F,pts1',pts2');

%Denormalizing
F=T'*F*T;

%% Processing and saving the data
pts1(3,:)=[];
pts2(3,:)=[];
pts1=pts1';
pts2=pts2';

end

