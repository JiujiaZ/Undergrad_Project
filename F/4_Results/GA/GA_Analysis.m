addpath('C:\Users\Jiujia\Desktop\2019 Project\Final_Report\Figure_Code\3_Results\GA\GA_Cons')
time=[];
keep=0.95;
for i =1:1:200
    load(['GA_Final_',num2str(i),'.mat'])
    time=[time,state.end];
    fit_ness{1,i}=state.Score;
    min_fit(1,i)=min(state.Score);
    un_solve(1,i)=sum(state.Score==1e5)+sum(isnan(state.Score))+sum(isinf(state.Score));
    score=state.Score;
    if un_solve(1,i)~=0
        score(find(score==1e5))=0;
        score = score(~isnan(score));
        score = score(~isinf(score));
        score = sort(score,'ascend');
        score(score==0) = [];
        ave_fit(1,i)= sum(score(1:floor(length(score)*keep)))/floor(length(score)*keep);
    else
        score = sort(score,'ascend');
        ave_fit(1,i)= sum(score(1:floor(length(score)*keep)))/(floor(length(score)*keep));
    end
    
    min_par{i}= state.Population(find(state.Score==min(state.Score)),:);
    all_pop{i}=state.Population;
end 
% each_round=[time,0]-[0,time];
% each_round=each_round(1,1:end-1);
each_round=time;

%% plot for objective function 
col=[215,25,28;
253,174,97;
44,123,182;
    ]/256;
ref=47.1481204747996;
figure(1)
subplot(2,1,1)
plot([1:1:200],ave_fit,'-','LineWidth',3,'color',col(3,:))
hold 
plot([1:1:200],min_fit,'-','LineWidth',3,'color',col(2,:))
yline(ref,'--','LineWidth',3,'color',col(1,:))
legend('Average','Minimum','Reference')
ylabel('Objective Function')
xlabel('Generation Numbers')
set(gca,'FontSize',25)
set(gca,'YScale','log')
box off
subplot(2,1,2)
plot([1:1:200],each_round,'-','LineWidth',3,'color',col(3,:))
ylabel('Run Time (s)')
xlabel('Generation Numbers')
set(gca,'FontSize',25)
set(gca,'YScale','log')
box off

%% data for model simulation plot
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

%% plot model simulation trace: surface plot
col=[215,25,28;
253,174,97;
44,123,182;
    ]/256;
z1=[];
z2=[];
z3=[];
z4=[];

for i=1:1:200
    params=min_par{i}(1,:);
    [time,sim_path] = ode45(@(t,x)FModelode(t,x,params),tspan,y0);
    z1=[z1,sim_path(:,1)];
    z2=[z2,sim_path(:,2)];
    z3=[z3,sim_path(:,3)];
    z4=[z4,sim_path(:,4)];
end
% remove=1e-6;
% z1(find(z1<=remove))=0;
% z2(find(z2<=remove))=0;
% z3(find(z3<=remove))=0;
% z4(find(z4<=remove))=0;
z{1}=z1;
z{2}=z2;
z{3}=z3;
z{4}=z4;
y=repmat(time,1,200);
x=repmat([1:1:200],73,1);
cmap=jet(200);
Y_axis={'F [10^6 Cells]','C_1 [ng ml^{-1}]','C_2 [ng ml^{-1}]','N [10^6 Cells]'};
for i=1:1:4
    subplot(2,2,i)
    mesh(x,y,z{i},'FaceColor','interp')
    view([115,30])
    xlabel('Generation')
    ylabel('Time (h)')
    zlabel(Y_axis{i})
    set(gca,'FontSize',15)
end
% hp_t = get(subplot(2, 2, 2),'Position')
% hp_b = get(subplot(2, 2, 4),'Position')
% 
% c=colorbar;
% c.Position=[hp_b(1)+hp_b(3)+0.05 hp_b(2)  0.01  hp_t(2)+hp_t(4)-hp_b(2)];
% c.YTick=[0:0.25:1];
% c.YTickLabel={'-1','-0.5','0','0.5','1'};
% c.Label.String='R'
% c.Label.FontSize=20
% c.Label.Position=[2.9,0.6,0];
% c.Label.Rotation=0;
% c.FontSize=10;
% colormap(cmap)


