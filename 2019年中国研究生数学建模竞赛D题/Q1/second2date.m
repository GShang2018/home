function time1 = second2date(firstdate,time)
m = length(time);
dateStart = firstdate;
time1 = cell(m,1);
for i = 1:m
    day = fix(time(i)/(60*60*24));
    hour = fix(rem(time(i),(60*60*24))/(60*60));
    min = fix(rem(rem(time(i),(60*60*24)),(60*60))/60);
    second = fix(rem(rem(rem(time(i),(60*60*24)),(60*60)),60)/1);
    time_now = [day,hour,min,second];
    time_text = cell(4,1);
    for j = 1:4
        if time_now(j) < 10
            time_text{j} = sprintf('0%d',time_now(j));
        else
            time_text{j} = sprintf('%d',time_now(j));
        end
    end
    text = sprintf('%s%s %s:%s:%s.000.',firstdate(1:8),time_text{1},time_text{2},time_text{3},time_text{4});
    time1{i} = text;
end