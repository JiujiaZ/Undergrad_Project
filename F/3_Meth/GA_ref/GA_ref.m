% results: reference objective function value (SSE) = [47.1481204747996]
set(0,'defaultTextInterpreter','tex')
set(groot,'defaultAxesTickLabelInterpreter','tex');

%% original data
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

%%
col=[215,25,28;
253,174,97;
44,123,182;
    ]/256;

Y_axis={'C_1 [ngml^{-1}]','C_2 [ngml^{-1}]','N [10^6 Cells]'};

for i=1:1:3
    subplot(1,3,i)
    scatter(sim_time{i+1},sim_data{i+1},500,'r','x','LineWidth',3) 
    hold on 
    plot([0:1:72],mean(sim_data{i+1})* ones(1,73),'color','k','LineWidth',2.8)
    plot(time,path(:,i+1),'--','color','k','LineWidth',1.8)
    ylabel(Y_axis{i})
    set(gca,'YScale','log')
    set(gca,'FontSize',25)
    xlabel('Time [hour]')
    ylim manual
    xticks([0 36 72])
    pbaspect([4,7,1])

end

%% Calculate reference value
ref=0
for i=2:1:4
    ref=ref+sum((sim_data{i}-mean(sim_data{i})).^2)  
end
