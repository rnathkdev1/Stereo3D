function [ x2, y2 ] = epipolarCorrespondence( im1, im2, F, x1, y1 )
% epipolarCorrespondence:
%       im1 - Image 1
%       im2 - Image 2
%       F - Fundamental Matrix between im1 and im2
%       x1 - x coord in image 1
%       y1 - y coord in image 1

% Q2.6 - Todo:
%           Implement a method to compute (x2,y2) given (x1,y1)
%           Use F to only scan along the epipolar line
%           Experiment with different window sizes or weighting schemes
%           Save F, pts1, and pts2 used to generate view to q2_6.mat
%
%           Explain your methods and optimization in your writeup


%% Initializing window size for feature detection
% window = n implies that we choose an nxn window around the point.
window=9;

im1=rgb2gray(im2double(im1));
im2=rgb2gray(im2double(im2));


v=[x1;y1;1];
[sy,sx]= size(im2);
l = F * v;

s = sqrt(l(1)^2+l(2)^2);

if s==0
    error('Zero line vector in displayEpipolar');
end

l = l/s;

if l(1) ~= 0
    ye = sy;
    ys = 1;
    xe = -(l(2) * ye + l(3))/l(1);
    xs = -(l(2) * ys + l(3))/l(1);
else
    xe = sx;
    xs = 1;
    ye = -(l(1) * xe + l(3))/l(2);
    ys = -(l(1) * xs + l(3))/l(2);
end

% Epipolar line extends between (xs ys) and (xe ye)

c=(xe*ys - ye*xs)/(xe-xs);
m=(ye-ys)/(xe-xs);

%y=mx + c;

deg=atand(m);

% Instead of checking all over the epipolar line we check in a small region
%near the original Y, say 30 pixels.
ys_=y1-30;
ye_=y1+30;

if ys_<ys
    ys_=1;
end
if ye_>ye
    ye_=ye;
end

y=ys_:ye_;

if deg~=90
    x=(y-c)/m;
else x=xs;
end

range=(window-1)/2;

% Let us consider a window around each pixel in the image and in the  have considered

% Calculating a descriptor for the first image, we have:
% Current point is x,y. Thus we have a range window around x,y
[X1,Y1]=meshgrid(1:size(im1,2),1:size(im1,1),1);
[X,Y]=meshgrid(x1-range:x1+range,y1-range:y1+range,1);
V_ref=interp2(X1,Y1,im1,X,Y);
V_im1=V_ref(:);

% Calculating the descriptors for the search points
[X2,Y2]=meshgrid(1:size(im2,2),1:size(im2,1),1);


V_im2=[];

for i=1:length(x)
    
    xpoint=x(i);
    ypoint=y(i);
    [X,Y]=meshgrid(xpoint-range:xpoint+range,ypoint-range:ypoint+range,1);
    V_compare=interp2(X2,Y2,im2,X,Y);
    V_compare=V_compare(:);
    V_im2=cat(2,V_im2,V_compare);
    
end

D = pdist2(V_im1',V_im2');
[~,I]=min(D);

x2=x(I);
y2=y(I);

end

