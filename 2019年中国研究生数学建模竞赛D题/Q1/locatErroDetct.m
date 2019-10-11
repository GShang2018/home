function datanew = locatErroDetct(data)
datanew = data;
% 提取经纬度数据
data_temp =sum( cell2mat(datanew(2:end,6:7)),2);
% 找到全为0的数据，将其剔除（置为nan）
erro_index = find(data_temp==0);
text1 = sprintf('找到经纬度异常数据%d条，正在剔除...\n',length(erro_index));
fprintf(text1);
datanew(erro_index+1,2:end) = {nan};
fprintf('经纬度异常处理完成！\n');
end