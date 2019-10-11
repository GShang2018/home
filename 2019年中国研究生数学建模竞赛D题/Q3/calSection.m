function [sectionSpeed,sectionTime] = calSection(curve,kinePart)
% 分析三类工况曲线
curveDistFeature = calDistFeature(curve);
curvebardata = [...
    curveDistFeature.neglect_time;...
    curveDistFeature.accelerate_time;...
    curveDistFeature.slowdown_time;...
    curveDistFeature.unispeed_time,...
    ];
curvebarname = {'怠速模式','加速模式','减速模式','匀速模式'};
figure;set(gcf,'outerposition',get(0,'screensize'));
groupName = {'第一类工况曲线','第二类工况曲线','第三类工况曲线'};
bar(curvebardata),legend(groupName),grid on;
set(gca,'xticklabel',curvebarname,'fontsize',24,'GridLineStyle','--','GridColor','k','GridAlpha',1);
print(gcf,'-djpeg','-r300','三类工况曲线的运行模式对比');
% 计算速度区间
sectionSpeed = calSpeedSection(curveDistFeature);

% 计算速度区间持续长度
sectionTime = calSectionTime(sectionSpeed,kinePart);
end