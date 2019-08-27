function df_A  = mygreedy3(time,n_workshop_A,time_cost_A,n_car,in_ind_A)
time_cost_A = time_cost_A(in_ind_A);
M = 10000;
is_finish_A = zeros(1,n_car); % 记录所有动车的工艺完成状态，1为完成，0为未完成
is_work_A = zeros(M,n_workshop_A); % 记录各个时刻车间的占用情况
input_time_record_A = []; % 记录动车进站时间
output_time_record_A = []; % 记录动车出战时间
workshop_ind_record_A = []; % 记录检修车间编号
n_arrival_car_A = 0; % 记录检修完的车辆数

for time_A = 1:length(time)
    num_work_A = sum(is_work_A(time(time_A),:)); %计算time时刻的车间运作数量
    num_finish_A = sum(is_finish_A); % 计算time时刻已经发车的数量
    %车间全部空闲 且 所有车已经完成检修
    if  n_arrival_car_A == n_car
        break
        %车间空闲 且 所有车未完成检修
    elseif num_work_A < n_workshop_A && num_finish_A < n_car
        [~,col] = find(is_work_A(time(time_A),:) == 0);
        free_id = col(1);
        is_work_A(time(time_A):time(time_A)+time_cost_A(time_A),free_id) = 1;
        is_finish_A(1,n_arrival_car_A+1) = 1;
        n_arrival_car_A = n_arrival_car_A + 1;
        output_time_record_A = [output_time_record_A,time(time_A) + time_cost_A(time_A)];
        input_time_record_A = [input_time_record_A,time(time_A)];
        workshop_ind_record_A = [ workshop_ind_record_A ,free_id];
        %车间无空闲 且 所有车未完成检修
    elseif num_work_A == n_workshop_A && num_finish_A < n_car
        [~,col] = find(is_work_A(time(time_A),:) == 0);
        k=0;
        while isempty(col)
            k=k+1;
            [~,col] = find(is_work_A(time(time_A)+k,:) == 0);
        end
        free_id = col(1);
        is_work_A(time(time_A)+k:time(time_A)+k+time_cost_A(time_A),free_id) = 1;
        is_finish_A(1,n_arrival_car_A+1) = 1;
        n_arrival_car_A = n_arrival_car_A + 1;
        output_time_record_A = [output_time_record_A,time(time_A)+k + time_cost_A(time_A)];
        input_time_record_A = [input_time_record_A,time(time_A)+k];
        workshop_ind_record_A = [ workshop_ind_record_A ,free_id];
    end
end
% 将结果存到结构体中
for i = 1:length(input_time_record_A)
    df_A(i).input_time = input_time_record_A(i);
    df_A(i).output_time = output_time_record_A(i);
    df_A(i).repair_time =output_time_record_A(i) - input_time_record_A(i);
    df_A(i).workshop_ind = workshop_ind_record_A(i);
    df_A(i).out_ind  = in_ind_A(i);
end
%数据按出站时间升序排列
[~,sort_ind] = sort([df_A.output_time]);
df_A = df_A(sort_ind);
end