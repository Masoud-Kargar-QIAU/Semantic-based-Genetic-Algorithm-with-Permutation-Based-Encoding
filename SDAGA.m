clear
close all


%% set Parameters

load('D:\Mozilla\accessible\data\accessible');
ClusterNumber=179;

maxiter=3000;      % max of iteration
ConstIteration=100;

npop=300;
ncross=100;
nmut=500;

OutputNumber=7;
DirName='d:\Mozilla\accessible\output\';
OutputMoJo=strcat(DirName,'MoJo\Mozilla_accessible_SDAGA_',num2str(OutputNumber),'.rsf');
OutputPreRecall=strcat(DirName,'PreRecall\BestPop_SDAGA_',num2str(OutputNumber));

FigureDir=strcat(DirName,'Figure\SDAGA\',num2str(OutputNumber));
mkdir(FigureDir);

%% initialization

BEST=zeros(maxiter,1);
MEAN=zeros(maxiter,1);
ClusterValue=zeros(maxiter,ClusterNumber);

field1='chromozone';
value1=zeros(1,FileNumber);
field2='chromozonefitness'; 
value2=zeros(1);


pop=struct(field1,value1,field2,value2);
crosspop=struct(field1,value1,field2,value2);
mutpop=struct(field1,value1,field2,value2);
gpop=struct(field1,value1,field2,value2);
%% create population 
pop=CreatePopulation(npop,FileNumber);
pop=CalaulatePopulationFitness(SemanticGraph,pop,FileNumber);

%% main loop


for iter=1:maxiter
    % crossover
   crosspop=GenerateCrossover(pop,npop,ncross,FileNumber);
   % mutation
   mutpop=GenerateMutation(pop,npop,nmut,FileNumber);
   % merged
  [popcrossmut]=[crosspop,mutpop];
  
%    popcrossmut=CalculatePopulationCluster(popcrossmut,FileNumber);
   popcrossmut=CalaulatePopulationFitness(SemanticGraph,popcrossmut,FileNumber);
   [pop]=[pop,popcrossmut];
  
  
  [~ ,k]=size(pop);
  for i=1:k
     if isnan(pop(i).chromozonefitness)
        pop(i).chromozonefitness=-10000000;
     end
  end
  
  % select
  [value,index]=sort([pop.chromozonefitness] , 'descend');
  pop=pop(index);
  pop=pop(1:npop);


  if ~isnan(pop(1).chromozonefitness)
      gpop=pop(1);   % Best pop
  else
      break;
  end

 BEST(iter)=gpop.chromozonefitness;
 MEAN(iter)=mean([pop.chromozonefitness]);


 disp([ ' Iter = '  num2str(iter)  ' BEST = '  num2str(BEST(iter))]);
  if iter>ConstIteration && BEST(iter)==BEST(iter-ConstIteration)
      break
 end

end
%% results
save(OutputPreRecall,'gpop'); 

%%
%%create mojo file 
 
 fileID=fopen(OutputMoJo,'w');
 for i=1 :FileNumber
     d= gpop.chromozone(i);
  fprintf(fileID,'contain %d    %s \r\n',d ,FileNames{i});   
 end
fclose(fileID);

%%

[~,ClusterNumber]=size(unique(gpop.chromozone));



disp(' ')
disp([ ' Best par = '  num2str(gpop.chromozone)])
disp([ ' Best fitness = '  num2str(gpop.chromozonefitness)])
disp([ ' Cluster Number = '  num2str(ClusterNumber)])

FileName=char(strcat(FigureDir,'\BestChromozone.txt'));
v1=gpop.chromozone;
v2=gpop.chromozonefitness;
v3=ClusterNumber;
save(FileName,'v1','v2','ClusterNumber','-ascii'); 

% % % 
% % % h=figure(1);
% % % plot(BEST(1:iter),'r','LineWidth',2)
% % % hold on
% % % plot(MEAN(1:iter),'b','LineWidth',2)
% % % 
% % % xlabel('Iteration')
% % % ylabel(' Fitness')
% % % legend('BEST','MEAN')
% % % title('GA for Dependency Analysis')
% % % 
% % % FileName=char(strcat(FigureDir,'\ClusterBest'));
% % % saveas(h,FileName,'jpg');
% % % set(h, 'Visible', 'off');
% % % 
% % % 
% % % Color1=rand(ClusterNumber,3);
% % % 
% % % for i=1:ClusterNumber
% % % h1=figure('visible','off');
% % % 
% % % 
% % % plot(ClusterValue(1:iter,i),'Color', Color1(i,:),'LineWidth',1)
% % % hold on
% % % xlabel('Iteration')
% % % ylabel(' Cluster number')
% % % 
% % % legend(strcat('Cluster', num2str(i)))
% % % 
% % % 
% % % title('Cluster number in GA for Dependency Analysis')
% % % 
% % % FileName=char(strcat(FigureDir,'\Cluster',num2str(i)));
% % % saveas(h1,FileName,'jpg');
% % % clear Ids;
% % % clear Adj;
% % % [Adj,Ids]=NewShowFileIndexCount(SemanticGraph, FileNames,gpop.chromozone ,i);
% % % f= BioGraphViewer (Adj,Ids);
% % % FileName1=char(strcat(FigureDir,'\ClusterIn',num2str(i),'.jpg'));
% % % print(f, '-djpeg', FileName1);
% % % end