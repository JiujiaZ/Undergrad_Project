load('GN_Analysis.mat')
load('GN_inter_res_2.mat') %intermediate objective function values
obj_2=GN_inter_res;
load('GN_inter_res_3.mat')
obj_3=GN_inter_res;
%% seperate based on iteration k
clear category
clear x_tick
for i =1:1:4
    category(1,i)=sum(GN_Iter==i);
    x_tick{i}=num2str(i-1);
end
counter=0;
for i=1:1:length(obj_2)
    if length(obj_2{1,i})==3
        counter=counter+1;
        plot_obj2(counter,:)=obj_2{1,i};
    end 
end

counter=0;
for i=1:1:length(obj_3)
    if length(obj_3{1,i})==4
        counter=counter+1;
        plot_obj3(counter,:)=obj_3{1,i};
    end 
end

    
%% process 
plot_2=[];
for i=1:1:length(plot_obj2)
    c=plot_obj2(i,:);
    if (sum(isnan(c))+sum(isinf(c))+sum(c>1000))<1
        plot_2=[plot_2;plot_obj2(i,:)];
    end
end


%% plot
col=[215,25,28;
253,174,97;
44,123,182;
    ]/256;

figure 
ax1=subplot(2,2,[1,3])
histogram('Categories',x_tick,'BinCounts',category,...
    'Normalization','pdf','FaceColor',col(3,:),'EdgeColor',col(3,:),'FaceAlpha',1)
xlabel('Termination Iteration (N)')
ylabel('Relative Frequency')
set(gca,'FontSize',20)
set(ax1,'ActivePositionProperty','outerposition');

ax2=subplot(2,2,2)
scatter(plot_2(:,1),plot_2(:,2),'x','r')
hold
plot([1:1:1000],[1:1:1000],'--','color','k','LineWidth',2)
title('N = 2')
xlabel('$W(\theta^1)$','interpreter','latex')
ylabel('$W(\theta^2)$','interpreter','latex')
set(gca,'FontSize',18)
%set(ax2,'ActivePositionProperty','outerposition');

ax3=subplot(2,2,4)
scatter([1,2,3],plot_obj3(1,1:3),100,'x','r')
hold
plot([1,2,3],plot_obj3(1,1:3),'--','LineWidth',2,'color','r')
scatter([1,2,3],plot_obj3(2,1:3),100,'o','k')
plot([1,2,3],plot_obj3(2,1:3),'--','LineWidth',2,'color','k')
title('N = 3')
ylabel('$W(\theta^k)$','interpreter','latex')
xlabel('$k$','interpreter','latex')
set(gca,'FontSize',18)
%set(ax3,'ActivePositionProperty','outerposition');

%% count the number of obj decrease before algorithm break
count=sum(plot_obj2(:,2)<plot_obj2(:,1))+2;


