%% 准备存储空间
clc,clear,close all

filename = {'文件1','文件2','文件3'};
tic
for i = 1:length(filename)
    dealFile(filename{i});
    figure(i)
    drawVTpic(filename{i});
    fprintf('----------------------\n');
end
fprintf('所有文件数据异常处理完成！\n');
toc