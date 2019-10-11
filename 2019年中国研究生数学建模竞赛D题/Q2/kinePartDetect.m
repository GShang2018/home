function kinepart = kinePartDetect(data)
datanew = data;
% 提取速度
data_temp = cell2mat(datanew(2:end,2));
fprintf('正在查找运动学片段...\n')
% 找出速度大于0的数据
v_index = find(data_temp(:,1)>0);
% 找出连续的片段
deal_index1 = is_continue(v_index);
% 统计连续片段长度
for i = 1:length(deal_index1)
    index1_length(i) = length(deal_index1{i});
end
% 找出超过10s的数据段
deal_index2 = deal_index1(index1_length > 10,1);
% 找出前后都为0的，符合要求的运动片段
is_part = zeros(length(deal_index2),1);
for i = 1:length(deal_index2)
    part_start = deal_index2{i,1}(1)-1;
    part_end = deal_index2{i,1}(end)+1;
    if (data_temp(part_start)==0) && (data_temp(part_end)==0)
        is_part(i) = 1;
    end
end
deal_index3 = deal_index2(is_part==1,1);
kinepart = cell(length(deal_index3),1);
% 找出前面180s范围内为0的那一段
for j = 1:length(deal_index3)
    for k = 1:180
        if deal_index3{j,1}(1)-k > 1  %不可以超出索引
            if data_temp(deal_index3{j,1}(1)-k) ~= 0 
                break;
            end
        else
            break;
        end
    end
    now_index = (deal_index3{j,1}(1)-k+1:deal_index3{j,1}(end)+1);
    kinepart{j,1} = datanew([1,now_index+1],:);
end
fprintf('一共找到%d个运动学片段！\n',length(deal_index3));
end