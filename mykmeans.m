

function [c,v]=mykmeans(Data,k)
        
n=length(Data);
c=ones(k,2);
%random points for centroid
q=randi([1 n],1,k);
new=zeros(k,2);
%assigning random centroid 
d=pdist2(Data(q,:),Data,'euclidean');
% taking closest points to centroid
[m i]=min(d,[],1);
v=[Data,i'];
flag='False';
while strcmpi(flag,'False')
   for i=1:k
       % reassigning mean as centroid 
      c(i,:)=mean(v(v(:,3)==i,1:2),1);
   end
   d=pdist2(c,Data,'euclidean');
   [m i]=min(d,[],1);
   %merging data points and clusters
   v=[Data,i'];
   % check for change of centroid for two consecutive iterations
   if new==c
      flag='True';
   end
   new=c;
end
%plotting the clusters 
for i=1:k
   plot(v(v(:,3)==i,1),v(v(:,3)==i,2),'.','color',rand(1,3));
   hold on;   
end
%plotting the centroid
plot(c(:,1),c(:,2),'kd','MarkerFaceColor','r' );
title('K-means clustering');
end





