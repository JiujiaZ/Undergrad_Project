%% all data: F C_1 C_2 N
Tcell{1}=[0]';
Tcell{2}=[0,0,12,24,36,48,72]';
Tcell{3}=[0,0,10,24,36,48,72]';
Tcell{4}=[0,0,3,6,9,12,12,12,24,24,36,36,48,48,72]';
path_cell{1}=[30]';
path_cell{2}=[0,0,0.06,1.75,0.5,0.5,0.1]';
path_cell{3}=[0.1,0.25,0.45,0.75,0.45,0.5,0.25]';
path_cell{4}=[0,3.375*10^-3, 8*10^-2,0.75, 0.7,1,3.8, 6,4,1,7,4.7,6.25,1,7.5]';

%% data splot group
t_21=[0,12,36];
t_22=[0,24,46,72];
x_21=[0,0.06,0.5];
x_22=[0,1.75,0.5,0.1];

xx_21=linspace(t_21(1),t_21(end),t_21(end));
yy_21=interp1(t_21,x_21,xx_21,'cubic');
xx_22=linspace(t_22(1),t_22(end),t_22(end));
yy_22=interp1(t_22,x_22,xx_22,'cubic');


t_31=[0,10,36];
t_32=[0,24,48,72];
x_31=[0.1,0.45,0.45];
x_32=[0.25,0.75,0.5,0.25];

xx_31=linspace(t_31(1),t_31(end),t_31(end));
yy_31=interp1(t_31,x_31,xx_31,'cubic');
xx_32=linspace(t_32(1),t_32(end),t_32(end));
yy_32=interp1(t_32,x_32,xx_32,'cubic');

t_41=[24,48];
t_42=[0,3,6,9,12,24,48];
t_43=[0,12,12,36,36,72];
x_41=[4,6.25];
x_42=[3.375*10^-3,8*10^-2,0.75,0.7,1,1,1];
x_43=[0,3.8,6.0,4.7,7.0,7.5];

xx_41=linspace(t_41(1),t_41(end),t_41(end));
yy_41=interp1(t_41,x_41,xx_41,'cubic');
xx_42=linspace(t_42(1),t_42(end),t_42(end));
yy_42=interp1(t_42,x_42,xx_42,'cubic');

that_43=[0,12,36,72];
xhat_43=[0,4.9,5.85,7.5];
xx_43=linspace(that_43(1),that_43(end),that_43(end));
yy_43=interp1(that_43,xhat_43,xx_43,'cubic');

col=[215,25,28;
253,174,97;
44,123,182;
    ]/256;

subplot(1,3,1)
scatter(t_21,x_21,150,col(1,:),'filled')
hold 
scatter(t_22,x_22,150,col(3,:),'filled')
plot(xx_21,yy_21,'color',col(1,:),'LineWidth',2)
plot(xx_22,yy_22,'color',col(3,:),'LineWidth',2)
set(gca,'YScale','log')
set(gca,'FontSize',25)
ylabel('C_1 [ngml^{-1}]')
xlabel('Time [hour]')
xticks([0 36 72])
pbaspect([4,7,1])


subplot(1,3,2)
scatter(t_31,x_31,150,col(1,:),'filled')
hold 
scatter(t_32,x_32,150,col(3,:),'filled')
plot(xx_31,yy_31,'color',col(1,:),'LineWidth',2)
plot(xx_32,yy_32,'color',col(3,:),'LineWidth',2)
set(gca,'YScale','log')
set(gca,'FontSize',25)
ylabel('C_2 [ngml^{-1}]')
xlabel('Time [hour]')
xticks([0 36 72])
pbaspect([4,7,1])

subplot(1,3,3)
scatter(t_41,x_41,150,col(1,:),'filled')
hold on
scatter(t_42,x_42,150,col(2,:),'filled')
scatter(t_43,x_43,150,col(3,:),'filled')
plot(xx_41,yy_41,'color',col(1,:),'LineWidth',2)
plot(xx_42,yy_42,'color',col(2,:),'LineWidth',2)
plot(xx_43,yy_43,'color',col(3,:),'LineWidth',2)
set(gca,'YScale','log')
set(gca,'FontSize',25)
ylabel('N [10^6 Cells]')
xlabel('Time [hour]')
xticks([0 36 72])
pbaspect([4,7,1])
