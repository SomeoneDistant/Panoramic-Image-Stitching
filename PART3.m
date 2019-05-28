clear;
clc;
img1=im2double(imread('h1.jpg'));
img2=im2double(imread('h2.jpg'));

figure(1)
imshow(img1)
gui=dialog('name', 'Promption', 'position', [580, 400, 370, 70]);
uicontrol('parent', gui, 'style', 'text', 'string', 'Please select 4 points in each picture.', 'position', [50, 40, 270, 20], 'fontsize', 12);
uicontrol('parent', gui, 'style', 'pushbutton', 'position', [160, 10, 50, 20], 'string', 'OK', 'callback', 'delete(gcbf)');
[X1, Y1]=ginput(4);
hold on
plot(X1, Y1, 'rx', 'MarkerSize', 20)
hold off
p1 = round([X1, Y1]);

figure(2)
imshow(img2)
[X2, Y2]=ginput(4);
hold on
plot(X2, Y2, 'rx', 'MarkerSize', 20);
hold off
p2=round([X2, Y2]);

A1=zeros(8, 9);
for i=1:4
	x1 = p1(i, 1);
	y1 = p1(i, 2);
	x2 = p2(i, 1);
	y2 = p2(i, 2);
	Ax = [x1, y1, 1, 0, 0, 0, -x2*x1, -x2*y1, -x2];
	Ay = [0, 0, 0, x1, y1, 1, -y2*x1, -y2*y1, -y2];
    A1(i.*2-1, :) = Ax;
	A1(i.*2, :) = Ay;
end
[~, ~, V1] = svd(A1);
H1 = reshape(V1(:, end), [3, 3])';
img1to2=warpH(img1, H1);

figure(3)
imshow(img1to2)
fprintf('Homography matrix from h1.jpg to h2.jpg is\n');
H1./H1(3,3)

A2=zeros(8, 9);
for i=1:4
	x1 = p2(i, 1);
	y1 = p2(i, 2);
	x2 = p1(i, 1);
	y2 = p1(i, 2);
	Ax = [x1, y1, 1, 0, 0, 0, -x2*x1, -x2*y1, -x2];
	Ay = [0, 0, 0, x1, y1, 1, -y2*x1, -y2*y1, -y2];
    A2(i.*2-1, :) = Ax;
	A2(i.*2, :) = Ay;
end
[~, ~, V2] = svd(A2);
H2 = reshape(V2(:, end), [3, 3])';
img2to1=warpH(img2, H2);

figure(4)
imshow(img2to1)
fprintf('Homography matrix from h2.jpg to h1.jpg is\n');
H2./H2(3,3)
