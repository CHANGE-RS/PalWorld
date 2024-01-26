function  [hasAllGenes, missingGenes, geneCounts] = checkForTargetGenes(table, targetGenes)
% % % 所有基因在同一个个体上的代码：
% %     % 将目标基因字符串分割为单独的基因
% %     targetGenesArray = strsplit(targetGenes, '/');
% %     
% %     % 初始化标志，假设没有找到所有基因
% %     hasAllGenes = false;
% %     
% %     % 获取SplitParts列的数据
% %     splitPartsData = table.SplitParts;
% %     
% %     % 遍历SplitParts的每个单元格
% %     for i = 1:height(table)
% %         % 获取当前单元格中的基因列表
% %         currentGenes = splitPartsData{i};
% %         
% %         % 检查是否所有目标基因都在当前单元格中
% %         if all(ismember(targetGenesArray, currentGenes))
% %             % 如果所有基因都找到了，设置标志为真并退出循环
% %             hasAllGenes = true;
% %             break;
% %         end
% %     end
%%%-----------------------------------------------
    % 将目标基因字符串分割为单独的基因
    targetGenesArray = strsplit(targetGenes, '/');
    
    % 初始化一个逻辑数组来追踪每个目标基因是否被找到
    foundGenes = false(size(targetGenesArray));
    
    % 初始化一个计数数组来统计每个目标基因出现的次数
    geneCounts = zeros(size(targetGenesArray));
    
    % 获取SplitParts列的数据
    splitPartsData = table.SplitParts;
    
    % 遍历SplitParts的每个单元
    for i = 1:height(table)
        % 获取当前单元格中的基因列表
        currentGenes = splitPartsData{i};
        
        % 检查目标基因是否在当前单元格中，并更新逻辑数组
        for j = 1:length(targetGenesArray)
            if ismember(targetGenesArray{j}, currentGenes)
                foundGenes(j) = true;
                geneCounts(j) = geneCounts(j) + 1;
            end
        end
        
        % 如果已经找到了所有目标基因，就不需要继续检查了
        if all(foundGenes)
            break;
        end
    end

    % 如果已经找到了所有目标基因，则返回true
    hasAllGenes = all(foundGenes);
    
    % 找出未找到的基因
    missingGenes = targetGenesArray(~foundGenes);
end