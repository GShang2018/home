function datanew = accelerateErrorDetect(data)
datanew = data;
% 提取速度
data_temp = cell2mat(datanew(2:end,2));
a = data_temp;
% 构造加速度计算数组
a_before = a(1:end-1);
a_after = a(2:end);
% 计算加速度
a_delta = a_after - a_before;
% 正加速度上限值
p_v = 100/7;
% 负加速度上限值
n_v = -8*3600/1000;
% 记录加速度异常值
p_index = [];
n_index = [];
for i = 1:length(a_delta)
    if a_delta(i) > p_v
        p_index = [p_index,i];
    elseif a_delta(i) < n_v
        n_index = [n_index,i];
    end
end
% 序号挪到异常的位置
p_index = p_index + 1;
n_index = n_index + 1;

% 异常数据记录
fprintf('找到加速度异常数据%d条，其中异常加速%d条，异常刹车%d条，正在剔除...\n',...
    length([p_index,n_index]),length(p_index),length(n_index));
erro_index = [p_index,n_index]+1;
for i = 1:length(erro_index)
    datanew(erro_index(i),2:end) = {nan};
end
fprintf('加速度异常处理完成！\n');
end
