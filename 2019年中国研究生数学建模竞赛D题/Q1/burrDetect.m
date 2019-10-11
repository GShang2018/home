function datanew = burrDetect(data)
datanew = data;
% 提取速度
data_temp = cell2mat(datanew(2:end,2));
% 找出速度大于0的数据
v_index = find(data_temp(:,1)>0);
% 找出连续的片段
deal_index1 = is_continue(v_index);
% 统计连续片段长度
for i = 1:length(deal_index1)
    index1_length(i) = length(deal_index1{i});
end
% 找出长度小于4s的数据段
deal_index2 = find(index1_length < 4);
% 异常数据记录
erro_part = length(deal_index2);
erro_num = sum(index1_length(deal_index2));
text1 = sprintf('找到毛刺片段%d个，共包含%d条数据，正在怠速处理...\n',erro_part,erro_num);
fprintf(text1);
% 对应连续数据段进行怠速处理（数据抹成0）
for i = 1:length(deal_index2)
    datanew(cell2mat(deal_index1(deal_index2(i)))+1,2) = {0};
end
fprintf('毛刺异常处理完成！\n');
end