function crosspop=GenerateCrossover(pop,npop,ncross,FileNumber)

field1='chromozone';
value1=zeros(1,FileNumber);
field2='chromozonefitness'; 
value2=zeros(1);
CrossPop=struct(field1,value1,field2,value2);

crosspop(ncross)=CrossPop;

for i=1:2:ncross
 
    index1=randi([1,npop],1,1);
    CrossPop1=pop(index1);
    index2=randi([1,npop],1,1);
    CrossPop2=pop(index2);
      
    
    c1=CrossPop1.chromozone;
    c2=CrossPop2.chromozone;
    [~,ClusterNumber1]=size(unique(CrossPop1.chromozone));
    [~,ClusterNumber2]=size(unique(CrossPop2.chromozone));
    MinClusterNumber=min(ClusterNumber1,ClusterNumber2);
    
    [crosspop(i).chromozone, crosspop(i+1).chromozone] = PerformCrossover( c1, c2 ,MinClusterNumber);
  
end

end

