function childGenesCombinations = generateChildGenes(fatherGenes, motherGenes)

    % 假设 fatherGenes 或 motherGenes 可能包含非字符向量的元胞
    % 您可以通过以下代码确保它们都是字符向量的元胞数组
    fatherGenes = cellfun(@char, fatherGenes, 'UniformOutput', false);
    motherGenes = cellfun(@char, motherGenes, 'UniformOutput', false);
    % 合并父母的基因并去重
    uniqueGenes = unique([fatherGenes'; motherGenes']);
    
    % 计算孩子的基因数：是父母基因总数去重后的平均值向上取整
    numChildGenes = max(ceil(length(uniqueGenes) / 2),2);
    
    % 生成所有可能的基因组合
    geneIndicesCombinations = nchoosek(1:length(uniqueGenes), numChildGenes);
    
    % 转换索引组合回基因组合
    numCombinations = size(geneIndicesCombinations, 1);
    childGenesCombinations = cell(numCombinations, 1);
    
    for i = 1:numCombinations
        % 为每种组合创建一个 cell 数组
        childGenesCombinations{i} = uniqueGenes(geneIndicesCombinations(i, :));
        childGenesCombinations{i} = childGenesCombinations{i}';
    end
end