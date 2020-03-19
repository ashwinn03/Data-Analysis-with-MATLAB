

% loading 6 files from directory
F=dir('/home/cim/pgt/mhac062/Documents/MATLAB/Coursework3_DataAndTemplates/ex4/*.txt');
for i=1:length(F)
    A{i}=textread(F(i).name,'%s')';
end

% creating list of unique words in all 6 files
words=unique([A{1},A{2},A{3},A{4},A{5},A{6}]);
%counting unique words
total=numel(words);
%intializing term frequency
tf=zeros(6,total);

% calculating term frequency and storing in a matrix 
for d=1:6
    doc= strcat('A{',num2str(d),'}') ;
    for i=1:total
        count=0;
        for j=1:length(eval(doc))
            if strcmpi(eval([doc,'{j}']),words{i})
                count=count+1;
            end
        tf(d,i)=count;
        end
    end
end
% calculating (no of docs in corpus / no of docs where term t appear)
idf=6./sum(tf>0,1);
% calculating tf_idf vector
tf_idf=tf.*(log10(idf));
d=pdist(tf_idf,'cosine');
%reshapping the distance in matrix form
q=squareform(d);
%plotting as imagesc
imagesc(q);
colormap('gray');
colorbar;
xticklabels({'RRH','PPea','Cinde','CAFA1','CAFA2','CAFA3'});
yticklabels({'RRH','PPea','Cinde','CAFA1','CAFA2','CAFA3'});
