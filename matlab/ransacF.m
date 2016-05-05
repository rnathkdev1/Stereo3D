function [ bestF ] = ransacF( pts1, pts2, M )
% ransacF:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.X - Extra Credit:
%     Implement RANSAC
%     Generate a matrix F from some '../data/some_corresp_noisy.mat'
%          - using eightpoint
%          - using ransac

%     In your writeup, describe your algorith, how you determined which
%     points are inliers, and any other optimizations you made

%% Beginning RANSAC

maxInliers=0;
nIter=200;
Epsilon=5;
pts1(:,3)=1;
pts2(:,3)=1;
for i=1:nIter
    i
    % Choosing random 15 point correspondences
    indices=randperm(length(pts1),15);
    Pts1=pts1(indices,1:2);
    Pts2=pts2(indices,1:2);
    
    F = eightpoint_nosave(Pts1, Pts2, M);
    L1=normalizeLine(F * pts1');
    dist1=abs(dot( L1, pts2' ));
    
    L2=normalizeLine(F * pts2');
    dist2=abs(dot( L2, pts1' ));
    
    inliers = find(dist1 < Epsilon & dist2 < Epsilon);
    
    inlierCount = size(inliers,2);
    if inlierCount > 0
        resErr = sum( dist1(inliers).^2 + dist2(inliers).^2 ) / inlierCount;
        %resErr = sampsonErrf( F, x(inliers,1:2), xp(inliers,1:2) );
    else
        resErr = Inf;
    end
    if inlierCount > maxInliers || (inlierCount == maxInliers && resErr < bestResErr)
        % keep best found so far
        maxInliers = inlierCount
        bestResErr = resErr;
        bestF = F;
        bestInliers = inliers;
    end 
    
end

end

