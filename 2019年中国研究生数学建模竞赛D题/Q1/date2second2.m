function y = date2second2(x_cell)
m = length(x_cell);
y = zeros(m,1);
for i = 1:m
    x =x_cell{i};
    x_day =str2double(x(9:10));
    x_hour =str2double(x(12:13));
    x_min =str2double(x(15:16));
    x_second =str2double(x(18:19));
    y(i) = x_day*60*60*24 + ...
        x_hour*60*60 + ...
        x_min*60 + ...
        x_second;
end
end