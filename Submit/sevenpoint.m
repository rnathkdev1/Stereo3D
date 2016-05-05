function [ F ] = sevenpoint( pts1, pts2, M )
% sevenpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.2 - Todo:
%     Implement the eightpoint algorithm
%     Generate a matrix F from some '../data/some_corresp.mat'
%     Save recovered F (either 1 or 3 in cell), M, pts1, pts2 to q2_2.mat

%     Write recovered F and display the output of displayEpipolarF in your writeup

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

% Using the last 2 rows of V we have
F1=reshape(V(:,9),3,3)';
F2=reshape(V(:,8),3,3)';

syms L;
soln=solve(det(F1+L*F2)==0,L);
soln= double(soln);

i=1;
soln=round(10000*soln)/10000;
if isreal(soln(1))
    F{i}=F1+soln(1)*F2;
    F{i}=T'*F{i}*T;
    i=i+1;
end

if isreal(soln(2))
    F{i}=F1+soln(2)*F2;
    F{i}=T'*F{i}*T;
    i=i+1;
end

if isreal(soln(3))
    F{i}=F1+soln(3)*F2;
    F{i}=T'*F{i}*T;
end


%% Processing and saving the data
pts1(3,:)=[];
pts2(3,:)=[];
pts1=pts1';
pts2=pts2';

%% The following has been coded after testing manually using displayEpipolar
Fcorrect=F{2};
save('q2_2.mat','Fcorrect','M','pts1','pts2');

end

