function [distFeature,distFeature_mat ]= calDistFeature(kinePart)

% 定义分存储分布特征的结构体
distFeature =  struct(...
    'neglect_time',{}, ...      % 怠速时间比
    'accelerate_time',{}, ...   % 加速时间比
    'slowdown_time',{},...      % 减速时间比
    'unispeed_time',{},...      % 匀速时间比
    'v0_10_time',{},...         % 0-10km 速度段比例
    'v10_20_time',{},...        % 10-20km 速度段比例
    'v20_30_time',{},...        % 20-30km 速度段比例
    'v30_40_time',{},...        % 30-40km 速度段比例
    'v40_50_time',{},...        % 40-50km 速度段比例
    'v50_60_time',{},...        % 50-60km 速度段比例
    'v60_70_time',{},...        % 60-70km 速度段比例
    'v70_inf_time',{});         % 70-infkm 速度段比例


m = length(kinePart);

for i = 1:m
    % 提取速度
    data_temp = kinePart{i};
    v_delta =  (data_temp(2:end) - data_temp(1:end-1)); % 计算速度差
    
    % 计算运动段总体分布特征
    distFeature(i).neglect_time =  sum(v_delta == 0)/(length( data_temp)-1);    % 计算怠速时间比
    distFeature(i).accelerate_time =  sum( v_delta > 0.1*3600/1000)/...
        (length( data_temp)-1);                                                 % 计算加速时间比
    distFeature(i).slowdown_time =  sum( v_delta < -0.1*3600/1000)/...
        (length( data_temp)-1);                                                 % 计算减速时间比
    distFeature(i).unispeed_time =  sum( v_delta >= -0.1*3600/1000 & ...
        v_delta <= 0.1*3600/1000 & v_delta ~= 0)/(length( data_temp)-1);        % 计算减速时间比
    distFeature(i).v0_10_time =  sum(data_temp>0 & data_temp<=10)/...
        (sum( data_temp>0));                                                    % 0-10km 速度段比例
    distFeature(i).v10_20_time =  sum(data_temp>10 & data_temp<=20)/...
        (sum( data_temp>0));                                                    % 10-20km 速度段比例
    distFeature(i).v20_30_time =  sum(data_temp>20 & data_temp<=30)/...
        (sum( data_temp>0));                                                    % 20-30km 速度段比例
    distFeature(i).v30_40_time =  sum(data_temp>30 & data_temp<=40)/...
        (sum( data_temp>0));                                                    % 30-40km 速度段比例
    distFeature(i).v40_50_time =  sum(data_temp>40 & data_temp<=50)/...
        (sum( data_temp>0));                                                    % 40-50km 速度段比例
    distFeature(i).v50_60_time =  sum(data_temp>50 & data_temp<=60)/...
        (sum( data_temp>0));                                                    % 50-60km 速度段比例
    distFeature(i).v60_70_time =  sum(data_temp>60 & data_temp<=70)/...
        (sum( data_temp>0));                                                    % 60-70km 速度段比例
    distFeature(i).v70_inf_time =  sum(data_temp>70)/(sum( data_temp)-1);       % 70-infkm 速度段比例
end
distFeature_mat = cell2mat(reshape(struct2cell(distFeature),12,length(distFeature))');     % 总体分布特征指标转矩阵存储
end
