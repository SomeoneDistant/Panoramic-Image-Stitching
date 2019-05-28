clear;
clc;
img1=imread('im01.jpg');
[img, des, loc] = sift(img1);
showkeys(img1, loc, des);

figure(2)
subplot(2, 1, 1)
bar(des(2, :))
title('Descriptors of Blue and Red Keypoints')
ylabel('Scale')
xlabel('Blue Keypoint''s Descriptors')
subplot(2, 1, 2)
bar(des(30, :))
xlabel('Red Keypoint''s Descriptors')
ylabel('Scale')