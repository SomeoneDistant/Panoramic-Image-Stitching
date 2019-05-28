function img_barrel=barrel(img,value)
img=im2double(img);
[height,width,~]=size(img);
f=width/(2*tan(pi/value));
img_barrel=zeros(height,width);
for i=1:height
for j=1:width
yy=f*tan((j-width/2)/f)+width/2;
xx=(i-height/2)*sqrt((j-width/2)^2+f^2)/f+height/2;
xx=round(xx);
yy=round(yy);
if(xx<1||yy<1||xx>height||yy>width)
continue;
end
img_barrel(i,j,1)=img(xx,yy,1);
img_barrel(i,j,2)=img(xx,yy,2);
img_barrel(i,j,3)=img(xx,yy,3);
end
end
for n=width:-1:1
    if img_barrel(:,n,:)==0
        img_barrel(:,n,:)=[];
    end
end