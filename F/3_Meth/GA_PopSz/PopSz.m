% addpath('C:\Users\Jiujia\Desktop\2019 Project\Final_Report\Figure_Code\0_Temp\GA_PopSz\PopSz_90')
% addpath('C:\Users\Jiujia\Desktop\2019 Project\Final_Report\Figure_Code\0_Temp\GA_PopSz\PopSz_180')
% keep=0.95;
% for i =1:1:50
%     load(['VaryPopSz_',num2str(i),'.mat'])
%     fit_ness{1,i}=state.Score;
%     min_fit(1,i)=min(state.Score);
%     un_solve(1,i)=sum(state.Score==1e5)+sum(isnan(state.Score))+sum(isinf(state.Score));
%     score=state.Score;
%     if un_solve(1,i)~=0
%         score(find(score==1e5))=0;
%         score = score(~isnan(score));
%         score = score(~isinf(score));
%         score = sort(score,'ascend');
%         score(score==0) = [];
%         ave_fit(1,i)= sum(score(1:floor(length(score)*keep)))/floor(length(score)*keep);
%     else
%         score = sort(score,'ascend');
%         ave_fit(1,i)= sum(score(1:floor(length(score)*keep)))/(floor(length(score)*keep));
%     end
% end
% 
% col=[215,25,28;
% 253,174,97;
% 44,123,182;
%     ]/256;
% 
% figure
% plot(ave_fit(1,:),'-','LineWidth',3,'color',col(1,:))
% hold on
% 
% %%
% keep=0.95;
% for i =1:1:50
%     load(['VaryPopSz_180_',num2str(i),'.mat'])
%     fit_ness{2,i}=state.Score;
%     min_fit(2,i)=min(state.Score);
%     un_solve(2,i)=sum(state.Score==1e5)+sum(isnan(state.Score))+sum(isinf(state.Score));
%     score=state.Score;
%     if un_solve(2,i)~=0
%         score(find(score==1e5))=0;
%         score = score(~isnan(score));
%         score = score(~isinf(score));
%         score = sort(score,'ascend');
%         score(score==0) = [];
%         ave_fit(2,i)= sum(score(1:floor(length(score)*keep)))/floor(length(score)*keep);
%     else
%         score = sort(score,'ascend');
%         ave_fit(2,i)= sum(score(1:floor(length(score)*keep)))/(floor(length(score)*keep));
%     end
% end
% 
% plot(ave_fit(2,:),'-','LineWidth',3,'color',col(2,:))
% 
% %%
% for i =1:1:50
%     load(['VaryPopSz_',num2str(i),'.mat'])
%     fit_ness{3,i}=state.Score;
%     min_fit(3,i)=min(state.Score);
%     un_solve(3,i)=sum(state.Score==1e5)+sum(isnan(state.Score))+sum(isinf(state.Score));
%     score=state.Score;
%     if un_solve(3,i)~=0
%         score(find(score==1e5))=0;
%         score = score(~isnan(score));
%         score = score(~isinf(score));
%         score = sort(score,'ascend');
%         score(score==0) = [];
%         ave_fit(3,i)= sum(score(1:floor(length(score)*keep)))/floor(length(score)*keep);
%     else
%         score = sort(score,'ascend');
%         ave_fit(3,i)= sum(score(1:floor(length(score)*keep)))/(floor(length(score)*keep));
%     end
% end
% 
% plot(ave_fit(3,:),'-','LineWidth',3,'color',col(3,:))
% save Processed_data

%%
load('Processed_data.mat')

%%
figure(1)
plot(ave_fit(1,:),'-','LineWidth',4,'color',col(1,:))
hold on
plot(ave_fit(2,:),'-','LineWidth',4,'color',col(2,:))
plot(ave_fit(3,:),'-','LineWidth',4,'color',col(3,:))
ylabel('Average Objective Function Value')
xlabel('Generation Numbers')
set(gca,'FontSize',25)
legend('N=90','N=180','N=360')
set(gca,'YScale','log')
box off


figure(2)
plot(ave_fit(1,:),'-','LineWidth',4,'color',col(1,:))
hold on
plot(ave_fit(2,:),'-','LineWidth',4,'color',col(2,:))
plot(ave_fit(3,:),'-','LineWidth',4,'color',col(3,:))
ylabel('Average Objective Function Value')
xlabel('Generation Numbers')
set(gca,'FontSize',25)
legend('N=90','N=180','N=360')
box off
xlim([10,50])


