%%
clear
clc
close all
addpath('C:\Users\Jiujia\Desktop\2019 Project\Optimisation\meta\GA\VaryTime\varyGen')

for i=1:1:9
    load(['population_',num2str(i),'.mat'])
    all_pop{1,i}=population;
end

%%
savedVidFolder = 'C:\Users\Jiujia\Desktop\2019 Project\Optimisation\meta\GA\VaryTime\Corrplot\';
fileFormat = 'Motion JPEG AVI';

f=figure;
writerObj = VideoWriter([savedVidFolder 'Correlation.avi'], fileFormat);
writerObj.FrameRate = 1;
open(writerObj);
for j=1:size(size(all_pop),2)
    figure;
    [R,out,h]=corrplot2(all_pop{1,i},'varNames',...
       {'$\hat{\phi}$', '$\tilde{k_c}$' , '$\tilde{\alpha_1}$' ,...
       '$\tilde{\alpha_2}$' , '$k_{NF}$', '$\delta_{C1}$' , '$\delta_{C2}$' , '$\delta_N$',...
       '$k_{h}$'});
   %change axis---------------------------------------------------------------
   lineHandles = h(strcmp(get(h, 'type'), 'line'));       %get handles for scatter plots only
% Loop through each scatter plot
for j = 1:numel(lineHandles)
    x = lineHandles(j).XData;                         %x data 
    y = lineHandles(j).YData;                         %y data
    %xlim(lineHandles(j).Parent, [min(x), max(x)]);    % set x limit to range of x data
    %ylim(lineHandles(j).Parent, [min(y), max(y)]);    % set y limit to range of y data
    xlim(lineHandles(j).Parent, [0, 4]);    % set x limit to range of x data
    ylim(lineHandles(j).Parent, [0, 4]);    % set y limit to range of y data
    
    % To convince yourself that the axis scales are still the same within rows/cols,
    % include these two lines of code that will display tick marks.
    %lineHandles(i).Parent.Position(3:4) = lineHandles(i).Parent.Position(3:4) * .8; 
    %set(lineHandles(i).Parent, 'XTickMode', 'auto', 'XTickLabelMode', 'auto', 'YTickMode', 'auto', 'YTickLabelMode', 'auto')
end
% now take care of the x axis limits of the histogram plots
histHandles = h(strcmp(get(h, 'type'), 'histogram'));     %handles to all hist plots
% loop through hist plots
for k = 1:numel(histHandles)
    x = histHandles(k).BinEdges;                         %bin edges
    xlim(histHandles(k).Parent, [0,4]);
    ylim(histHandles(k).Parent, [0,4]);
end
    drawnow;
    frame = getframe(f);
    writeVideo(writerObj,frame);
end
close(writerObj);

%%
for i=1:9
   figure (i)
   [R,out,h]=corrplot2(all_pop{1,i},'varNames',...
       {'$\hat{\phi}$', '$\tilde{k_c}$' , '$\tilde{\alpha_1}$' ,...
       '$\tilde{\alpha_2}$' , '$k_{NF}$', '$\delta_{C1}$' , '$\delta_{C2}$' , '$\delta_N$',...
       '$k_{h}$'});
%change axis---------------------------------------------------------------
   lineHandles = h(strcmp(get(h, 'type'), 'line'));       %get handles for scatter plots only
% Loop through each scatter plot
for j = 1:numel(lineHandles)
    x = lineHandles(j).XData;                         %x data 
    y = lineHandles(j).YData;                         %y data
    %xlim(lineHandles(j).Parent, [min(x), max(x)]);    % set x limit to range of x data
    %ylim(lineHandles(j).Parent, [min(y), max(y)]);    % set y limit to range of y data
    xlim(lineHandles(j).Parent, [0, 4]);    % set x limit to range of x data
    ylim(lineHandles(j).Parent, [0, 4]);    % set y limit to range of y data
    
    % To convince yourself that the axis scales are still the same within rows/cols,
    % include these two lines of code that will display tick marks.
    %lineHandles(i).Parent.Position(3:4) = lineHandles(i).Parent.Position(3:4) * .8; 
    %set(lineHandles(i).Parent, 'XTickMode', 'auto', 'XTickLabelMode', 'auto', 'YTickMode', 'auto', 'YTickLabelMode', 'auto')
end
% now take care of the x axis limits of the histogram plots
histHandles = h(strcmp(get(h, 'type'), 'histogram'));     %handles to all hist plots
% loop through hist plots
for k = 1:numel(histHandles)
    x = histHandles(k).BinEdges;                         %bin edges
    xlim(histHandles(k).Parent, [0,4]);
    ylim(histHandles(k).Parent, [0,4]);
end
%--------------------------------------------------------------------------
   name_png=['fig',num2str(i),'.png'];
   name_jpg=['fig',num2str(i),'.jpg'];
   name_eps=['fig',num2str(i),'.eps'];
   print(gcf,name_png,'-dpng','-r300')
  print(gcf,name_jpg,'-dpng','-r300')
  print(gcf,name_eps,'-deps','-r300')
end
