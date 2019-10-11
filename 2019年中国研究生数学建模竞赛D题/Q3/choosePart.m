function is_choose = choosePart(part_time,time_min,time_max)
m = length(part_time);
is_choose = zeros(m,1);
for i = 1:m
    is_choose(i) = 1;
    if sum(part_time(is_choose==1)) < time_min
        is_choose(i) = 1;
    elseif  sum(part_time(is_choose==1)) > time_min && sum(part_time(is_choose==1)) < time_max
        break
    else
        is_choose(i) = 0;
    end
end
end