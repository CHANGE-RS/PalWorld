function [num_operations, operations] = find_operations_to_target(input_numbers, target)
    % 将输入的整数排序
    numbers = sort(input_numbers);
    
    % 操作列表，用于记录每次操作
    operations = {};
    
    % 操作计数器
    num_operations = 0;
    
    % 循环直到数组中存在目标值
    while ~ismember(target, numbers)
        % 如果数组中所有数字都小于目标值
        if all(numbers < target)
            pair = [numbers(end-1), numbers(end)]; % 选取最大的两个数
        % 如果数组中所有数字都大于目标值
        elseif all(numbers > target)
            pair = [numbers(1), numbers(2)]; % 选取最小的两个数
        else
            % 找到小于等于目标值的最大数和大于目标值的最小数
            less_than_target = numbers(numbers <= target);
            greater_than_target = numbers(numbers > target);
            pair = [max(less_than_target), min(greater_than_target)];
        end
        
        % 计算平均值并向下取整
        avg = floor((pair(1) + pair(2)) / 2);
        
        % 避免死循环：如果平均值已经在数组中，则直接取最接近的两个数
        if ismember(avg, numbers)
            avg = pair(1); % 取小于等于目标值的数，保证能接近目标
        end
        
        % 记录操作
        operation = sprintf('平均 %d 和 %d 得到 %d', pair(1), pair(2), avg);
        operations{end+1} = operation;
        disp(operation);
        
        % 插入新的平均值，移除用过的值
        numbers = [numbers(numbers ~= pair(1)), numbers(numbers ~= pair(2)), avg];
        
        % 排序数组以便于下一次操作
        numbers = sort(numbers);
        
        % 增加操作计数
        num_operations = num_operations + 1;
    end
    
    % 如果操作列表是空的，说明目标值已经在输入数组中
    if isempty(operations)
        disp('目标值已经在输入数组中，无需操作。');
    end
end

