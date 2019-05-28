clear;
clc;

img_forward=imread('im01.jpg');
% Cylindrical projection
img_forward=barrel(img_forward,6);
for i=2:8
    img_next=imread(['im',sprintf('%02d',i),'.jpg']);
%     Cylindrical projection
    img_next=barrel(img_next,6);
    
    [~, des1, loc1] = sift(img_forward);
    [~, des2, loc2] = sift(img_next);
    [~,match1,match2]=match_sift(des1,loc1,des2,loc2);
    if size(match1,2)<16
        continue
    end
    [H,~]=ransacH(match1,match2,8);
    img_forward=warp_stitch(img_forward,img_next,H,0);
    [height,width,~]=size(img_forward);
    
    for n=height:-1:1
        if img_forward(n,:,:)==0
            img_forward(n,:,:)=[];   
        end
    end
    for n=width:-1:1
        if img_forward(:,n,:)==0
            img_forward(:,n,:)=[];
        end
    end
end
figure(1)
imshow(img_forward)

% % CMU1 Dataset
% 
% img_forward=imread('medium02.jpg');
% % Downsampling
% img_forward=img_forward(1:2:end,1:2:end,:);
% % Cylindrical projection
% img_forward=barrel(img_forward,6);
% for i=[1,3,0,4]
%     img_next=imread(['medium',sprintf('%02d',i),'.jpg']);
% %     Downsampling
%     img_forward=img_forward(1:2:end,1:2:end,:);
% %     Cylindrical projection
%     img_next=barrel(img_next,6);
%     
%     [~, des1, loc1] = sift(img_forward);
%     [~, des2, loc2] = sift(img_next);
%     [~,match1,match2]=match_sift(des1,loc1,des2,loc2);
%     if size(match1,2)<16
%         continue
%     end
%     [H,~]=ransacH(match1,match2,8);
%     img_forward=warp_stitch(img_forward,img_next,H,0);
%     [height,width,~]=size(img_forward);
%     
%     for n=height:-1:1
%         if img_forward(n,:,:)==0
%             img_forward(n,:,:)=[];   
%         end
%     end
%     for n=width:-1:1
%         if img_forward(:,n,:)==0
%             img_forward(:,n,:)=[];
%         end
%     end
% end
% figure(2)
% imshow(img_forward)