%% 准备存储空间
clc,clear,close all

filename = {'文件1','文件2','文件3'};
tic
for i = 1:length(filename)
    dealFile(filename{i});
    figure(i)
    drawKinepartpic(filename{i});
    fprintf('----------------------\n');
end
fprintf('所有文件运动学片段提取完成！\n');
toc