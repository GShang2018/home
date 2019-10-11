function datanew = speedErrorDetect(data)
datanew = data;
% 提取速度
data_temp = cell2mat(datanew(2:end,2));
erro_index = find(data_temp > 120 );
text1 = sprintf('找到速度异常数据%d条，正在剔除...\n',length(erro_index));
fprintf(text1);
datanew(erro_index+1,2:end) = {nan};
fprintf('速度异常处理完成！\n');
end