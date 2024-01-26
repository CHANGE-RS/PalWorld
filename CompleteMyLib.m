function MyLib_New = CompleteMyLib(MyLib, Database)
% 假设 MyLib 和 Database 都已经是 MATLAB table 类型的变量。

% 检查 MyLib 中是否存在 'CnName' 列
if ~ismember('CnName', MyLib.Properties.VariableNames)
    error('MyLib 中不存在 CnName 列。');
end

% 检查 Database 中的所需列是否都存在
requiredColumns = {'CnName', 'BookID', 'RPD', 'IDX'};
for col = requiredColumns
    if ~ismember(col{1}, Database.Properties.VariableNames)
        error(['Database 中不存在列 ', col{1}, '。']);
    end
end

% 在 MyLib 中新增 'BookID', 'RPD', 'IDX' 列，并初始化为空
MyLib.BookID = NaN(height(MyLib), 1);
MyLib.RPD = NaN(height(MyLib), 1);
MyLib.IDX = NaN(height(MyLib), 1);

% 遍历 MyLib 表格中的每一行
for i = 1:height(MyLib)
    % 提取当前行的 CnName
    currentCnName = MyLib.CnName{i};
    
    % 在 Database 中查找匹配的 CnName 行
    matchIdx = find(strcmp(Database.CnName, currentCnName));
    
    % 如果找到匹配项，则搬运数据
    if ~isempty(matchIdx)
        MyLib.BookID(i) = Database.BookID(matchIdx);
        MyLib.RPD(i) = Database.RPD(matchIdx);
        MyLib.IDX(i) = Database.IDX(matchIdx);
    end
end

MyLib = sortrows(MyLib, 'RPD');
MyLib_New = MyLib;
% 显示添加了新列的 MyLib 表格
disp(MyLib);
end