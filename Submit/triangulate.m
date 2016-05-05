function [ P, error ] = triangulate( M1, p1, M2, p2 )
% triangulate:
%       M1 - 3x4 Camera Matrix 1
%       p1 - Nx2 set of points
%       M2 - 3x4 Camera Matrix 2
%       p2 - Nx2 set of points

% Q2.4 - Todo:
%       Implement a triangulation algorithm to compute the 3d locations
%       See Szeliski Chapter 7 for ideas
%
P=[];
% error=0;

%% Triangulation
for i=1:length(p1)
    P1=p1(i,:);
    P2=p2(i,:);
    
    A=[ P1(1)*M1(3,:)-M1(1,:);
        P1(2)*M1(3,:)-M1(2,:);
        P2(1)*M2(3,:)-M2(1,:);
        P2(2)*M2(3,:)-M2(2,:);];
    
    [~, ~, V]=svd(A);
    X=V(:,end);
    X=X/X(4);
    
    P=cat(2,P,X);
    
end

%% Checking for the error
P_temp=P;

p1_=M1*P_temp;
p2_=M2*P_temp;

p1_(1,:)=p1_(1,:)./p1_(3,:);
p1_(2,:)=p1_(2,:)./p1_(3,:);
p1_(3,:)=p1_(3,:)./p1_(3,:);
p1_(3,:)=[];


p2_(1,:)=p2_(1,:)./p2_(3,:);
p2_(2,:)=p2_(2,:)./p2_(3,:);
p2_(3,:)=p2_(3,:)./p2_(3,:);
p2_(3,:)=[];

p1_=p1_';
p2_=p2_';

error=sum(sum((p1-p1_).^2)) + sum(sum((p2-p2_).^2));

end

