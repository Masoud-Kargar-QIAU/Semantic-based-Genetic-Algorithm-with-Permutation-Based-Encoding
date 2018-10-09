function  popCluster=CalculatePopulationCluster(pop,FileNumber)

field1='chromozone';
value1=zeros(1,FileNumber);
field2='chromozonefitness'; 
value2=zeros(1);
PopCluster=struct(field1,value1,field2,value2);

[~, npop]=size(pop);

popCluster(npop)=PopCluster;
for i=1: npop
   
    x= pop(i).chromozone;
   ClusterStart=1;
     for j=1:FileNumber
         
         if j <= x(j)
              popCluster(i).chromozone(j)= ClusterStart;
              ClusterStart=ClusterStart+1;
         else
           
               popCluster(i).chromozone(j)= popCluster(i).chromozone(x(j));
          end    
     end
end
end

