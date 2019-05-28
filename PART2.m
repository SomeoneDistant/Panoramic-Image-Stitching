clear;
clc;
img1=imread('im01.jpg');
img2=imread('im02.jpg');
img3 = [img1, img2];

[~, des1, loc1] = sift(img1);
[~, des2, loc2] = sift(img2);
[height, width, ~]=size(img1);
[match, match1, match2]=match_sift(des1, loc1, des2, loc2);

figure(1)
hold on
imshow(img3)
for i = 1:100
    line([match1(1, i), match2(1, i) + width], [match1(2, i), match2(2, i)])
end
line([loc1(100, 2), loc2(81, 2) + width], [loc1(100, 1), loc2(81, 1)], 'Color', 'g')
line([loc1(865, 2), loc2(1238, 2) + width], [loc1(865, 1), loc2(1238, 1)], 'Color', 'r')
hold off

num = size(match1, 2);
fprintf('Found %d matches.\n', num);

figure(2)
subplot(2, 1, 1)
bar(des1(100, :))
title('Descriptors of Keypoints on Green Line')
ylabel('Scale')
xlabel('Descriptors of Keypoint from Image 1')
subplot(2, 1, 2)
bar(des2(81, :))
ylabel('Scale')
xlabel('Descriptors of Keypoint from Image 2')

figure(3)
subplot(2, 1, 1);
bar(des1(865, :));
title('Descriptors of Keypoints on Red Line')
ylabel('Scale')
xlabel('Descriptors of Keypoint from Image 1')
subplot(2, 1, 2);
bar(des2(1238, :));
ylabel('Scale')
xlabel('Descriptors of Keypoint from Image 2')
