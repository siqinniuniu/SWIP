function [col,youp,ind]=createcolormap(data,map,colorlogscale)

%%% S. Pasquet - V17.02.17
% Create colormap
% [col,youp,ind]=createcolormap(data,map,colorlogscale)

if exist('map','var')==0 || isempty(map)==1
    map=colormap;
end
if exist('colorlogscale','var')==0 || isempty(colorlogscale)==1
    colorlogscale=0;
end
% Creation of colormaps
if isempty(data)==1
    col=[];
    youp=[];
    ind=[];
elseif length(data)==1
    col=map(1,:);
    ind=1;
else
    if colorlogscale==0
        youp=linspace(min(data),max(data),size(map,1));
    else
        youp=logspace(log10(min(data)),log10(max(data)),size(map,1));
    end
    youp(1)=min(data);
    youp(end)=max(data);
    col=ones(length(data),3);
    ind=ones(length(data),1);
    for e=1:size(map,1)-1;
        col(data>=youp(e) & data<youp(e+1),:)=...
            repmat(map(e,:),...
            size(col(data>=youp(e) & data<youp(e+1),:),1),1);
        ind(data>=youp(e) & data<youp(e+1))=e;
    end
    col(data==youp(e+1),:)=repmat(map(e+1,:),...
        size(col(data==youp(e+1),:),1),1);
    ind(data==youp(e+1))=e;
end