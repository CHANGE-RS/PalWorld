function resultTable = WhoIsChild(Database, ChildRPD)
    % 验证 Database 是否为 table
    if ~istable(Database)
        error('输入的 Database 必须是一个 table 类型');
    end

    % 验证 RPD 是否为数字
    if ~isnumeric(ChildRPD) || numel(ChildRPD) ~= 1
        error('RPD 必须是一个数字');
    end

    % 获取 Database 中 RPD 列的所有值
    RPD_values = Database.RPD;

    % 查找等于给定 RPD 的行
    exactMatch = RPD_values == ChildRPD;
    
    % 如果有确切匹配的 RPD 值，就直接返回匹配的行
    if any(exactMatch)
        resultTable = Database(exactMatch, :);
    else
        % 找出所有小于输入 RPD 的值，并取最大的一个（最接近的）
        lesser = RPD_values < ChildRPD;
        maxLesserValue = max(RPD_values(lesser));
        maxIdx = find(RPD_values == maxLesserValue);
        
        % 找出所有大于输入 RPD 的值，并取最小的一个（最接近的）
        greater = RPD_values > ChildRPD;
        minGreaterValue = min(RPD_values(greater));
        minIdx = find(RPD_values == minGreaterValue);
        
        % 判断Child是谁
        %如果距离相同则比较IDX，否则用close函数判断
        if ChildRPD == (maxLesserValue+minGreaterValue)/2
            % 比较这两个值并返回较小值的索引
            if Database.IDX(minIdx) < Database.IDX(maxIdx)
                idxOfSmallerValue = minIdx;
            else
                idxOfSmallerValue = maxIdx;
            end
            resultTable = Database(idxOfSmallerValue, :);
        else
            [~, closestPal] = compareClosest(maxLesserValue, minGreaterValue, ChildRPD);
            resultTable = Database(RPD_values == closestPal, :);
        end
            
    end
end