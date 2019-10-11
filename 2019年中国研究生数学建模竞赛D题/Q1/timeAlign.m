function datanew = timeAlign(data)
% 计算有记录GPS的时间
record_time = date2second2(data(2:end,1))';
% 计算起止点
time_start = date2second(data{2,1});
time_end = date2second(data{end,1});
time = time_start:time_end;
% 时间对齐，查找对齐序号
[~,col] = ismember(record_time,time);
errodataNum = length(time) - length(col);
text1 = sprintf('因GPS设备断电或者异常导致数据缺失了%d条数据,正在补齐...\n',errodataNum);
fprintf(text1);
% 构造修复后元胞
data_deal = cell(length(time)+1,size(data,2));
data_deal(:) = {nan};
data_deal([1,col+1],:) = data;
datanew  = data_deal;
% 时间还原
datanew(2:end,1) = second2date(data{2,1},time);
fprintf('时间对齐完成！\n');
end