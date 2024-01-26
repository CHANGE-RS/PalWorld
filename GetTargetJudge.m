function Target = GetTargetJudge(targetCnName, dataTable)
    % Target: minvalue, isBigger(1:>, 0:>=), maxvalue, isLess(1:<,
    % 0:<=),centerValue
    isBigger = 1;
    isLess = 1;
    % 根据 RPD 列对表格进行排序
    sortedTable = sortrows(dataTable, 'RPD');
    
    % 查找与目标字符串匹配的 CnName 的索引
    targetIndex = find(strcmp(sortedTable.CnName, targetCnName));
    
    % 如果找到了匹配项，获取目标人及其前后的人的信息
    if ~isempty(targetIndex)
        % 初始化索引数组
        indices = targetIndex;
        
        % 如果目标前面有人，添加前面那个人的索引
        if targetIndex > 1
            indices = [targetIndex - 1; indices];
        end
        
        % 如果目标后面有人，添加后面那个人的索引
        if targetIndex < height(sortedTable)
            indices = [indices; targetIndex + 1];
        end
        
        % 提取相关行的信息
        resultTable = sortedTable(indices, :);
    else
        error('未找到名字匹配的目标。');
    end
    
    MinValue = (resultTable.RPD(1)+resultTable.RPD(2))/2;
    MaxValue = (resultTable.RPD(3)+resultTable.RPD(2))/2;
    
    if  resultTable.IDX(2)<resultTable.IDX(1)
        isBigger = 0;
    end
    
    if  resultTable.IDX(2)<resultTable.IDX(3)
        isLess = 0;
    end
    
    Target = [MinValue,isBigger,MaxValue, isLess,resultTable.RPD(2)];
end