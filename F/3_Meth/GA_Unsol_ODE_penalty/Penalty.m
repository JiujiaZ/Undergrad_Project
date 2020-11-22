clear all
clc
close all
% Results:
% Penalty is set as 1e5 since 90% of randomly sampled parameters having
% objective function value less than 1e5.
%%
load('y.mat')   % ode45 gated at 1s, run 10000 times sampling parameters frm U~(0,1), aiming at finding penalty function values when ode is not solvable

%% classify by magnitude: eg 11 is 1e2, 9 is 1e1
clear mag;
for i =1:1:10
    mag(i)=sum(y<10^i);
    if i~=1
        x_tick{i}=['10^{',num2str(i-1),'}'];
    else 
        x_tick{i}='Nan';
    end
end
mag = [mag,0]-[0,mag];
mag = mag(1,1:end-1);

%% plot
col=[215,25,28;
253,174,97;
44,123,182;
    ]/256;
figure (1)
histogram('Categories',x_tick,'BinCounts',mag,...
    'Normalization','pdf','FaceColor',col(3,:),'EdgeColor',col(3,:),'FaceAlpha',1)
set(gca,'FontSize',25)
xlabel('Objective Function Magnitude')
ylabel('Relative Frequency')
pbaspect([1 1 1])