% figure(2)
% subplot(1,3,1)
% scatter(sim_time{2},sim_data{2},500,'r','x','LineWidth',3)
% hold
% plot(time,sim_path(:,2),'--','color','k','LineWidth',1.8)
% %set(gca,'YScale','log')
% set(gca,'FontSize',25)
% ylabel('C_1 [ngml^{-1}]')
% xlabel('Time [hour]')
% ylim manual
% xticks([0 36 72])
% pbaspect([4,7,1])
% subplot(1,3,2)
% scatter(sim_time{3},sim_data{3},500,'r','x','LineWidth',3)
% hold
% plot(time,sim_path(:,3),'--','color','k','LineWidth',1.8)
% %set(gca,'YScale','log')
% set(gca,'FontSize',25)
% ylabel('C_2 [ngml^{-1}]')
% xlabel('Time [hour]')
% ylim manual
% xticks([0 36 72])
% pbaspect([4,7,1])
% subplot(1,3,3)
% scatter(sim_time{4},sim_data{4},500,'r','x','LineWidth',3)
% hold
% plot(time,sim_path(:,4),'--','color','k','LineWidth',1.8)
% %set(gca,'YScale','log')
% set(gca,'FontSize',25)
% ylabel('N [10^6 Cells]')
% xlabel('Time [hour]')
% xticks([0 36 72])
% ylim manual
% pbaspect([4,7,1])

%% plot model simulation trace: overlaied with synthetic data


alpha_vector=[0.3:((1-0.3)/199):1];
for i=2:1:4
    subplot(1,3,i-1)
    scatter(sim_time{i},sim_data{i},500,'r','x','LineWidth',3) 
    hold on
    plot(time,path(:,i),'color',[0,0,0,0])
    set(gca,'YScale','log')
    y_lim=get(gca,'ylim');
    for j=1:1:200
        plot(time,z{i}(:,j),'LineWidth',2,'Color',[[0,0,0],alpha_vector(1,j)])
    end
    hold off
    
    ylabel(Y_axis{i})
    xlabel('time [h]')
    xlim([0,72])
    set(gca,'FontSize',20)
    
    xticks([0 36 72])
    pbaspect([4,7,1])
    set(gca,'YScale','log')
    set(gca,'FontSize',25)
    tem=get(gca,'ylim');
    ylim([y_lim(1),tem(2)])

end


%% calculate MSE for each state variables
for i =1:1:4
    selected{i} = z{i}(unique(Tcell{i})+1,:)';
end

for i=1:1:4
   MSE(:,i)= sum((selected{i}-repmat(sim_data{i},200,1)).^2,2)
end
 figure
for i=2:1:4
   plot([1:1:200],MSE(:,i),'LineWidth',5,'color',col(i-1,:))
   hold on
end
set(gca,'YScale','log')
ylabel('Sum Squared Error')
xlabel('Generations')
legend('C_1','C_2','N')
set(gca,'FontSize',25)

%% check did the best performing parameters vary (did the algorithm successfully escape from local minimum)

for i=1:1:200
    all_min(i,:)=min_par{i}(1,:);
end
VarName={'$\hat{\phi}$','$k_{NF}$','$\tilde{k}_c$' ,'$\delta_{C1}$' ,'$k_{h}$',...
    '$\delta_{C2}$' ,'$\tilde{\alpha}_1$' ,'$\tilde{\alpha}_2$' ,'$\delta_N$'};
params=[1.4*(10^-8);6.4*(10^-3); 3.2*(10^-3);6.6*(10^-2); 6.2*(10^-4);3.4*(10^-4); 0.66;0.40; 6.1*(10^-2)];

H=scatterPlotMatrix(all_min, VarName, params,{})

% xlim from bottom row
for i=1:1:9
    set(H(9, i), 'xlim',[-0.1,1.1])
end
% ylim from each subgraph
for i=1:1:9
    for j=1:1:9
        if j<=i
            set(H(i, j), 'ylim',[-0.1,1])
        end
    end
end

F(i)=getframe(gcf) 
     name_fig=['GA_best.fig'];
     name_png=['GA_best.png'];
     name_jpg=['GA_best.jpg'];
     print(gcf,name_jpg,'-dpng','-r300')
     set(gcf,'Visible','off')
     savefig(name_fig)
     saveas(gcf,name_png)
     saveas(gcf,name_png)
     close(gcf) 
%%
function dx = FModelode(t,x,newpars)
    dx = [newpars(1)*x(1)-newpars(2)*x(4)*x(1);
          newpars(3)*x(1)- newpars(4)*x(2);
          newpars(5)*x(1)- newpars(6)*x(3);
          newpars(7)*x(2)+newpars(8)*x(3)-newpars(2)*x(4)*x(1)-newpars(9)*x(4); 
          ];
end

