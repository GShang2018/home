function datanew = gpsMissDetect(data)
datanew = data;
% 提取速度
data_temp = cell2mat(datanew(2:end,2));
% 短时GPS丢失修复（2s均值插补法）
fix_num = 0; % 记录处理的数据个数
for i = 2:length(data_temp)-1
    if ~isnan(data_temp(i-1)) && isnan(data_temp(i)) && ~isnan(data_temp(i+1))
        data_temp(i) = mean([data_temp(i-1),data_temp(i+1)]);
        fix_num = fix_num + 1;
    end
end

for i = 2:length(data_temp)+1
    datanew{i,2} = data_temp(i-1);
end
fprintf('找到GPS短时丢失数据（丢失1s）%d条，已通过插值修复！\n', fix_num);
end