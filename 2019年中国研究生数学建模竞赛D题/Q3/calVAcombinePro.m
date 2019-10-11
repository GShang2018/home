function VAcombinePro = calVAcombinePro(kinePart_all)
VAcombinePro  = zeros(8,8);
Speed = kinePart_all(2:end);
Accelerate = (kinePart_all(2:end) - kinePart_all(1:end-1))*1000/3600; %µ•ŒªªªÀ„

m = length(Speed);
for i = 1:m
    row = findAccelerateSection(Accelerate(i));
    col = findSpeedSection(Speed(i));
    VAcombinePro(row,col) = VAcombinePro(row,col) + 1;
end
VAcombinePro = VAcombinePro/m;
end