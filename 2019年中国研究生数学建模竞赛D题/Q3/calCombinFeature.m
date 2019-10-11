function [combinFeature,combinFeature_mat] = calCombinFeature (kinepart)
% 定义存储特征值的结构体
combinFeature = struct(...
    'av_speed',{},...           % 平均速度
    'av_runspeed',{},...        % 平均行驶速度
...  %     'max_speed',{},...          % 最大速度
    'speed_std',{},...          % 速度标准差
    'av_accelerate',{},...      % 平均加速度
    'accelerate_std',{},...     % 加速度标准差
    'av_slowdown',{},...        % 平均减速度
    'slowdown_std',{},...       % 减速度标准差
    'neglect_time',{},...       % 怠速时间
    'accelerate_time',{},...    % 加速时间
    'slowdown_time',{},...      % 减速时间
    'unispeed_time',{});        % 匀速时间
m = length(kinepart);

for i = 1:m
    % 提取速度
    data_temp = kinepart{i};
    v_delta =  (data_temp(2:end) - data_temp(1:end-1)); % 计算速度差
    
    combinFeature(i).av_speed = mean(data_temp);                            % 计算平均速度
    combinFeature(i).av_runspeed = mean(data_temp(data_temp~=0));           % 计算平均行驶速度
%     combinFeature(i).max_speed = max(data_temp);                            % 计算最大速度
    combinFeature(i).speed_std = std(data_temp);                            % 计算速度标准差
    
    % 加速度特征值 单位：m/s^2
    v_delta2 = v_delta*1000/3600; %单位换算
    combinFeature(i).av_accelerate = mean(v_delta2(v_delta2 > 0.1));        % 计算平均加速度
    combinFeature(i).accelerate_std = std(v_delta2(v_delta2 > 0.1));        % 计算加速度标准差
    combinFeature(i).av_slowdown = mean(v_delta2(v_delta2 < -0.1));         % 计算平均减速度
    combinFeature(i).slowdown_std = std(v_delta2(v_delta2 < -0.1));         % 计算减速度标准差
    
    combinFeature(i).neglect_time =  sum(v_delta == 0)/(length( data_temp)-1);% 计算怠速时间比
    combinFeature(i).accelerate_time =  sum( v_delta > 0.1*3600/1000)/...
        (length( data_temp)-1);                                             % 计算加速时间比
    combinFeature(i).slowdown_time =  sum( v_delta < -0.1*3600/1000)/...
        (length( data_temp)-1);                                             % 计算减速时间比
    combinFeature(i).unispeed_time =  sum( v_delta >= -0.1*3600/1000 & ...
        v_delta <= 0.1*3600/1000 & v_delta ~= 0)/(length( data_temp)-1);     % 计算匀速时间比
    
end
combinFeature_mat = cell2mat(reshape(struct2cell(combinFeature),11,length(combinFeature))');     % 总体分布特征指标转矩阵存储
end
