% Analyse results for generation number effect

%% baseline objective function value (intrinsic measure)
params=[1.4*(10^-8);6.4*(10^-3); 3.2*(10^-3);6.6*(10^-2); 6.2*(10^-4);3.4*(10^-4); 0.66;0.40; 6.1*(10^-2)];
y0=[30,0,0,0]; %initial condition
tspan = 0:1:72; %for generate data
Tcell{1}=[0]';
Tcell{2}=[0,0,12,24,36,48,72]';
Tcell{3}=[0,0,10,24,36,48,72]';
Tcell{4}=[0,0,3,6,9,12,12,12,24,24,36,36,48,48,72]';
path_cell{1}=[30]';
path_cell{2}=[0,0,0.06,1.75,0.5,0.5,0.1]';
path_cell{3}=[0.1,0.25,0.45,0.75,0.45,0.5,0.25]';
path_cell{4}=[0,3.375*10^-3, 8*10^-2,0.75, 0.7,1,3.8, 6,4,1,7,4.7,6.25,1,7.5]';
% Solve 
[time,path] = ode45(@(t,x)FModelode(t,x,params),tspan,y0);
% Synthetis Data
for i =1:1:4
    sim_time{i} = time(unique(Tcell{i})+1)';
    sim_data{i} = path(unique(Tcell{i})+1,i)';
end

% Baseline model value
for i =1:1:4
    basevalue(1,i)=mean(sim_data{i});
end

% Baseline objective function value
for i =1:1:4
    base_obj(1,i)=sum((sim_data{i}-basevalue(1,i)).^2)/sum(basevalue(1,i));
end
base_obj=sum(base_obj);

%% Nominal parameter values
col=[0 0.4470 0.7410;
    0.8500 0.3250 0.0980;
    0.9290 0.6940 0.1250;
    0.4940 0.1840 0.5560;
    0.4660 0.6740 0.1880;
    0.3010 0.7450 0.9330;
    0.6350 0.0780 0.1840;
    0 0.75 0.75;
    0, 0.5, 0;
    ];
Y_axis={'F [10^6 Cells]','C_1 [ng ml^{-1}]','C_2 [ng ml^{-1}]','N [10^6 Cells]'};

for i=1:1:4
    subplot(2,2,i)
    scatter(Tcell{i},path_cell{i},50,'filled','MarkerEdgeColor',col(i,:),...
              'MarkerFaceColor',col(i,:)) 
    hold 
    plot(time,path(:,i),'color',col(i,:),'LineWidth',2)
    ylabel(Y_axis{i})
    xlabel('time [h]')
    xlim([0,72])
    set(gca,'YScale','log')
    set(gca,'FontSize',20)
    legend('Experimental data', 'Simulated data')

end

%% plot baseline model
col=[0 0.4470 0.7410;
    0.8500 0.3250 0.0980;
    0.9290 0.6940 0.1250;
    0.4940 0.1840 0.5560;
    0.4660 0.6740 0.1880;
    0.3010 0.7450 0.9330;
    0.6350 0.0780 0.1840;
    0 0.75 0.75;
    0, 0.5, 0;
    ];
Y_axis={'F [10^6 Cells]','C_1 [ng ml^{-1}]','C_2 [ng ml^{-1}]','N [10^6 Cells]'};

for i=1:1:4
    subplot(2,2,i)
    scatter(sim_time{i},sim_data{i},50,'filled','MarkerEdgeColor',col(i,:),...
              'MarkerFaceColor',col(i,:)) 
    hold 
    %yline(basevalue(1,i),'col',col(i,:),'LineWidth',2);
    ylabel(Y_axis{i})
    xlabel('time [h]')
    xlim([0,72])
    set(gca,'FontSize',20)
    %legend('Synthetic data', 'Mean')

end

