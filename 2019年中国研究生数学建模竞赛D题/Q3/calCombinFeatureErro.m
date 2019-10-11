function [erro_abs,erro_rel,erro_mean] = calCombinFeatureErro(kinePart,curve,curveComposed)
% 计算所有运动学片段的联合特征指标
[~,combinFeature_mat] = calCombinFeature (kinePart);
combinFeature_all = mean(combinFeature_mat);   % 取均值

% 计算所有工况曲线联合特征指标
curve_all = [curve,{curveComposed}];
[~,combinFeature_curve] = calCombinFeature(curve_all); 

% 计算绝对误差
erro_abs = combinFeature_curve - combinFeature_all;
erro_rel = abs(erro_abs)./abs(combinFeature_all);
erro_mean = mean(erro_rel');
name = {'第一类工况曲线','第二类工况曲线','第三类工况曲线','合成工况曲线'};
[~,index]= min(erro_mean);

figure;set(gcf,'outerposition',get(0,'screensize'))

subplot(2,1,1)
plot(1:11,combinFeature_all,'ro-',1:11,combinFeature_curve(index,:),'bo-','linewidth',2);
xlabel('评价指标'),ylabel('指标取值'); legend({'实际工况',[name{index},'(误差最小工况)']})
set(gca,'GridLineStyle','--','GridColor','k','GridAlpha',1,'fontsize',24);
grid on ,axis tight

subplot(2,1,2)
plot(1:11,erro_rel(index,:),'bo-','linewidth',2);
xlabel('评价指标'),ylabel('相对误差');
set(gca,'GridLineStyle','--','GridColor','k','GridAlpha',1,'fontsize',24);
grid on ,axis tight

print(gcf,'-djpeg','-r300','联合特征评价指标误差分析');
fprintf('%s绘制完成！\n','联合特征评价指标误差分析')

end
