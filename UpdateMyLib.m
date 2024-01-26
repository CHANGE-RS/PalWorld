function MyLib = UpdateMyLib(MyLib, resultTable)
    % 验证 MyLib 和 resultTable 是否为 table 类型
    if ~istable(MyLib) || ~istable(resultTable)
        error('MyLib 和 resultTable 必须都是 table 类型');
    end

    % 确定 resultTable 中是否包含 MyLib 所有的列（除了 Gender）
    requiredColumns = setdiff(MyLib.Properties.VariableNames, {'Gender'});
    if ~all(ismember(requiredColumns, resultTable.Properties.VariableNames))
        error('resultTable 缺少必要的列');
    end

    % 初始化用于存放新行的表格
    newRows = table;

    % 对 resultTable 中的每一行进行操作
    for i = 1:height(resultTable)
        % 提取当前行
        currentRow = resultTable(i, :);

        % 创建两个新行，Gender 分别设置为 0 和 1
        newRowGender0 = [currentRow, table(0, 'VariableNames', {'Gender'})];
        newRowGender1 = [currentRow, table(1, 'VariableNames', {'Gender'})];

        % 将新行添加到 newRows 表中
        newRows = [newRows; newRowGender0; newRowGender1];
    end

    % 将新行添加到 MyLib 表中
    MyLib = [MyLib; newRows];
end