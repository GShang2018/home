% 准备存储空间
clc,clear,close all

% 合并所有文件运动学片段
kinePart = kinePartCombine({'文件1','文件2','文件3'});

% 计算运动学特征指标
[kineFeature,kineFeature_mat] = calKineFeature(kinePart);
  
% 主成分分析降维(按累计贡献率85%以上)
[kineFeature_dim,mylatent] = myPCA(kineFeature_mat,0.85);

% K-Means聚类，聚成三类
group =myK_means(kineFeature_dim,3);

% 按聚类结果，计算对应工况曲线
[kinePartSorted,curve] = calCurve2(kinePart,group);

% 计算合成曲线的片段参数
[sectionSpeed,sectionTime] = calSection(curve,kinePart);

% 合成工况曲线
curveComposed = calCurveComposed(kinePartSorted,sectionTime,sectionSpeed);

% 联合特征指标误差分析
[CombinFeature_erro_abs,CombinFeature_erro_rel,CombinFeature_erro_mean] = ...
    calCombinFeatureErro(kinePart,curve,curveComposed);

% 速度-加速度联合概率分布误差分析
[VAcombinePro_erro_abs,VAcombinePro_erro_rel,VAcombinePro_erro_mean] = ...
    calVAcombineProErro(kinePart,curve,curveComposed);

% 决定最终的工况曲线
curvename = {'第一类工况曲线','第二类工况曲线','第三类工况曲线','合成工况曲线'};
[~,index] = min(CombinFeature_erro_mean+VAcombinePro_erro_mean);
fprintf('经过两种误差分析与计算，最佳的工况曲线为%s\n',curvename{index});

