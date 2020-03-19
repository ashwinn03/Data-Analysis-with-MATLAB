%loading of sample dataset
S=load('pcadata.mat');
x=S.X;
%plotting of data points as  blue circles 
plot(x(:,1),x(:,2),'bo');
xlim([0 7]);
ylim([2 8]);
title('Datapoins and their 2 principal components');
xlabel('Figure A');
hold on;
%subtracting mean from the dataset
function [Xmu,mu]=subtractMean(X)
mu=mean(X);
Xmu=X-mu;
end

[Xmu,mu]=subtractMean(x);
%calculating eigen vectors and eigen values

function [P,V]=myPCA(X)
[v d]=eig(cov(X));
[o p]=sort(diag(d),'desc');
P=v(:,p');
V=o;
end
[U,S]=myPCA(Xmu);
% drawing PC1 and PC2 after adding mean
line ([mu(1),mu(1)+U(1,1)'],[mu(2),mu(2)+U(2,1)'],'color', 'r' ,'LineWidth', 2);
line ([mu(1),mu(1)+U(1,2)'],[mu(2),mu(2)+U(2,2)'],'color', 'b' ,'LineWidth', 2);
% projection of input dataset on eigen vectors
function Z = projectData(X, U, K)
Z=X*U(:,1:K);
end
Z = projectData(Xmu,U,1);
%printing first three points of projection dataset
disp(Z(1:3,:));
%recovering databack to original space
function X_rec = recoverData(Z, U, K, mu)
	X_rec = Z * U(:,1:K)' + repmat(mu, size(Z, 1), 1);
end

Xrec=recoverData(Z,U,1,mu);

%plotting datapoints again for showing recovered datapoints
figure();
plot(x(:,1),x(:,2),'bo');
xlim([0 7]);
ylim([2 8]);
hold on;
%projecting points on original dataset
plot(Xrec(:,1),Xrec(:,2),'r*');
title('Datapoints and their reconstruction');
xlabel('Figure B');

%----------------------------- PART 2  ----------------------------------

%loading faces dataset
y=load('//home/cim/pgt/mhac062/Documents/MATLAB/Coursework3_DataAndTemplates/ex5/pcafaces.mat');
X=y.X;
figure();
xlabel('figure C');
%displaying first 100 faces
displayData(X(1:100,:));

% following same steps as part 1 for first 200 eigen vectors
[Xmu,mu]=subtractMean(X);
[U,S]=myPCA(X);
Z = projectData(Xmu,U,200);
Xrec=recoverData(Z,U,200,mu);

%creating subplot to show original vs recovered image
figure()
for i=1:2
    subplot(1,2,i);
    xlabel('Figure D')
    if i==1
        displayData(X(1:100,:));
        title('Original faces');
    else
         displayData(Xrec(1:100,:));
         title('Recovered faces');
    end   
end

    

