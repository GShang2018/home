function y = date2second(x)
x_day =str2double(x(9:10));
x_hour =str2double(x(12:13));
x_min =str2double(x(15:16));
x_second =str2double(x(18:19));
y = x_day*60*60*24 + ...
    x_hour*60*60 + ...
    x_min*60 + ...
    x_second;
end