function datanew = carStopDtect(data)
datanew = data;
% 提取速度、转速、油门数据
data_temp = cell2mat(datanew(2:end,[2,8,11]));
% 找出速度为0的数据
v_index = find(data_temp(:,1)==0);
% 找出油门开度为0的数据
throttle_index = find(data_temp(:,3)==0);
% 找出速度和油门约束下的可疑数据
deal_index = intersect(v_index,throttle_index);
r_min = mean(data_temp(deal_index,2)); % 取转速均值作为怠速转速
% 找出怠速转速最小值
r_index = find(data_temp(:,2)<= r_min);
% 找到满足情况的数据
deal_index2 = intersect(deal_index,r_index);
% 找出连续的数据
deal_index3 = is_continue(deal_index2);
% 统计连续片段长度
for i = 1:length(deal_index3)
    index3_length(i) = length(deal_index3{i});
end
% 找出超过180s的数据段
deal_index4 = find(index3_length > 180);

% 异常数据记录
erro_part = length(deal_index4);
erro_num = sum(index3_length(deal_index4));
text1 = sprintf('找到长期停车（熄火或者不熄火）片段%d个，共包含%d条数据，正在剔除...\n',erro_part,erro_num);
fprintf(text1);
% 对应连续数据段进行剔除（数据抹成nan）
for i = 1:length(deal_index4)
    datanew(cell2mat(deal_index3(deal_index4(i)))+1,2:end) = {nan};
end
fprintf('长期停车异常处理完成！\n');
end