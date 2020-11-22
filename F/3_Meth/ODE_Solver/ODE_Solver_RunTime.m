clear all
close all
clc
% This script is for justifying ODE solver maximum running time for each
% set of parameters in the optimisation algorithm
%%
% params=[1.4*(10^-8);6.4*(10^-3); 3.2*(10^-3);6.6*(10^-2); 6.2*(10^-4);3.4*(10^-4); 0.66;0.40; 6.1*(10^-2)];
% y0=[30,0,0,0]; 
% tspan = 0:1:72; 
% time_log=zeros(1,10000);
% for i = 1:1:10000
%     tic;
%     [time,path] = ode45(@(t,x)FModelode(t,x,params),tspan,y0);
%     time_log(1,i)=toc;
% end
%% plot
load('time_log.mat')
col=[215,25,28;
253,174,97;
44,123,182;
    ]/256;
A = rmoutliers(time_log,'percentiles',[0,99.9]);
mu=mean(time_log);
histogram(A,...
    'Normalization','probability','FaceColor',col(3,:),'EdgeColor',col(3,:),'FaceAlpha',1)
hold on 
xline(mu,'--','LineWidth',2,'color',col(1,:))

set(gca,'FontSize',25)
xlabel('Run Time (s)')
ylabel('Relative Frequency')
range=[min(time_log),max(time_log)]
pbaspect([1 1 1])






%%
function dx = FModelode(t,x,newpars)
    dx = [newpars(1)*x(1)-newpars(2)*x(4)*x(1);
          newpars(3)*x(1)- newpars(4)*x(2);
          newpars(5)*x(1)- newpars(6)*x(3);
          newpars(7)*x(2)+newpars(8)*x(3)-newpars(2)*x(4)*x(1)-newpars(9)*x(4); 
          ];
end