function img12=warp_stitch(img1,img2,H2to1,option)

[height, width,~]=size(img1);

[x_loc,y_loc] = meshgrid(1:width,1:height);
loc = ones(3,height*width);
loc(1,:) = reshape(x_loc,1,height*width);
loc(2,:) = reshape(y_loc,1,height*width);
img2_loc = H2to1*loc;
img2_loc(1,:)=img2_loc(1,:)./img2_loc(3,:);
img2_loc(2,:)=img2_loc(2,:)./img2_loc(3,:);
img2_loc=round(img2_loc);

min_x=min([1,img2_loc(1,:)]);
max_x=max([width,img2_loc(1,:)]);
min_y=min([1,img2_loc(2,:)]);
max_y=max([height,img2_loc(2,:)]);

wprime=max_x-min_x+1;
hprime=max_y-min_y+1;

[x_locprime,y_locprime] = meshgrid(min_x:max_x,min_y:max_y);
locprime = ones(3,wprime.*hprime);
locprime(1,:) = reshape(x_locprime,1,wprime.*hprime);
locprime(2,:) = reshape(y_locprime,1,wprime.*hprime);
img2_locprime = H2to1\locprime;
img2_locprime(1,:)=img2_locprime(1,:)./img2_locprime(3,:);
img2_locprime(2,:)=img2_locprime(2,:)./img2_locprime(3,:);
img2_locprime=round(img2_locprime);
x_locprime=reshape(img2_locprime(1,:), hprime, wprime);
y_locprime=reshape(img2_locprime(2,:), hprime, wprime);

img12=zeros(hprime,wprime,3);
img12(:,:,1) = interp2(img2(:,:,1), x_locprime, y_locprime);
img12(:,:,2) = interp2(img2(:,:,2), x_locprime, y_locprime);
img12(:,:,3) = interp2(img2(:,:,3), x_locprime, y_locprime);
img12(isnan(img12))=0;

img1_loc=loc;
if min_x<1
    img1_loc(1,:)=loc(1,:)-min_x+1;
end
if min_y<1
    img1_loc(2,:)=loc(2,:)-min_y+1;
end

img1(isnan(img1))=0;
img12(isnan(img12))=0;
for n=1:width*height
    if option
        dup=and(img12(img1_loc(2,n),img1_loc(1,n),:),img1(loc(2,n),loc(1,n),:));
        img12(img1_loc(2,n),img1_loc(1,n),:)=(img12(img1_loc(2,n),img1_loc(1,n),:)+img1(loc(2,n),loc(1,n),:))./(dup+1);
    elseif img12(img1_loc(2,n),img1_loc(1,n),:)==0
        img12(img1_loc(2,n),img1_loc(1,n),:)=img1(loc(2,n),loc(1,n),:);
    end
end