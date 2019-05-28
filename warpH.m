function img2 = warpH(img1, H)
[height, width,~]=size(img1);
coner=H*[1,1,1;1,height,1;width,1,1;width,height,1]';
coner(1,:)=coner(1,:)./coner(3,:);
coner(2,:)=coner(2,:)./coner(3,:);
coner=round(coner);

min_x=min(coner(1,:));
max_x=max(coner(1,:));
min_y=min(coner(2,:));
max_y=max(coner(2,:));

wprime=max_x-min_x+1;
hprime=max_y-min_y+1;

[x_loc,y_loc] = meshgrid(min_x:max_x,min_y:max_y);
loc = ones(3,wprime.*hprime);
loc(1,:) = reshape(x_loc,1,wprime.*hprime);
loc(2,:) = reshape(y_loc,1,wprime.*hprime);
loc = H\loc;
loc(1,:)=loc(1,:)./loc(3,:);
loc(2,:)=loc(2,:)./loc(3,:);
loc=round(loc);
x_loc=reshape(loc(1,:), hprime, wprime);
y_loc=reshape(loc(2,:), hprime, wprime);

img2=zeros(hprime,wprime,3);
img2(:,:,1) = interp2(img1(:,:,1), x_loc, y_loc);
img2(:,:,2) = interp2(img1(:,:,2), x_loc, y_loc);
img2(:,:,3) = interp2(img1(:,:,3), x_loc, y_loc);
