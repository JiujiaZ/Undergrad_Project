
%%
clear
clc
close all
load('tol.mat')
plot(2:16, tol,'LineWidth',2)
xlabel('i')
ylabel('tolerance level')
set(gca,'FontSize',25)
set(gca, 'YScale', 'log')

%
load('out.mat')
a=1;
for i = 1:1000:18000
    outp{1,a}=out(i:i+999,:);
    a=a+1;
end
% a=1;
% for i= 1:10:70
%     figure(a);
%     scatterhist(outp{1,i}(:,2),outp{1,i}(:,3))
%     xlabel('a')
%     ylabel('b')
%     title(['i = ', num2str(i)])
%     a=a+1;
% end

% thIS IS THE LINEEEEE
[S,AX,BigAx,H,HAx] = plotmatrix(outp{1,18}(:,2:end-1));   
xlabel(AX(9,1),'$\phi$','Interpreter','latex','FontSize',18);
xlabel(AX(9,2),'$k_{NF}$ ','Interpreter','latex','FontSize',18);
xlabel(AX(9,3),'$\tilde{k}_c$','Interpreter','latex','FontSize',18);
xlabel(AX(9,4),' $\delta_{C1}$ ','Interpreter','latex','FontSize',18);
xlabel(AX(9,5),'$k_{h} $','Interpreter','latex','FontSize',18);
xlabel(AX(9,6),'$\delta_{C2}$','Interpreter','latex','FontSize',18);
xlabel(AX(9,7),'$\tilde{\alpha}_1$','Interpreter','latex','FontSize',18);
xlabel(AX(9,8),'$\tilde{\alpha}_2$','Interpreter','latex','FontSize',18);
xlabel(AX(9,9),'$\delta_N$','Interpreter','latex','FontSize',18);

ylabel(AX(1,1),'$\phi$','Interpreter','latex','FontSize',18);
ylabel(AX(2,1),'$k_{NF}$ ','Interpreter','latex','FontSize',18);
ylabel(AX(3,1),'$\tilde{k}_c$','Interpreter','latex','FontSize',18);
ylabel(AX(4,1),' $\delta_{C1}$ ','Interpreter','latex','FontSize',18);
ylabel(AX(5,1),'$k_{h} $','Interpreter','latex','FontSize',18);
ylabel(AX(6,1),'$\delta_{C2}$','Interpreter','latex','FontSize',18);
ylabel(AX(7,1),'$\tilde{\alpha}_1$','Interpreter','latex','FontSize',18);
ylabel(AX(8,1),'$\tilde{\alpha}_2$','Interpreter','latex','FontSize',18);
ylabel(AX(9,1),'$\delta_N$','Interpreter','latex','FontSize',18);
for i = 1:8
        for j = i+1+9*(i-1):9*i
    delete(subplot(9,9,j));
    subplot(9,9,j)
    axis([0,4,0,4])
    %set(gca,'YTickLabel',[]);
    %set(gca,'XTickLabel',[]);
    text(2,2,'TEst')
        end
end

%%
figure
[R,out,h]=corrplot2(outp{1,16}(:,2:end-1),'varNames',{'$\phi$ ','$k_{NF}$' ,'$\tilde{k}_c$','$\delta_{C1}$', '$k_{h}$','$\delta_{C2}$','$\tilde{\alpha}_1$','$\tilde{\alpha}_2$','$\delta_N$'});
%%
for i=1:1:9
   figure (i) 
   [R,out,h]=corrplot2(all_pop{1,i}','varNames',{'$\phi$ ','$k_{NF}$' ,'$\tilde{k}_c$','$\delta_{C1}$', '$k_{h}$','$\delta_{C2}$','$\tilde{\alpha}_1$','$\tilde{\alpha}_2$','$\delta_N$'});
end

%%
a=mode(outp{1,16}(:,2:end-1));
%%
y0=[30,0,0,0];
tfine=0:0.1:72;
[new_time,new_path] = ode45(@(t,y)FModelode(t,y,a),tfine,y0);
for i=1:1:4

   plot(new_time,new_path(:,i))
   hold on
  
end

%%
for i=1:1:4
   figure(i)
   plot(new_time,new_path(:,i))
   hold
   scatter(Tcell{1,i},Ycell{1,i})
  
end
