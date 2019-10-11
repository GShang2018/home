function [kinePartSorted,curve] = calCurve2(kinePart,group)
for i = 1:3
 kinePart_g1 = kinePart(group{i,1},1);   
%  计算总体分布特征指标
[~,partDistFeature_mat ]= calDistFeature(kinePart_g1);
% 求各指标均值
partDistFeature_mean = mean(partDistFeature_mat);

% 计算相似度，降序排列
m = length(partDistFeature_mat);
pearsonCorr = zeros(m,1);
for j = 1:m
    pearsonCorr(j) = myPearson(partDistFeature_mat(j,:),partDistFeature_mean);
end   
[~,mostCorr_index]= sort(pearsonCorr,'descend');
kinePart_g1_sorted = kinePart_g1(mostCorr_index);

% 计算片段时长
part_time = zeros(m,1);
for k = 1:m
    part_time(k) = length(kinePart_g1_sorted{k,1});
end

% 选取 1200 ~ 1300s 片段
is_choose = choosePart(part_time,1200,1300);
kinePart_curve = kinePart_g1_sorted(is_choose==1,1);

% 得到最终的工况曲线
curve1 = cell2mat(kinePart_curve);

% 存储排序后的片段，以及对应的工况曲线
kinePartSorted{i} = kinePart_g1_sorted;
curve{i} = curve1;
end

% 画三类工况曲线图
fprintf('三类工况曲线计算完成！\n');
groupName = {'第一类工况曲线','第二类工况曲线','第三类工况曲线'};
for i = 1:length(groupName)
    figure;
    set(gcf,'outerposition',get(0,'screensize'))
    plot(curve{i},'r-','linewidth',2)
    xlabel('时间（s）'),ylabel('车速（km/h）')
    title(groupName{i});
    grid on
    set(gca,'GridLineStyle','--','GridColor','k','GridAlpha',1,'fontsize',24);
    axis tight
    print(gcf,'-djpeg','-r300',groupName{i});
    fprintf('%s绘制完成！\n',groupName{i})
end

end