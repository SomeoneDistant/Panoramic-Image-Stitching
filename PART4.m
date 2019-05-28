clear;
clc;
img1=im2double(imread('im01.jpg'));
img2=im2double(imread('im02.jpg'));

figure(1)
imshow(img1)
gui=dialog('name', 'Promption', 'position', [580, 400, 370, 70]);
uicontrol('parent', gui, 'style', 'text', 'string', 'Please select 4 points in each picture.', 'position', [50, 40, 270, 20], 'fontsize', 12);
uicontrol('parent', gui, 'style', 'pushbutton', 'position', [160, 10, 50, 20], 'string', 'OK', 'callback', 'delete(gcbf)');
[X1, Y1]=ginput(4);
hold on
plot(X1, Y1, 'rx', 'MarkerSize', 20);
hold off
p1 = round([X1,Y1]);

figure(2)
imshow(img2)
[X2, Y2]=ginput(4);
hold on
plot(X2, Y2, 'rx', 'MarkerSize', 20);
hold off
p2=round([X2, Y2]);

A=zeros(8, 9);
for i=1:4
	x1 = p2(i, 1);
	y1 = p2(i, 2);
	x2 = p1(i, 1);
	y2 = p1(i, 2);
	ax = [x1, y1, 1, 0, 0, 0, -x2*x1, -x2*y1, -x2];
	ay = [0, 0, 0, x1, y1, 1, -y2*x1, -y2*y1, -y2];
    A(i.*2-1, :) = ax;
	A(i.*2, :) = ay;
end
[~, ~, V] = svd(A);
H = reshape(V(:, end), [3, 3])';
result=warp_stitch(img1, img2, H, 1);

figure(3)
imshow(result)
fprintf('Homography matrix from im01.jpg to im02.jpg is\n');
H./H(3,3)
