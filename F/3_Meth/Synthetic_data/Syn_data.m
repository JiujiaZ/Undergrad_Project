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
subplot(1,3,1)
scatter(sim_time{2},sim_data{2},500,'r','x','LineWidth',3)
hold
plot(time,path(:,2),'--','color','k','LineWidth',1.8)
set(gca,'YScale','log')
set(gca,'FontSize',25)
ylabel('C_1 [ngml^{-1}]')
xlabel('Time [hour]')
ylim manual
xticks([0 36 72])
pbaspect([4,7,1])
subplot(1,3,2)
scatter(sim_time{3},sim_data{3},500,'r','x','LineWidth',3)
hold
plot(time,path(:,3),'--','color','k','LineWidth',1.8)
set(gca,'YScale','log')
set(gca,'FontSize',25)
ylabel('C_2 [ngml^{-1}]')
xlabel('Time [hour]')
ylim manual
xticks([0 36 72])
pbaspect([4,7,1])
subplot(1,3,3)
scatter(sim_time{4},sim_data{4},500,'r','x','LineWidth',3)
hold
plot(time,path(:,4),'--','color','k','LineWidth',1.8)
set(gca,'YScale','log')
set(gca,'FontSize',25)
ylabel('N [10^6 Cells]')
xlabel('Time [hour]')
xticks([0 36 72])
ylim manual
pbaspect([4,7,1])




%%
function dx = FModelode(t,x,newpars)
    dx = [newpars(1)*x(1)-newpars(2)*x(4)*x(1);
          newpars(3)*x(1)- newpars(4)*x(2);
          newpars(5)*x(1)- newpars(6)*x(3);
          newpars(7)*x(2)+newpars(8)*x(3)-newpars(2)*x(4)*x(1)-newpars(9)*x(4); 
          ];
end

