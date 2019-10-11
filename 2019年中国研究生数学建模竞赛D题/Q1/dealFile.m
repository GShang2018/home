function dealFile(filename)
% 载入数据
path = filename;
[~,~,data] = xlsread(path);
fprintf('%s导入成功！一共导入%d条数据\n',filename,length(data)-1);

% 时间对齐处理
data1 = timeAlign(data);

% 经纬度异常处理
data2  = locatErroDetct(data1);

% 长期停车不熄火处理
data3 = carStopDtect(data2);

% 堵车怠速处理
data4 = carTrafficDetect(data3);

% GPS短时丢失处理
data5 = gpsMissDetect(data4);

% 加速度异常处理
data6 = accelerateErrorDetect(data5);

% 速度异常处理
data7 = speedErrorDetect(data6);

% 毛刺异常处理
data8 = burrDetect(data7);

% 存储导出数据
datanew = data8;

% 保存异常数据处理后的数据
save([filename,'数据预处理后'],'datanew');

fprintf('%s数据预处理完成！\n',filename);
end
