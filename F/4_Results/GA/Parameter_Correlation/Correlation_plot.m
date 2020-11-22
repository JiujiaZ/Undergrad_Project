clear all
clc
close all
set(0,'DefaultFigureWindowStyle','normal')
set(0,'defaultTextInterpreter','tex')
set(groot,'defaultAxesTickLabelInterpreter','latex'); 
figure (1)
%% for 9 by 9
load('all_pop.mat')
for k=[1,15,30,200]
     figure(k)
params=[1.4*(10^-8);6.4*(10^-3); 3.2*(10^-3);6.6*(10^-2); 6.2*(10^-4);3.4*(10^-4); 0.66;0.40; 6.1*(10^-2)];
VarName={'$\hat{\phi}$','$k_{NF}$','$\tilde{k}_c$' ,'$\delta_{C1}$' ,'$k_{h}$',...
    '$\delta_{C2}$' ,'$\tilde{\alpha}_1$' ,'$\tilde{\alpha}_2$' ,'$\delta_N$'};
H=scatterPlotMatrix(all_pop{k}, VarName,params,{});
%H=scatterPlotMatrix(all_min, VarName,params,{});
% xlim from bottom row
for i=1:1:9
    set(H(9, i), 'xlim',[-0.1,1.1])
    xlabel(H(9,i),VarName{i},'Interpreter','Latex','FontSize',34,'fontweight','bold')
    a = get(H(9, i),'XTickLabel');
    set(H(9, i),'XTickLabel',a,'fontsize',15)
end
% ylim from each subgraph
for i=1:1:9
    for j=1:1:9
        if j<=i
            set(H(i, j), 'ylim',[-0.1,1])
        end
    end
end

for i=1:1:9
    ylabel(H(i,1),VarName{i},'Interpreter','Latex','FontSize',34,'fontweight','bold')
    a = get(H(i, 1),'YTickLabel');
    set(H(i, 1),'YTickLabel',a,'fontsize',15)
end
end

%% for 3 by 3
load('all_pop.mat')
for k=[1,15,30,200]
     
params=[1.4*(10^-8);6.4*(10^-3); 3.2*(10^-3);6.6*(10^-2); 6.2*(10^-4);3.4*(10^-4); 0.66;0.40; 6.1*(10^-2)];
% VarName={'$\hat{\phi}$','$k_{NF}$','$\tilde{k}_c$' ,'$\delta_{C1}$' ,'$k_{h}$',...
%     '$\delta_{C2}$' ,'$\tilde{\alpha}_1$' ,'$\tilde{\alpha}_2$' ,'$\delta_N$'};
VarName={'$\hat{\phi}$','$k_{NF}$','$\tilde{k}_c$'};
H=scatterPlotMatrix3(all_pop{k}(:,1:3), VarName,params,{});
% xlim from bottom row
for i=1:1:3
    set(H(3, i), 'xlim',[-0.1,1.1])
    set(H(3, i),'XTick',[0,0.5,1],'XTickLabel',{'0','0.5','1'},'fontsize',30)
    xlabel(H(3,i),VarName{i},'Interpreter','Latex','FontSize',30)
end
% ylim from each subgraph
for i=1:1:3
    for j=1:1:3
        if j<=i
            set(H(i, j), 'ylim',[-0.1,1])
        end
    end
end
% set title
for i=1:1:3
    ylabel(H(i,1),VarName{i},'Interpreter','Latex','FontSize',30)
    set(H(i, 1),'YTick',[0,0.5,1],'XTickLabel',{'0','0.5','1'},'fontsize',30)
end

end

%% for video 9 by 9
load('all_pop.mat')
for k=[1,15,30,200]
     fif{k}=figure (k)
params=[1.4*(10^-8);6.4*(10^-3); 3.2*(10^-3);6.6*(10^-2); 6.2*(10^-4);3.4*(10^-4); 0.66;0.40; 6.1*(10^-2)];
VarName={'$\hat{\phi}$','$k_{NF}$','$\tilde{k}_c$' ,'$\delta_{C1}$' ,'$k_{h}$',...
    '$\delta_{C2}$' ,'$\tilde{\alpha}_1$' ,'$\tilde{\alpha}_2$' ,'$\delta_N$'};
H=scatterPlotMatrix(all_pop{k}, VarName,params,{});
% xlim from bottom row
for i=1:1:9
    set(H(9, i), 'xlim',[-0.1,1.1])
    xlabel(H(9,i),VarName{i},'Interpreter','Latex','FontSize',34,'fontweight','bold')
    a = get(H(9, i),'XTickLabel');
    set(H(9, i),'XTickLabel',a,'fontsize',15)
end
% ylim from each subgraph
for i=1:1:9
    for j=1:1:9
        if j<=i
            set(H(i, j), 'ylim',[-0.1,1])
        end
    end
end

for i=1:1:9
    ylabel(H(i,1),VarName{i},'Interpreter','Latex','FontSize',34,'fontweight','bold')
    a = get(H(i, 1),'YTickLabel');
    set(H(i, 1),'YTickLabel',a,'fontsize',15)
end
     F(i)=getframe(gcf) 
     name_fig=['fig',num2str(i),'.fig'];
     name_png=['fig',num2str(k),'.png'];
     name_jpg=['fig',num2str(k),'.jpg'];
     print(gcf,name_jpg,'-dpng','-r300')
     set(gcf,'Visible','off')
     savefig(name_fig)
     saveas(gcf,name_png)
     saveas(gcf,name_png)
     close(gcf) 
end

