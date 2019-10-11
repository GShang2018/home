function group =myK_means(data,k)
% 调用kmeans算法
% k = 3; % 聚类的类别
iteration =15000 ; % 聚类最大循环次数
distance = 'sqEuclidean'; % 距离函数
opts = statset('MaxIter',iteration);
index = kmeans(data,k,'distance',distance,'Options',opts);

group = cell(k,1);
for i = 1:k
    group{i} = find(index==i);
end
save('聚类结果','group');
fprintf('K-Means聚类计算完成！\n');
end