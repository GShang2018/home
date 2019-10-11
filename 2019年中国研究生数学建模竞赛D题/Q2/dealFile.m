function dealFile(filename)
% 载入数据
fprintf('正在导入%s...\n',filename);
load([filename,'数据预处理后'],'datanew');
data = datanew;
fprintf('导入成功！一共导入%d条数据\n',length(data)-1);
% 选取运动学片段
kinepart = kinePartDetect(data);
% 保存运动学片段
save([filename,'运动学片段'],'kinepart');
end