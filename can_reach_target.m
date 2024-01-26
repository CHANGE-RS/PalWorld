function [can_reach, output_best_pair] = can_reach_target(numbers, target, gender)
    % 确保gender的长度与numbers一致
    if length(gender) ~= length(numbers)
        error('The length of gender must match the length of numbers.');
    end
    
    % 创建一个结构数组来保存 numbers 和 gender，以及原始索引
    for i = 1:length(numbers)
        num_struct(i).value = numbers(i);
        num_struct(i).gender = gender(i);
        num_struct(i).index = i;
    end
    
    % 根据 value 对结构数组进行升序排序
    [~, order] = sort([num_struct.value]);
    sorted_struct = num_struct(order);
    
    NumNew = arrayfun(@(x) x.value, sorted_struct);
    GenderNew = arrayfun(@(x) x.gender, sorted_struct);
    IdxNew = arrayfun(@(x) x.index, sorted_struct);
    
    % 分为大于目标的 A 组和小于等于目标的 B 组, 同时记录各自的索引
    A_idxs = find(NumNew > target);
    B_idxs = find(NumNew <= target);
    A = NumNew(A_idxs);
    B = NumNew(B_idxs);
    A_genders = GenderNew(A_idxs);
    B_genders = GenderNew(B_idxs);
    
    can_reach = false; % 初始化表示是否能直接得到目标的变量
    reach_pair = []; % 初始化满足条件的配对集合
    best_pair = []; % 初始化最佳配对矩阵，使用NaN填充
    best_pair_all = [];
    
    if length(B) > length(A)
        
        % 遍历 B 组
        for i = 1:length(B)
            best_diff_i = inf; % 初始化当前 B(i) 的最佳差值为无穷大
            % 对于每个 B 中的数，遍历 A 组
            for j = 1:length(A)
                % 首先判断性别是否相异
                if B_genders(i) ~= A_genders(j)
                    avg = floor((B(i) + A(j)) / 2);
                    diff = abs(target - avg);
                    % 如果平均值等于目标，保存配对及其索引
                    if avg == target
                        can_reach = true;
                        reach_pair = [reach_pair; B(i), A(j), IdxNew(B_idxs(i)), IdxNew(A_idxs(j))];
                    % 不管avg在左还是右，diff小就更新,且直接替换之前的
                    elseif diff < best_diff_i
                        best_pair = [B(i), A(j), IdxNew(B_idxs(i)), IdxNew(A_idxs(j))];
                        best_diff_i = diff;
                    % 相同的diff则叠加保存
                    elseif diff == best_diff_i
                        best_pair = [best_pair; B(i), A(j), IdxNew(B_idxs(i)), IdxNew(A_idxs(j))];
                        best_diff_i = diff;
                    elseif (diff > best_diff_i) && (avg > target)
                        break;
                    end
                end
            end
            best_pair_all = [best_pair_all;best_pair];
        end
    else
        % 遍历 A 组
        for j = 1:length(A)
        best_diff_i = inf; % 初始化当前 B(i) 的最佳差值为无穷大
        % 遍历 A 中的每个B
            for i = 1:length(B)
                % 首先判断性别是否相异
                if B_genders(i) ~= A_genders(j)
                    avg = floor((B(i) + A(j)) / 2);
                    diff = abs(target - avg);
                    % 如果平均值等于目标，保存配对及其索引
                    if avg == target
                        can_reach = true;
                        reach_pair = [reach_pair; B(i), A(j), IdxNew(B_idxs(i)), IdxNew(A_idxs(j))];
                    % 不管avg在左还是右，diff小就更新,且直接替换之前的
                    elseif diff < best_diff_i
                        best_pair = [B(i), A(j), IdxNew(B_idxs(i)), IdxNew(A_idxs(j))];
                        best_diff_i = diff;
                    % 相同的diff则叠加保存
                    elseif diff == best_diff_i
                        best_pair = [best_pair; B(i), A(j), IdxNew(B_idxs(i)), IdxNew(A_idxs(j))];
                        best_diff_i = diff;
                    elseif (diff > best_diff_i) && (avg < target)
                        break;
                    end
                end
            end
            best_pair_all = [best_pair_all;best_pair];
        end
    end
    
    % 输出结果
    if can_reach
        output_best_pair = reach_pair; % 如果找到匹配的，只输出匹配的配对
    else
        output_best_pair = best_pair_all; % 如果没有找到匹配的，输出每个 B 对应的最佳 A 配对
    end

end