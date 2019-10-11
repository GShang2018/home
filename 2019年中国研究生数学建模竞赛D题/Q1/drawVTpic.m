function drawVTpic(filename)

set(gcf,'outerposition',get(0,'screensize'))

% 导入异常处理前数据
[~,~,data1] = xlsread(filename);
plotdata1 = cell2mat(data1(2:end,2));
subplot(211)
plot(plotdata1)
grid on
set(gca,'fontsize',24)
xlabel('时间（s）'),ylabel('车速（km/h）');
set(gca,'GridLineStyle','--','GridColor','k','GridAlpha',1)
title([filename,'数据预处理前']);

% 导入异常处理后数据
load([filename,'数据预处理后'],'datanew');
data2 = datanew;
plotdata2 = cell2mat(data2(2:end,2));
x = data2{2,1};
x_hour =str2double(x(12:13));
x_min =str2double(x(15:16));
x_second =str2double(x(18:19));
t1 = (23-x_hour)*3600 + (59-x_min)*60 + (59-x_second)*1 +1;

subplot(212)
plot(plotdata2)
grid on
set(gca,'xtick',[1,t1:86400:length(plotdata2)],'xticklabel',0:1:6,'fontsize',24)
xlabel('时间（以天为网格单位）'),ylabel('车速');
set(gca,'GridLineStyle','--','GridColor','k','GridAlpha',1)
title([filename,'数据预处理后'])
print(gcf,'-djpeg','-r300',[filename,'数据预处理前后对比图']);

fprintf('%s数据预处理前后对比图绘制完成！\n',filename)
end