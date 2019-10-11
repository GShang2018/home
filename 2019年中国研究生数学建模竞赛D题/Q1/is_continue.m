function data_slice = is_continue(data)
m = length(data);
k = 1;
data_slice = cell(m,1);
data_slice{1,1} = data(1);
for i = 2:m
    if data(i) - data(i-1) == 1
       data_slice{k,1} = [ data_slice{k,1},data(i)];
    else
        k = k+1;
        data_slice{k,1} = data(i);
    end
end
% 删除多余的空数据行
data_slice(all(cellfun(@(x) isempty(x),data_slice),2),:)=[];
end