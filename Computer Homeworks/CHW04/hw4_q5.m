%clear; clc; close all;
I = image;
iptsetpref('ImshowAxesVisible','on')
%{
imshow(image(:,:,1));
tform = randomAffine2d('Scale',[1.2,2.4],'XTranslation',[100 200],'Rotation',[-45,45]);
centerOutput = affineOutputView(size(A),tform,'BoundsStyle','CenterOutput');
followOutput = affineOutputView(size(A),tform,'BoundsStyle','FollowOutput');
sameAsInput = affineOutputView(size(A),tform,'BoundsStyle','SameAsInput');

BCenterOutput = imwarp(A,tform,'OutputView',centerOutput);
BFollowOutput = imwarp(A,tform,'OutputView',followOutput);
BSameAsInput = imwarp(A,tform,'OutputView',sameAsInput);

imshow(BFollowOutput)
title('FollowOutput Bounds Style');
%}

%tform1 = randomAffine2d('Rotation',[35 55]);
firstPhoto = image(:,:,1);
secondPhoto = image(:,:,2);

J = imrotate(secondPhoto,30);

J2 = imcrop(J,[17 17 74 74]);
%{
targetSize = [60 60];
r = centerCropWindow2d(size(I),targetSize);
J2 = imcrop(I,r);
%}

%imshow(J)
figure;

imshow(firstPhoto);
%{
figure;
imshow(J);
figure;
imshow(J2);
%}
figure;
J3 = circshift(J2,[5,5]);
imshow(J3);

R = corr2(firstPhoto,J3);
%difference = J3 - firstPhoto;
%S = sum(difference,'all');


