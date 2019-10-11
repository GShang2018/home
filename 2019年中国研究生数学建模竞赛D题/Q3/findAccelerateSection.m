function Accelerate_index = findAccelerateSection(Accelerate)
if  Accelerate < -3
    Accelerate_index = 1;
elseif Accelerate >=-3 && Accelerate < -2
    Accelerate_index = 2;
elseif Accelerate >=-2 && Accelerate < -1
    Accelerate_index = 3;
elseif Accelerate >=-1 && Accelerate < 0
    Accelerate_index = 4;
elseif Accelerate >=0 && Accelerate < 1
    Accelerate_index = 5;
elseif Accelerate >=1 && Accelerate < 2
    Accelerate_index = 6;
elseif Accelerate >=2 && Accelerate < 3
    Accelerate_index = 7;
elseif Accelerate >=3
    Accelerate_index = 8;
end
end