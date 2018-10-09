function [ InternalLinkSum ,ExtenalLinkSum ] = SumExternaInternallLink(GraphMatrix ,SubGraphMatrixIndex)
G1=GraphMatrix(SubGraphMatrixIndex,SubGraphMatrixIndex);
InternalLinkSum=sum(G1(:));
InternalLinkSum = InternalLinkSum/2;
GraphMatrix(SubGraphMatrixIndex,SubGraphMatrixIndex)=0;
G2=GraphMatrix(SubGraphMatrixIndex,:);
ExtenalLinkSum=sum(G2(:));
end

