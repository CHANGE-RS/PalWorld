%test
% tic
clc
clear
input_numbers = [1,2, 5, 23 3, 10]; % 你的N个整数
gender = [1,1,0,1,1,0];
target = 12; % 你的目标整数X
% [num_operations, operations] = find_operations_to_target(input_numbers, target);
[can_reach, best_pair] = can_reach_target(input_numbers, target, gender);
% fprintf('需要的操作次数: %d\n', num_operations);
disp(best_pair)
%%

% 设置目标中文字符串
% targetCnName = '皮皮鸡';
% load('Database.mat')
% % 调用函数
% resultTable = GetTargetJudge(targetCnName, Database)
clc



% % % 设置 Excel 文件名和工作表
% % filename = 'MyLibrary.xlsx';
% % sheet = 1; % 或者是您的工作表的名字，比如 'Sheet1'
% % columnName = 'SP'; % 替换为您需要分割的列名
% % 
% % % 调用函数
% % dataTable = importAndSplit(filename, sheet, columnName);
% % 
% % % 查看结果
% % disp(dataTable);

%%
% load('Database.mat');
% resultTable = WhoIsChild(Database, 1111);
% disp(resultTable);
% 
% MyLib = UpdateMyLib(MyLib, resultTable)

%%
toc