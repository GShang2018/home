function  sectionTime = calSectionTime(sectionSpeed,kinePart)

kinePart_mat = cell2mat(kinePart);

speed_s = zeros(3,1);
for i = 1:length(kinePart_mat)
    for j = 1:3
        if kinePart_mat(i) > sectionSpeed(j,1) && kinePart_mat(i) <= sectionSpeed(j,2)
            speed_s(j) = speed_s(j) +1;
        end
    end
end

time_s1 = (speed_s(1)/sum(speed_s))*[1200,1300];
time_s2 = (speed_s(2)/sum(speed_s))*[1200,1300];
time_s3 = (speed_s(3)/sum(speed_s))*[1200,1300];
sectionTime = [time_s1;time_s2;time_s3];
