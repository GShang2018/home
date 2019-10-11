function kinePart = kinePartCombine(filename)
% 载入数据
kinePart ={};
for i = 1:length(filename)
    fprintf('正在导入%s运动学片段...\n',filename{i});
    load([filename{i},'运动学片段'],'kinepart');
    m = length(kinepart);
    for j = 1:m
        datatemp = cell2mat(kinepart{j,1}(2:end,2));
        kinePart{end+1,1} = datatemp;
    end
end
fprintf('所有文件运动学片段提取合并完成！\n');
end