%% load results
addpath('varyGen') 
for i = 1:1:9

   load(['fval_',num2str(i, '%i'),'.mat'])
   load(['runTime_',num2str(i, '%i'),'.mat'])
   load(['theta_',num2str(i,'%i'),'.mat'])
   load(['scores_',num2str(i,'%i'),'.mat'])
   load(['population_',num2str(i,'%i'),'.mat'])
   
   T(1,i)=runTime;
   best_score(1,i)=fval;
   best_theta(i,:)=theta;
   all_scores{1,i}=scores;
   all_pop{1,i}=population;
   
   clear runTime;
   clear fval;
   clear theta;
   clear scores;
   clear population;
end

%% plot best score, run time for diff generation number using best value
MaxGen=[1,2,4,8,16,32,64,128,256];
figure(1)
subplot(3,1,1)
plot(MaxGen,best_score,'-o','LineWidth',2)
hold
yline(base_obj,'-.r','Reference','LabelHorizontalAlignment', 'center','LineWidth',1)
xlim([0,256])
set(gca, 'FontSize', 20)
subplot(3,1,2)
plot(MaxGen,best_score,'-o','LineWidth',2)
hold
yline(base_obj,'-.r','Reference','LabelHorizontalAlignment', 'center','LineWidth',1)
ylim([0,10e7])
xlim([0,256])
set(gca,'YScale','log')
ylabel('Min Objective Function')
set(gca, 'FontSize', 20)

subplot(3,1,3)
plot(MaxGen,T,'-o','LineWidth',2)
xlim([0,256])
xlabel('Generation Number')
ylabel('Run Time (s)')
set(gca, 'FontSize', 20)

%%
g=[];
for i=1:1:9
    g=[g;repmat({num2str(MaxGen(1,i))},180,1)];
end
    
boxplot([all_scores{1},all_scores{2},all_scores{3},all_scores{4},...
    all_scores{5},all_scores{6},all_scores{7},all_scores{8},all_scores{9}],g,'symbol','')
ylim([0,35000])
set(gca,'YScale','log')
set(findobj(gca,'type','line'),'linew',2)
yline(base_obj,'-.r','Reference','LabelHorizontalAlignment', 'center','LineWidth',1)
xlabel('Generation Number')
ylabel('Objective Function Values')
set(gca, 'FontSize', 25)
%% Now look at parameters in each generation
for i =1 :1 :9
   [time_est{i},path_est{i}] = ode45(@(t,x)FModelode(t,x,best_theta(i,:)),tspan,y0); 
end
alpha_vector=[0.1:((1-0.1)/8):1];
for i=1:1:4
    subplot(2,2,i)
    scatter(sim_time{i},sim_data{i},50,'filled','MarkerEdgeColor',col(i,:),...
              'MarkerFaceColor',col(i,:)) 
    hold on
    for j=1:1:9
    plot(time_est{j},path_est{j}(:,i),'LineWidth',2,'Color',[col(i,:),alpha_vector(1,j)])
    end
    ylabel(Y_axis{i})
    xlabel('time [h]')
    xlim([0,72])
    set(gca,'FontSize',20)

end
%% parameters in each generation in volume plot
z1=[];
z2=[];
z3=[];
z4=[];
for i=1:1:9
    z1=[z1,path_est{i}(:,1)];
    z2=[z2,path_est{i}(:,2)];
    z3=[z3,path_est{i}(:,3)];
    z4=[z4,path_est{i}(:,4)];
end
z{1}=z1;
z{2}=z2;
z{3}=z3;
z{4}=z4;
y=repmat(time_est{1},1,9);
x=repmat(MaxGen,73,1);
for i=1:1:4
    subplot(2,2,i)
    plot3(x,y,z{i},'color',[col(i,:)],'LineWidth',1)
    view([115,30])
    xlabel('Generation')
    ylabel('Time (h)')
    zlabel(Y_axis{i})
    set(gca,'FontSize',15)
end

%% check hist plot 
hist(all_pop{1,9}(:,9))