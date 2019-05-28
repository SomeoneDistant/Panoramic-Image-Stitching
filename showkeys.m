% showkeys(image, locs)
%
% This function displays an image with SIFT keypoints overlayed.
%   Input parameters:
%     image: the file name for the image (grayscale)
%     locs: matrix in which each row gives a keypoint location (row,
%           column, scale, orientation)
function showkeys(image, locs, descriptor)
disp('Drawing SIFT keypoints ...');

% Draw image with keypoints
figure('Position', [50 50 size(image,2) size(image,1)]);
imagesc(image);
hold on;
color='B';
for i = 1: size(locs,1)
    if i==2
        color='Y';
    end
    if i==30
        color='R';
    end
    if locs(i,3)>5
    % Draw an arrow, each line transformed according to keypoint parameters.
    for x=1:5
        TransformLine(locs(i,:), (x-3)./2, 1, 0, -2, color);
    end
    for y=1:5
        TransformLine(locs(i,:), -1, (3-y)./2, 2, 0, color);
    end
    for l=1:4
        for w=1:4
            for a=1:8
                x=(l.*2-5).*0.25;
                y=(5-w.*2).*0.25;
                scale=descriptor(i,l.*w.*a);
                TransformLine(locs(i, :), x, y, cos((a-1).*pi./4) .* scale, sin((a-1).*pi./4) .* scale, color);
            end
        end
    end
    end
    color='Y';
end
hold off;

% ------ Subroutine: TransformLine -------
% Draw the given line in the image, but first translate, rotate, and
% scale according to the keypoint parameters.
%
% Parameters:
%   Arrays:
%    imsize = [rows columns] of image
%    keypoint = [subpixel_row subpixel_column scale orientation]
%
%   Scalars:
%    x1, y1; begining of vector
%    x2, y2; ending of vector
function TransformLine(keypoint, x1, y1, x2, y2, Color)

% The scaling of the unit length arrow is set to approximately the radius
%   of the region used to compute the keypoint descriptor.
len = keypoint(3);

% Rotate the keypoints by 'ori' = keypoint(4)
s = sin(keypoint(4));
c = cos(keypoint(4));

% Apply transform

c1 = keypoint(2) + len * (- s * y1 + c * x1);
r1 = keypoint(1) - len * (c * y1 + s * x1);
r2 = r1 - len * (c * y2 + s * x2);
c2 = c1 + len * (- s * y2 + c * x2);
line([c1 c2], [r1 r2], 'Color', Color);

