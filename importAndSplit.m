function dataTable = importAndSplit(filename, sheet, columnName)
    % 从 Excel 文件中读取数据
    opts = detectImportOptions(filename, 'Sheet', sheet);
    dataTable = readtable(filename, opts, 'Sheet', sheet);
    
    % 检查表格中是否存在指定的列
    if ~ismember(columnName, dataTable.Properties.VariableNames)
        error('指定的列名不存在于表格数据中。');
    end
    
    % 分割指定列的字符串，结果作为单元数组存储在新列中
    dataTable.SplitParts = cellfun(@(x) strsplit(x, '/'), dataTable.(columnName), 'UniformOutput', false);
end