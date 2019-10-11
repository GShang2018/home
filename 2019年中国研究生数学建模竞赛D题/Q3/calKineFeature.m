function [kineFeature,kineFeature_mat] = calKineFeature(kinePart)
% 定义存储特征值的结构体
kineFeature = struct(...
    'run_time',{},...           % 运行时间
    'neglect_time',{},...       % 怠速时间
    'accelerate_time',{},...    % 加速时间
    'slowdown_time',{},...      % 减速时间
    'unispeed_time',{},...      % 匀速时间
    'av_speed',{},...           % 平均速度
    'av_runspeed',{},...        % 平均行驶速度
    'max_speed',{},...          % 最大速度
    'speed_std',{},...          % 速度标准差
    'av_accelerate',{},...      % 平均加速度
    'max_accelerate',{},...     % 最大加速度
    'accelerate_std',{},...     % 加速度标准差
    'av_slowdown',{},...        % 平均减速度
    'min_slowdown',{},...       % 最小减速度
    'slowdown_std',{});         % 减速度标准差

m = length(kinePart);

for i = 1:m
    % 提取速度
    data_temp = kinePart{i};
    v_delta =  (data_temp(2:end) - data_temp(1:end-1)); % 计算速度差
    
    % 计算运动段特征值
    % 时间特征值 单位：s
    kineFeature(i).run_time = length( data_temp)-1;                         % 计算运行时间
    kineFeature(i).neglect_time = sum(v_delta == 0);                        % 计算怠速时间
    kineFeature(i).accelerate_time = sum( v_delta > 0.1*3600/1000);         % 计算加速时间
    kineFeature(i).slowdown_time = sum( v_delta < -0.1*3600/1000);          % 计算减速时间
    kineFeature(i).unispeed_time = sum( v_delta >= -0.1*3600/1000 &...
        v_delta <= 0.1*3600/1000 & v_delta ~= 0);                           % 计算匀速时间
    
    % 速度特征值 单位：km/h
    kineFeature(i).av_speed = mean(data_temp);                              % 计算平均速度
    kineFeature(i).av_runspeed = mean(data_temp(data_temp~=0));             % 计算平均行驶速度
    kineFeature(i).max_speed = max(data_temp);                              % 计算最大速度
    kineFeature(i).speed_std = std(data_temp);                              % 计算速度标准差
    
    % 加速度特征值 单位：m/s^2
    v_delta2 = v_delta*1000/3600; %单位换算
    kineFeature(i).av_accelerate = mean(v_delta2(v_delta2 > 0.1));          % 计算平均加速度
    kineFeature(i).max_accelerate = max(v_delta2(v_delta2 > 0.1));          % 计算最大加速度
    kineFeature(i).accelerate_std = std(v_delta2(v_delta2 > 0.1));          % 计算加速度标准差
    
    kineFeature(i).av_slowdown = mean(v_delta2(v_delta2 < -0.1));           % 计算平均减速度
    kineFeature(i).min_slowdown = max(v_delta2(v_delta2 < -0.1));           % 计算最小减速度
    kineFeature(i).slowdown_std = std(v_delta2(v_delta2 < -0.1));           % 计算减速度标准差
    
end
kineFeature_mat = cell2mat(reshape(struct2cell(kineFeature),15,length(kineFeature))');     % 运动学特征指标转矩阵存储
fprintf('运动学特征指标计算完成！\n');
end
