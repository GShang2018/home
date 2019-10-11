function [data2,mylatent] = myPCA(data,proportion)

% 数据标准化
data1 = zscore(data);

% 主成分分析
[coeff,~,latent] = pca(data1);

% 计算累计贡献率，确认维度
latent = latent/sum(latent);
sum_latent = cumsum(latent); % 累计贡献率
dimension = find(sum_latent>proportion);
dimension= dimension(1);

% 降维
data2 = data1  * coeff(:,1:dimension);
mylatent = [latent,sum_latent];% 贡献率  累计贡献率

% 画碎石图
figure;
set(gcf,'outerposition',get(0,'screensize'))
plot(mylatent(:,1),'bo-','linewidth',2)
xlabel('主成分序号'),ylabel('贡献率')
grid on
set(gca,'GridLineStyle','--','GridColor','k','GridAlpha',1,'fontsize',24);
print(gcf,'-djpeg','-r300','主成分分析碎石图');

fprintf('主成分分析降维计算完成！\n');

end