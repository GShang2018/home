%% 准备存储空间
clc , clear , close all;

%% 变量初始化

[~,~,train_time ]= xlsread('列车信息.xlsx','列车时刻表');
[~,~,train_time_cost ]= xlsread('列车信息.xlsx','列车检修耗时表');

time = cell2mat(train_time(2:12,2)); % 列车发车时间
train_id = cell2mat(train_time(2:12,4)); % 列车编号
time_cost = cell2mat(train_time_cost(2:end,2:end))*60; % 列车检修耗时


n_car = length(time); % 计算检修车辆数

% 各工序车间数
n_workshop_A = 3;
n_workshop_B = 8;
n_workshop_C = 5;

% 各工序检修耗时（单位：1分钟）
time_cost_A = time_cost(train_id,1);
time_cost_B = time_cost(train_id,2);
time_cost_C = time_cost(train_id,3);

%% 计算 A 车间的检修情况
df_A = mygreedy2(time,n_workshop_A,time_cost_A,n_car,1:n_car);

%% 计算 B 车间的检修情况
df_B = mygreedy2(cat(1,df_A.output_time),n_workshop_B,time_cost_B,n_car,cat(1,df_A.out_ind));

%% 计算 C 车间的检修情况
df_C = mygreedy2(cat(1,df_B.output_time),n_workshop_C,time_cost_C,n_car,cat(1,df_B.out_ind));

%% 整理各列车进出时间
clear R
for i = 1:n_car
    R(i).A= df_A(find([df_A.out_ind]==i));
    R(i).B= df_B(find([df_B.out_ind]==i));
    R(i).C= df_C(find([df_C.out_ind]==i));
end

%% 结果输出
time_max = max (cat(1,df_C.output_time));
time_min = min (cat(1,df_A.input_time));
fprintf('列车全部检修完毕需要%d分钟，届时为  %s\n',time_max - time_min,min2time(time_max));

%% 计算列车的进出站时刻表
for i = 1:n_car+1
    if i == 1
        train_io{i,1} = '列车编号';
        train_io{i,2} = 'A工序进站时间';
        train_io{i,3} = 'A工序出站时间';
        train_io{i,4} = 'B工序进站时间';
        train_io{i,5} = 'B工序出站时间';
        train_io{i,6} = 'C工序进站时间';
        train_io{i,7} = 'C工序出站时间';
    else
     train_io{i,1}= sprintf('R%d',i-1);
     train_io{i,2} =min2time(R(i-1).A.input_time);
    train_io{i,3} =min2time(R(i-1).A.output_time);
    train_io{i,4} =min2time(R(i-1).B.input_time);
    train_io{i,5} =min2time(R(i-1).B.output_time);
    train_io{i,6} =min2time(R(i-1).C.input_time);
    train_io{i,7} =min2time(R(i-1).C.output_time);
    end
end
xlswrite('列车进出站时刻表',train_io,'Sheet1')
%%画甘特图
figure;
set(gcf,'outerposition',get(0,'screensize'));
for i = 1:n_car
    rectangle('position',[(R(i).A.input_time) , (R(i).A.workshop_ind-1), (R(i).A.repair_time) ,1]...
        ,'linewidth',0.5,'facecolor',[146,208,80]/255)
    text( (R(i).A.input_time+R(i).A.repair_time/4) , (R(i).A.workshop_ind-1+0.5) , sprintf('R%d-A%d',i,R(i).A.workshop_ind))

    rectangle('position',[(R(i).B.input_time) , (R(i).B.workshop_ind + n_workshop_A -1), ...
        (R(i).B.repair_time) , 1 ],'linewidth',0.5,'facecolor',[0,176,240]/255)
    text( (R(i).B.input_time+R(i).B.repair_time/4) , (R(i).B.workshop_ind-1 + n_workshop_A +0.5) , sprintf('R%d-B%d',i,R(i).B.workshop_ind))


    rectangle('position',[(R(i).C.input_time) , (R(i).C.workshop_ind + n_workshop_A + n_workshop_B -1 -1) , ...
        (R(i).C.repair_time) , 1 ],'linewidth',0.5,'facecolor',[255,192,0]/255)
    text((R(i).C.input_time+R(i).C.repair_time/4) , (R(i).C.workshop_ind-1 + n_workshop_A + n_workshop_B-1 +0.5) ,sprintf('R%d-C%d',i,R(i).C.workshop_ind))
end
workname = {'',...
    '工序A-车间1','工序A-车间2','工序A-车间3',...
    '工序B-车间1','工序B-车间2','工序B-车间3','工序B-车间4','工序B-车间5','工序B-车间6','工序B-车间7'...
    '工序C-车间1','工序C-车间2','工序C-车间3','工序C-车间4'...
    };
xlabel('时间（单位：1分钟）')
set(gca,'xtick',0:60:600,'ytick',[0,0.5:1:14],'yticklabel',workname,'fontsize',24)

saveas(gcf,'问题二列车检修甘特图.tif')
