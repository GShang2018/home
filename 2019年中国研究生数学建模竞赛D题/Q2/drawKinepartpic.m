function drawKinepartpic(filename)
set(gcf,'outerposition',get(0,'screensize'))
fprintf('正在导入%s运动学片段...\n',filename);
load([filename,'运动学片段'],'kinepart');
for i = 1:4
    subplot(2,2,i)
    data = kinepart{i}; % 读取运动学片段
    plotdata = cell2mat(data(2:end,2));
    plot(plotdata,'r-','linewidth',2)
    grid on
    set(gca,'fontsize',24)
    xlabel('时间（s）'),ylabel('车速（km/h）');
    set(gca,'GridLineStyle','--','GridColor','k','GridAlpha',1)
    text = sprintf('%s - %s',data{2,1},data{end,1}); % 片段起止时间
    axis tight
    title(text) 
end
print(gcf,'-djpeg','-r300',[filename,'前4个运动学片段']);
fprintf('%s前4个运动学片段绘制完成！\n',filename)
end