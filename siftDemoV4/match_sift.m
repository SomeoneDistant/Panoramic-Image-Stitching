function [match,match1,match2]=match_sift(des1,loc1,des2,loc2)
ratio = 0.6;

match=zeros(1,size(des1,1));
des2prime = des2';
for n = 1 : size(des1,1)
   dist = des1(n,:) * des2prime;
   [value,index] = sort(acos(dist));
   if (value(1) < ratio * value(2))
      match(n) = index(1);
   end
end 

match1=[];
match2=[];
for n = 1: size(des1,1)
    if match(n) > 0
    match1=[match1;loc1(n,2),loc1(n,1),1];
    match2=[match2;loc2(match(n),2),loc2(match(n),1),1];
    end
end
match1=match1';
match2=match2';