%% 准备存储空间
clc , clear , close all;

%% 变量初始化

n_car = 12*60/15; % 12小时共需要检修 48 辆动车

% 各工序车间数
n_workshop_A = 3;
n_workshop_B = 8;
n_workshop_C = 5;

% 各工序检修耗时（单位：15分钟）
time_cost_A = 4;
time_cost_B = 8;
time_cost_C = 6;

%% 计算 A 车间的检修情况
time = 1:10000;
df_A = mygreedy(time,n_workshop_A,time_cost_A,n_car);

%% 计算 B 车间的检修情况
df_B = mygreedy(cat(1,df_A.output_time)+1,n_workshop_B,time_cost_B,n_car);

%% 计算 C 车间的检修情况
df_C = mygreedy(cat(1,df_B.output_time)+1,n_workshop_C,time_cost_C,n_car);

%% 结果输出
time_max = max (cat(1,df_C.output_time))*15/60;
fprintf('列车全部检修完毕需要%d个小时,届时时间为%s(假设以0点起始发车)\n',time_max,min2time(max (cat(1,df_C.output_time))*15));

%% 画列车检修甘特图
figure;
set(gcf,'outerposition',get(0,'screensize'));
for i = 1:n_car
    rectangle('position',[(df_A(i).input_time) , (df_A(i).workshop_ind-1), (time_cost_A) ,1]...
    ,'linewidth',0.5,'facecolor',[146,208,80]/255)
    text( (df_A(i).input_time+time_cost_A/4) , (df_A(i).workshop_ind-1+0.5) , sprintf('R%d-A%d',i,df_A(i).workshop_ind))
    
    rectangle('position',[(df_B(i).input_time) , (df_B(i).workshop_ind + n_workshop_A -1), ...
        (time_cost_B) , 1 ],'linewidth',0.5,'facecolor',[0,176,240]/255)
    text( (df_B(i).input_time+time_cost_B/4) , (df_B(i).workshop_ind-1 + n_workshop_A +0.5) , sprintf('R%d-B%d',i,df_B(i).workshop_ind))
    
    rectangle('position',[(df_C(i).input_time) , (df_C(i).workshop_ind + n_workshop_A + n_workshop_B -2 -1) , ...
        (time_cost_C) , 1 ],'linewidth',0.5,'facecolor',[255,192,0]/255)
    text((df_C(i).input_time+time_cost_C/4) , (df_C(i).workshop_ind-1 + n_workshop_A + n_workshop_B-2 +0.5) ,sprintf('R%d-C%d',i,df_C(i).workshop_ind))
end

workname = {'',...
    '工序A-车间1','工序A-车间2','工序A-车间3',...
    '工序B-车间1','工序B-车间2','工序B-车间3','工序B-车间4','工序B-车间5','工序B-车间6'...
    '工序C-车间1','工序C-车间2','工序C-车间3','工序C-车间4','工序C-车间5'...
    };
xlabel('时间（单位：15分钟）')
set(gca,'xtick',0:4:81,'ytick',[0,0.5:1:14],'yticklabel',workname,'fontsize',24)
saveas(gcf,'问题一列车检修甘特图.tif')

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
        train_io{i,2} = min2time (df_A(i-1).input_time*15);
        train_io{i,3} = min2time (df_A(i-1).output_time*15);
        train_io{i,4} = min2time (df_B(i-1).input_time*15);
        train_io{i,5} = min2time (df_B(i-1).output_time*15);
        train_io{i,6} = min2time (df_C(i-1).input_time*15);
        train_io{i,7} = min2time (df_C(i-1).output_time*15);
    end
end

xlswrite('列车进出站时刻表',train_io,'Sheet1')