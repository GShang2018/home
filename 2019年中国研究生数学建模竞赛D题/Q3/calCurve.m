function [kinePart_g1_sorted,curve1] = calCurve(kinePart_g1)

%  计算总体分布特征指标
partDistFeature = calDistFeature(kinePart_g1);
partDistFeature_mat = cell2mat(reshape(struct2cell(partDistFeature),12,length(partDistFeature))');

% 求各指标均值
partDistFeature_mean = mean(partDistFeature_mat);

% 计算相似度，降序排列
m = length(partDistFeature_mat);
pearsonCorr = zeros(m,1);
for i = 1:m
    pearsonCorr(i) = myPearson(partDistFeature_mat(i,:),partDistFeature_mean);
end   
[~,mostCorr_index]= sort(pearsonCorr,'descend');
kinePart_g1_sorted = kinePart_g1(mostCorr_index);

% 计算片段时长
part_time = zeros(m,1);
for i = 1:m
    part_time(i) = length(kinePart_g1_sorted{i,1});
end

% 选取 1200 ~ 1300s 片段
is_choose = choosePart(part_time,1200,1300);
kinePart_curve = kinePart_g1_sorted(is_choose==1,1);

% 得到最终的工况曲线
curve1 = cell2mat(kinePart_curve);
end