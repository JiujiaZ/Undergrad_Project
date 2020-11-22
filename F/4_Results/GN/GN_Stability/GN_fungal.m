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
% col=[0 0.4470 0.7410;
%     0.8500 0.3250 0.0980;
%     0.9290 0.6940 0.1250;
%     0.4940 0.1840 0.5560
%     ];
% Y_axis={'F','C_1','C_2','N'};
% 
% for i=1:1:4
%     subplot(2,2,i)
%     scatter(sim_time{i},sim_data{i},50,'filled','MarkerEdgeColor',col(i,:),...
%               'MarkerFaceColor',col(i,:)) 
%     ylabel(Y_axis{i})
%     xlabel('t')
%     xlim([0,72])
%     set(gca,'FontSize',20)
% 
% end

%% reference model
clear ref
for i=1:1:4
   ref(1,i)=mean(sim_data{i});
   baseline(1,i)=sum((repmat(ref(1,i),size(sim_data{i}))-sim_data{i}).^2);
end
baseline=sum(baseline);

%% GN 
clear GN_iter_res
max_time=1e10;
max_iter=100;
max_res=baseline*1e-2;
sparse_time=[0;3;6;9;10;12;24;36;48;72];
latent_time{1,1}=[3,6,9,10,24,36,48,72];
latent_time{1,2}=[3,6,9,10];
latent_time{1,3}=[3,6,9,12];
latent_time{1,4}=[10];

%%
for i=1:1:1
    mag=0.1;
    newpars=normrnd(params,10.^(ceil(log10(params)-1)+mag))';
    
    [theta,Duration,Iteration,Residual,Termination,Inter_res] = Gauss_newton(...
            sparse_time,y0,sim_data,latent_time,newpars,max_time,max_iter,max_res);
    GN_inter_res{1,i}=Inter_res;
end
% save ('GN_Summary') 
% 
% exit




