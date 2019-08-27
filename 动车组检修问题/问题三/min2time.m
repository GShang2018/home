function time = min2time(minute)
hour = fix(minute/60);
minute = mod(minute,60);
if hour < 10 && minute <10
    time = sprintf('0%d:0%d',hour,minute);
elseif hour >= 10 && minute <10
    time = sprintf('%d:0%d',hour,minute);
elseif hour >= 10 && minute >=10
    time = sprintf('%d:%d',hour,minute);
elseif hour < 10 && minute >=10
    time = sprintf('0%d:%d',hour,minute);
end
end
