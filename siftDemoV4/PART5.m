clear;
clc;
img1=im2double(imread('im01.jpg'));
img2=im2double(imread('im02.jpg'));
img3=[img1, img2];
[hight, width, ~]=size(img1);

[~, des1, loc1] = sift(img1);
[~, des2, loc2] = sift(img2);
[~, match1, match2]=match_sift(des1, loc1, des2, loc2);

figure(1)
hold on
imshow(img3)
for i = 1:size(match1, 2)
    line([match1(1, i), match2(1, i) + width], [match1(2, i), match2(2, i)])
end
hold off

[H,inlier]=ransacH(match1, match2, 12);
result1=warp_stitch(img1, img2, H, 1);

figure(2)
hold on;
imshow(img3);
for i = inlier
    line([match1(1, i), match2(1, i) + width], [match1(2, i), match2(2, i)])
end
hold off;

figure(3)
imshow(result1)

Hprime=inv(H ./ H(3, 3));
result2=warp_stitch(img2, img1, Hprime, 1);

figure(4)
imshow(result2)

fprintf('Homography matrix from im01.jpg to im02.jpg is\n');
H./H(3,3)