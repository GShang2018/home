## 前言

暑期数学建模已经接近尾声，淘汰赛进行到第二轮，这次的题目是**《动车组检修问题》**。题目一发出来后，按照惯例各种找资源、找文献。最后锁定了题目来源 [同济大学校内数模竞赛2019年 B题](http://math.tongji.edu.cn/model/tjjs2019B.html) , 仔细对比发现，题目在到站时间上略有区别。

<br/>

## 题目展示

动车组运用所是负责对动车进行检修、养护等工作的场所，全国已建成的动车 运用所已超过 50 个。动车组的检修根据行驶情况被划分成不同检修等级，不同 等级对应不同的工序。

<br/>

### 问题一

如图 1 所示，动车组的一次检修包括 a，b，c 三个工序。每个工序拥有的作业车 间和需要花费的时间如表 1 所示，相同工序不同车间的耗费时间相同。动车组按 a→b→c 顺序进行检修，完成一个检修工序后驶入下一个有空闲位置的车间进行 下一个检修工序，若下一个工序所有车间都处于占用状态，则动车组需要在上一 个车间中等待。动车运用所某 12 小时内每十五分钟来 1 辆待检修的动车，按照 目前的车间设置，维修完所有这些动车组总共需要多长时间？请给出安排检修的 最佳方案。假设第一辆动车组抵达动车运用所时，所有检修车间都是空闲的，且 车间之间的转换时间忽略不计。 

![](http://math.tongji.edu.cn/model/docs/tjjs2019B.jpg)

<center> 图1 检修工序 </center>

<br/>

<center> 表1 检修基础数据 </center>

| 工序类别             | a    | b    | c    |
| -------------------- | ---- | ---- | ---- |
| **车间数量（个）**   | 3    | 8    | 5    |
| **耗费时间（小时）** | 1    | 2    | 1.5  |

<br/>

### 问题二

事实上，如表2所示，不同类型的动车组每个工序需要花费的时间是不一样的。请根据附件中附表一到达动车运用所的动车信息，计算维修完这些动车的总时间。

<center> 表2 检修基础数据 </center>

| 动车类别 \ 工序类别 | a    | b    | c    |
| ------------------- | ---- | ---- | ---- |
| CRH2                | 1    | 2    | 1.5  |
| CRH3                | 0.8  | 2.4  | 0.5  |
| CRH5                | 1.3  | 2.5  | 1.5  |
| CRH6                | 1    | 2.7  | 0.3  |

<br/>

<center> 附表一 </center>

| 到站时间 | 动车类别 |
| -------- | -------- |
| 00:16    | CRH2     |
| 00:47    | CRH5     |
| 01:22    | CRH2     |
| 02:00    | CRH6     |
| 02:21    | CRH3     |
| 03:02    | CRH6     |
| 03:31    | CRH2     |
| 03:59    | CRH5     |
| 04:04    | CRH3     |
| 04:27    | CRH3     |
| 05:09    | CRH6     |

<br/>

### 问题三

根据列车的行驶时间、历程和检修周期，动车组的检修被划分成不同检修等级 I~V，如表 3 不同的检修等级对应不同的工序组合。工序 d 与 e 分别设有车间 3 和 2 个，相同工序不同车间的耗费时间相同。表 4 为不同动车类别的每个工序需 要耗费的时间。根据附表二的到所列车信息，计算检修完这些列车需要的总时间 是多少？

<center> 表3 检修等级 </center>

| 检修等级 | 对应工序组合      |
| -------- | ----------------- |
| Ⅰ        | a → b             |
| Ⅱ        | a → b → c         |
| Ⅲ        | a → b → d         |
| Ⅳ        | a → c → d → e     |
| Ⅴ        | a → b → c → d → e |

<br/>

<center> 表4 检修基础数据 </center>

| 动车类别 \ 工序类别 | a    | b    | c    | d    | e    |
| ------------------- | ---- | ---- | ---- | ---- | ---- |
| CRH2                | 1    | 2    | 1.5  | 4    | 7    |
| CRH3                | 0.8  | 2.4  | 0.5  | 4.8  | 6.5  |
| CRH5                | 1.3  | 2.5  | 1.5  | 3    | 6    |
| CRH6                | 1    | 2.7  | 0.3  | 5    | 7    |

<br/>

<center> 附表二 </center>

| 到站时间 | 动车类别 | 检修类型 |
| -------- | -------- | -------- |
| 0:16     | CRH2     | Ⅳ        |
| 0:47     | CRH5     | Ⅱ        |
| 1:22     | CRH2     | Ⅱ        |
| 2:00     | CRH6     | Ⅰ        |
| 2:20     | CRH3     | Ⅲ        |
| 3:05     | CRH6     | Ⅱ        |
| 3:31     | CRH2     | Ⅴ        |

<br/>

## 解题思路

### 解题目标

根据题目所述场景，列车按照到站时刻表依次进入到 A 工序各车间进行检修。若 A 工序车间满了，则需要等待。检修完后，列车又会先后离开 A 工序的各个车间。然后再先后抵达 B 工序各个车间进行检修，然后先后离开B 车间，再先后进入 C 工序车间，最后先后离开C 工序车间。而C工序车间里最后一辆车离开车间时，标志着检修任务完成。我们就是要让最后一辆车的离开时间尽可能地早，缩短检修总耗时。

![1566302880562](https://www.kanjiantu.com/images/2019/08/20/1566302880562b179b4cdad1f08f7.png)

<center>列车进站检修示意图</center>
<br/>
### 从进出站时间入手

仔细观察并思考，就会发现，其实对于每个工序来说，都存在列车进站时间和出站时间。对于A 工序来说，进站时间由题目所给到站时间表决定，这是已知条件。而A 工序的出站时间，是由检修调度安排决定的，但无论怎样，列车都会检修完立马离开工序车间。于是这里有会有一个出站时间。对于B 工序车间来说，先离开A 工序车间的列车，必然先到达B工序车间。A工序车间的出站时间就可以等同于B工序车间的进站时间（这里可以先不管车间，只考虑工序，因为工序是总的进出）。同理，B 的出站时间也是C的进站时间。最后C的出站时间也将计算出来，这样一环套一环地去计算，题目就解出来了。

<br/>

### 确定编程框架

不难发现，通过上面的分析，我们将三个工序都抽象成了同一个对象，那就是，给定一个进站时间，安排检修排队策略，最后输出出站时间。这就是总体的编程的思路！

![1566304422353](https://www.kanjiantu.com/images/2019/08/20/1566304422353d6619a6fe986d8a5.png)



<center>总体编程思路流程</center>

<br/>

### 各工序车间检修安排策略

根据上面的流程图，每个车间都需要依据进站时间安排检修，当车间有空闲时，可以安排检修；而当车间无空闲时，则需要等待，直至有空闲的车间出现，如此循环往复，直到所有列车全部检修完毕，该工序就可以输出出站时间了。这里有这么几个问题需要用代码实现判断:

- 如何确定当前工序的车间是否有空闲？
- 如何表示列车等待过程，时间怎么计算？
- 如何计算列车的出站时间？
- 列车在哪个车间维修，怎么记录？

<br/>

以上问题，都是检修安排策略的主要问题。我们来整理下编程思路：

首先，列车是按时序来进站的，如何来表示时序？没错，给定一个数组，数组元素编号就可以表示是第几分钟了（这里的时间单位可以是分钟也可以是刻钟，即15分钟，问题一中就是15分钟为一个单位考虑，问题二三则以1分钟为单位考虑）。同理，车间也可以用这样一个数组表示。考虑问题时，这二者是要结合在一起的。因为在某个时刻，1车间占用，那么就需要考虑去2车间，若也占用，那就去3车间，再找不到，那就只好去下一个时刻了，依旧判断1车间还在占用没，若占用，去2车间，... 总会找到某个时刻某个车间是空闲的，此时就安排检修。于是该车间的后续几个时刻都将会被占用。这里可以用一个二维数组来记录上述情形。

![1566305718611](https://www.kanjiantu.com/images/2019/08/20/15663057186112afda3497da2d732.png)

<center>时间-车间 记录矩阵</center>

给一个M*3的二维矩阵，这里M足够大，因为由于等待，M不知道要要多大，所以尽量大一些，比如1000（15分钟为单位）。

<br/>

第一辆车来的时候，如下图所示：

![](https://www.kanjiantu.com/images/2019/08/20/15663062351753672e10721b86401.png)

<center>第一辆车来时的时间-车间记录矩阵</center>

第一个15分钟，车间全是0，表示全是空闲，于是就安排上了，放在第一个车间检修。

第二辆车来的时候：

![](https://www.kanjiantu.com/images/2019/08/20/1566306255586ddab4b2d51445454.png)

<center>第二辆车来时的时间-车间记录矩阵</center>

此时，第二个15分钟时，第一趟车已经在检修，所以占了连续15*4=60分钟的车间使用时长，于是只好考虑去二车间。

同理，画出第三辆车的情况：

![1566306495974](https://www.kanjiantu.com/images/2019/08/20/1566306495974cee63cbb905a8a4e.png)

<center>第三辆车来时的时间-车间记录矩阵</center>

到了第四辆车来的时候，就出现问题了，此时三个车间全满，只好去下一个时刻找空位（图中时间占用没画完整）：

![1566306610156](https://www.kanjiantu.com/images/2019/08/20/1566306610156a9c44c014c7692f1.png)

<center>第四辆车来时的时间-车间记录矩阵</center>

这就是排队等待策略！以上过程通过循环来写。判断每一个时刻下，该行为0的所有列，然后将找到的第一个0，作为安排检修的对象，将该列后续的维修时长个数的值全置为1，表示占用。当找不到为0的列时，则自动跳到下一个时刻继续找，直到找到为止。然后下一辆车继续，...... 需要注意的是，起始时刻是由列车的进站时间来决定的，也就是说从第几个行开始查找。这里可以考虑将列车的进站时间写成一个数组，按编号读取到的时间也就是第几辆车的进站时间。此外，这里找空闲车间的策略是以最小号为选择对象，即找到的不为1的序列中最小的列号对应车间为当前安排的车间序号。

一直循环下去当然得有一个停止条件，那就是车辆全部检修完毕，车间空闲时。因此还需要写一个记录检修完成计数矩阵。

<br/>

总的来说，编程的思路是这样的流程：

![1566307122747](https://www.kanjiantu.com/images/2019/08/20/1566307122747357f6514b0092b3d.png)

<center>算法流程图</center>

最后一定要将出站时间升序排列！！因为原则是先到先检修，时间最短，有可能你先进站，结果你后出站，下一工序时，你就不是最前面检修的对象了。做升序排列目的是让时间重新恢复递增状态，这样才能完成两个工序之间的交接了。

<br/>

以上算法采取的是每一步都按照最优的策略去安排检修，是一种贪婪算法。整体算法流程如下：

![1566307724314](https://www.kanjiantu.com/images/2019/08/20/1566307724314b11d4a303b1266b2.png)

<center>模型流程图</center>

<br/>

## 问题解答

有了以上分析后，其实问题一二三都是同一类问题。

- 对于问题一，列车进站时间均匀间隔，每15分钟一趟，每辆车在同一工序的耗时一样，属于最特殊的一种情形。
- 对于问题二，列车进站时间不再均匀，且耗时不一样，但这并不影响模型的整体框架，我们只需要将车次和维修时间绑定在一起，来什么车就按照什么车的时间安排占位长度。
- 对于问题三，列车进站时间不同，耗时不一样，车间增加，维修等级还决定了什么车间去，什么车间不去。看似十分复杂，但是稍加修改就可以继续使用所建立的模型。将车次、耗时、维修等级全部绑定在一起，如果按照等级不去某个车间，则将车间耗时记作0即可，照样可以得到各车间，各个时刻，各个车次的维修耗时。
<br/>

### 问题一答案

#### 甘特图

![](https://www.kanjiantu.com/images/2019/08/20/imagefc12502ab55963e2.png)

列车进出站时间表太长了，在这里就不贴了。
#### 检修耗时
根据模型计算，考虑从0点列车进站，到最后一辆车出站，全部检修完需要 (80*15-0)/60 = 20 个小时，届时已经是20:00。

<br/>

### 问题二答案

#### 甘特图

![](https://www.kanjiantu.com/images/2019/08/20/image1f2bf615f9c1b2e6.png)

#### 列车进出站时间表

| 列车编号 | A工序进站时间 | A工序出站时间 | B工序进站时间 | B工序出站时间 | C工序进站时间 | C工序出站时间 |
| -------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| R1       | 0:16          | 1:16          | 1:16          | 3:16          | 3:16          | 4:46          |
| R2       | 0:47          | 2:05          | 2:05          | 4:35          | 4:35          | 6:05          |
| R3       | 1:22          | 2:22          | 2:22          | 4:22          | 4:22          | 5:52          |
| R4       | 2:00          | 3:00          | 3:00          | 5:42          | 5:42          | 6:00          |
| R5       | 2:21          | 3:09          | 3:09          | 5:33          | 5:33          | 6:03          |
| R6       | 3:02          | 4:02          | 4:02          | 6:44          | 6:44          | 7:02          |
| R7       | 3:31          | 4:31          | 4:31          | 6:31          | 6:31          | 8:01          |
| R8       | 3:59          | 5:17          | 5:17          | 7:47          | 7:47          | 9:17          |
| R9       | 4:04          | 4:52          | 4:52          | 7:16          | 7:16          | 7:46          |
| R10      | 4:32          | 5:20          | 5:20          | 7:44          | 7:44          | 8:14          |
| R11      | 5:09          | 6:09          | 6:09          | 8:51          | 8:51          | 9:09          |

#### 检修耗时
根据模型计算，考虑从00:16列车进站，到最后一辆车出站，全部检修完需要 557 - 16 = 541 分钟，届时已经是09:17。
<br/>

### 问题三答案

#### 甘特图

![](https://www.kanjiantu.com/images/2019/08/20/imagecf705309f192ea8e.png)

#### 列车进出站时刻表

| 列车编号 | A工序进站时间 | A工序出站时间 | B工序进站时间 | B工序出站时间 | C工序进站时间 | C工序出站时间 | D工序进站时间 | D工序出站时间 | E工序进站时间 | E工序出站时间 |
| -------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| R1       | 0:16          | 1:16          | 1:16          | 1:16          | 1:16          | 2:46          | 2:46          | 6:46          | 6:46          | 13:46         |
| R2       | 0:47          | 2:05          | 2:05          | 4:35          | 4:35          | 6:05          | 6:05          | 6:05          | 6:05          | 6:05          |
| R3       | 1:22          | 2:22          | 2:22          | 4:22          | 4:22          | 5:52          | 5:52          | 5:52          | 5:52          | 5:52          |
| R4       | 2:00          | 3:00          | 3:00          | 5:42          | 5:42          | 5:42          | 5:42          | 5:42          | 5:42          | 5:42          |
| R5       | 2:20          | 3:08          | 3:08          | 5:32          | 5:32          | 5:32          | 5:32          | 10:20         | 10:20         | 10:20         |
| R6       | 3:05          | 4:05          | 4:05          | 6:47          | 6:47          | 7:05          | 7:05          | 7:05          | 7:05          | 7:05          |
| R7       | 3:31          | 4:31          | 4:31          | 6:31          | 6:31          | 8:01          | 8:01          | 12:01         | 12:01         | 19:01         |

#### 检修耗时
根据模型计算，考虑从00:16列车进站，到最后一辆车出站，全部检修完需要 1141 - 16 = 1125分钟，届时已经是19:01。
<br/>

## 源码展示

### 贪婪算法模型代码

```matlab
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
```

<br/>

### 问题三代码

由于问题 一、二、三具有相似性，而问题三最具复杂性，所以给出问题三的代码，其他两问稍作精简和修改即可使用，代码如下：

```matlab
%% 准备存储空间
clc , clear , close all;

%% 变量初始化

[~,~,time ]= xlsread('列车信息.xlsx','列车时刻表');
[~,~,time_cost ]= xlsread('列车信息.xlsx','列车检修耗时表');
[~,~,rank ]= xlsread('列车信息.xlsx','检修等级');

train_time = cell2mat(time(2:end,2)); % 列车发车时间
train_id = cell2mat(time(2:end,4)); % 列车编号
train_rank = cell2mat(time(2:end,6));% 列车检修类型
time_cost = cell2mat(time_cost(2:end,2:end))*60; % 列车检修耗时
rank = cell2mat(rank(2:end,2:end)); % 检修类型检修路径


% 各工序检修耗时（单位：1分钟）

time_cost_A = time_cost(train_id,1).*rank(train_rank,1);
time_cost_B = time_cost(train_id,2).*rank(train_rank,2);
time_cost_C = time_cost(train_id,3).*rank(train_rank,3);
time_cost_D = time_cost(train_id,4).*rank(train_rank,4);
time_cost_E = time_cost(train_id,5).*rank(train_rank,5);


n_car = length(train_time); % 计算检修车辆数

% 各工序车间数
n_workshop_A = 3;
n_workshop_B = 8;
n_workshop_C = 5;
n_workshop_D = 3;
n_workshop_E = 2;

%% 计算 A 车间的检修情况
df_A = mygreedy3(train_time,n_workshop_A,time_cost_A,n_car,1:n_car);

%% 计算 B 车间的检修情况
df_B = mygreedy3(cat(1,df_A.output_time),n_workshop_B,time_cost_B,n_car,cat(1,df_A.out_ind));

%% 计算 C 车间的检修情况
df_C = mygreedy3(cat(1,df_B.output_time),n_workshop_C,time_cost_C,n_car,cat(1,df_B.out_ind));

%% 计算 D 车间的检修情况
df_D = mygreedy3(cat(1,df_C.output_time),n_workshop_D,time_cost_D,n_car,cat(1,df_C.out_ind));

%% 计算 E 车间的检修情况
df_E = mygreedy3(cat(1,df_D.output_time),n_workshop_E,time_cost_E,n_car,cat(1,df_D.out_ind));

%% 整理各列车进出时间
clear R
for i = 1:n_car
    R(i).A= df_A(find([df_A.out_ind]==i));
    R(i).B= df_B(find([df_B.out_ind]==i));
    R(i).C= df_C(find([df_C.out_ind]==i));
    R(i).D= df_D(find([df_D.out_ind]==i));
    R(i).E= df_E(find([df_E.out_ind]==i));
end

%% 结果输出
time_max = max (cat(1,df_E.output_time));
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
        train_io{i,8} = 'D工序进站时间';
        train_io{i,9} = 'D工序出站时间';
        train_io{i,10} = 'E工序进站时间';
        train_io{i,11} = 'E工序出站时间';
    else
        train_io{i,1}= sprintf('R%d',i-1);
        train_io{i,2} =min2time(R(i-1).A.input_time);
        train_io{i,3} =min2time(R(i-1).A.output_time);
        train_io{i,4} =min2time(R(i-1).B.input_time);
        train_io{i,5} =min2time(R(i-1).B.output_time);
        train_io{i,6} =min2time(R(i-1).C.input_time);
        train_io{i,7} =min2time(R(i-1).C.output_time);
        train_io{i,8} =min2time(R(i-1).D.input_time);
        train_io{i,9} =min2time(R(i-1).D.output_time);
        train_io{i,10} =min2time(R(i-1).E.input_time);
        train_io{i,11} =min2time(R(i-1).E.output_time);
    end
end
xlswrite('列车进出站时刻表',train_io,'Sheet1')
%% 画甘特图
figure;
set(gcf,'outerposition',get(0,'screensize'));
for i = 1:n_car
    rectangle('position',[(R(i).A.input_time) , (R(i).A.workshop_ind-1), (R(i).A.repair_time) ,1]...
        ,'linewidth',0.5,'facecolor',[146,208,80]/255)
    text( (R(i).A.input_time+R(i).A.repair_time/4) , (R(i).A.workshop_ind-1+0.5) , sprintf('R%d-A%d',i,R(i).A.workshop_ind))
    
    rectangle('position',[(R(i).B.input_time) , (R(i).B.workshop_ind + 3 -1), ...
        (R(i).B.repair_time) , 1 ],'linewidth',0.5,'facecolor',[0,176,240]/255)
    text( (R(i).B.input_time+R(i).B.repair_time/4) , (R(i).B.workshop_ind-1 + 3 +0.5) , sprintf('R%d-B%d',i,R(i).B.workshop_ind))
    
    rectangle('position',[(R(i).C.input_time) , (R(i).C.workshop_ind + 3+ 5  -1) , ...
        (R(i).C.repair_time) , 1 ],'linewidth',0.5,'facecolor',[255,192,0]/255)
    text((R(i).C.input_time+R(i).C.repair_time/4) , (R(i).C.workshop_ind-1 + 3 + 5  +0.5) ,sprintf('R%d-C%d',i,R(i).C.workshop_ind))
    
    rectangle('position',[(R(i).D.input_time) , (R(i).D.workshop_ind + 3+5+3  -1) , ...
        (R(i).D.repair_time) , 1 ],'linewidth',0.5,'facecolor',[198,89,17]/255)
    text((R(i).D.input_time+R(i).D.repair_time/4) , (R(i).D.workshop_ind-1 + +3+5+3  +0.5) ,sprintf('R%d-D%d',i,R(i).D.workshop_ind))
    
    rectangle('position',[(R(i).E.input_time) , (R(i).E.workshop_ind + 3+5+3+3 -1 ) , ...
        (R(i).E.repair_time) , 1 ],'linewidth',0.5,'facecolor',[112,48,160]/255)
    text((R(i).E.input_time+R(i).E.repair_time/4) , (R(i).E.workshop_ind-1 + 3+5+3+3  +0.5) ,sprintf('R%d-E%d',i,R(i).E.workshop_ind))
    
end
workname = {'',...
    '工序A-车间1','工序A-车间2','工序A-车间3',...
    '工序B-车间1','工序B-车间2','工序B-车间3','工序B-车间4','工序B-车间5',...
    '工序C-车间1','工序C-车间2','工序C-车间3',...
    '工序D-车间1','工序D-车间2','工序D-车间3',...
    '工序E-车间1','工序E-车间2','工序E-车间3'
    };
xlabel('时间（单位：1分钟）')
set(gca,'xtick',0:60:1200,'ytick',[0,0.5:16.5],'yticklabel',workname,'fontsize',24)

saveas(gcf,'问题三列车检修甘特图.tif')
```

<br/>

代码中的表格 [点击查看](https://kdocs.cn/el/ex0vtww) （请勿随意改动数据！！）
<br/>
几个表格的数据是这样的：

<center>列车时刻表</center>

| 到站时间 | 数值时间 | 动车类别 | 列车编号 | 检修类型 | 检修等级 |
| -------- | -------- | -------- | -------- | -------- | -------- |
| 0:16     | 16       | CRH2     | 1        | IV       | 4        |
| 0:47     | 47       | CRH5     | 3        | II       | 2        |
| 1:22     | 82       | CRH2     | 1        | II       | 2        |
| 2:00     | 120      | CRH6     | 4        | I        | 1        |
| 2:20     | 140      | CRH3     | 2        | III      | 3        |
| 3:05     | 185      | CRH6     | 4        | II       | 2        |
| 3:31     | 211      | CRH2     | 1        | V        | 5        |

<br/>

<center>列车检修耗时表</center>

|      | a    | c    | b    | d    | e    |
| ---- | ---- | ---- | ---- | ---- | ---- |
| CRH2 | 1    | 1.5  | 2    | 4    | 7    |
| CRH3 | 0.8  | 0.5  | 2.4  | 4.8  | 6.5  |
| CRH5 | 1.3  | 1.5  | 2.5  | 3    | 6    |
| CRH6 | 1    | 0.3  | 2.7  | 5    | 7    |

<br/>

<center>检修等级</center>

| 检修等级 | 工序A | 工序B | 工序C | 工序D | 工序E |
| -------- | ----- | ----- | ----- | ----- | ----- |
| I        | 1     | 1     | 0     | 0     | 0     |
| II       | 1     | 1     | 1     | 0     | 0     |
| III      | 1     | 1     | 0     | 1     | 0     |
| IV       | 1     | 0     | 1     | 1     | 1     |
| V        | 1     | 1     | 1     | 1     | 1     |

<br/>

### 分钟转时间函数

```matlab
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
```

<br/>
## Github项目
完整源码已上传Github项目，[点击查看](https://github.com/GShang2018/gshang.github.io/tree/master/%E5%8A%A8%E8%BD%A6%E7%BB%84%E6%A3%80%E4%BF%AE%E9%97%AE%E9%A2%98)。
<br/>

## 后记

这次是我第一次使用结构体来编程，感觉matlab真的很好用。我觉得作为建模编程人员一定要熟悉matlab中的矩阵、元胞数组、结构体、类的用法，能够对数据按要求导入导出，并且模型代码尽可能模块化，减少冗余。
<br/>
