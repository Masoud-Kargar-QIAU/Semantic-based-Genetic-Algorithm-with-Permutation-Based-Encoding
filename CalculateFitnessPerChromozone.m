function Fitness=CalculateFitnessPerChromozone(SemanticGraph,PopMember)


pp=unique(PopMember.chromozone);
[~,ClusterNumber]=size(pp);

a=zeros(1,ClusterNumber);

for i= 1:ClusterNumber
              ClusterIndex1=find(PopMember.chromozone==pp(i));
              a(i)=CalculateTuboMCE(SemanticGraph,  ClusterIndex1 );

end
PopMember.chromozonefitness=mean(a);
Fitness=PopMember.chromozonefitness;

end

