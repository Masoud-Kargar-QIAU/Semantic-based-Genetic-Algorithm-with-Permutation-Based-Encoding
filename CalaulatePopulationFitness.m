 
function PopulationResult=CalaulatePopulationFitness(SemanticGraph,Population,FileNumber)

PopulationResult=Population;  
Population1=CalculatePopulationCluster(Population,FileNumber);

[~, npop ]=size(Population1);
for i=1:npop
   PopulationResult(i).chromozonefitness=CalculateFitnessPerChromozone(SemanticGraph,Population1(i));
   
end

end



         
     











