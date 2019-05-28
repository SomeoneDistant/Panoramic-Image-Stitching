clear;
clc;

img_forward=im2double(imread('im02.jpg'));
% Downsampling
% img_forward=img_forward(1:2:end,1:2:end,:);
for i=[3, 1]
    img_next=im2double(imread(['im', sprintf('%02d', i), '.jpg']));
%     Downsampling
%     img_next=img_next(1:2:end,1:2:end,:);

    [~, des1, loc1] = sift(img_forward);
    [~, des2, loc2] = sift(img_next);
    [~, match1, match2]=match_sift(des1, loc1, des2, loc2);

    if size(match1,2)<16
        continue
    end
    [H,~]=ransacH(match1, match2, 8);
    img_forward=warp_stitch(img_forward, img_next, H, 0);
    [height, width, ~]=size(img_forward);

    for n=height:-1:1
        if img_forward(n, :, :)==0
            img_forward(n, :, :)=[];
        end
    end
    for n=width:-1:1
        if img_forward(:,n,:)==0
            img_forward(:,n,:)=[];
        end
    end
end
imshow(img_forward)
