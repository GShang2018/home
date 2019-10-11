function Speed_index = findSpeedSection(speed)
if speed >=0 && speed < 10
    Speed_index = 1;
elseif speed >=10 && speed < 20
    Speed_index = 2;
elseif speed >=20 && speed < 30
    Speed_index = 3;
elseif speed >=30 && speed < 40
    Speed_index = 4;
elseif speed >=40 && speed < 50
    Speed_index = 5;
elseif speed >=50 && speed < 60
    Speed_index = 6;
elseif speed >=60 && speed < 70
    Speed_index = 7;
elseif speed >=70
    Speed_index = 8;
end
end