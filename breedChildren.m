function updatedLib = breedChildren(resultTable, genes, MyLib)
    % 假设 genes 是 M x 1 的 cell，每个 cell 是 1 x N 的 cell
    % 假设 resultTable 是一个 table，包含至少 BookID, CnName, RPD, IDX 四列
    % 假设 MyLib 是之前的孩子库，一个 table，包含 BookID, CnName, RPD, IDX, SplitParts, SP, Gender 七列
    M =size(genes,1);
    % 初始化新孩子的数据表，预分配大小为 2M x 7
    childrenData = cell(2*M, 7);
    for i = 1:M
        % 对于每种基因，生成两个孩子
        for j = 1:2
            childIdx = (i-1)*2 + j; % 计算当前孩子在表中的索引
            childrenData{childIdx, 1} = resultTable.BookID; % 假设所有孩子相同的 BookID
            childrenData{childIdx, 2} = resultTable.CnName; % 假设所有孩子相同的 CnName
            childrenData{childIdx, 3} = resultTable.RPD;    % 假设所有孩子相同的 RPD
            childrenData{childIdx, 4} = resultTable.IDX;    % 假设所有孩子相同的 IDX
            childrenData{childIdx, 5} = genes{i};           % 分配基因
            childrenData{childIdx, 6} = strjoin(genes{i}, '/'); % 合并基因为一个字符串
            childrenData{childIdx, 7} = j - 1;              % 分配性别，0 或 1
        end
    end
    
    % 将数据转换为表格形式，并命名列
    newChildren = cell2table(childrenData, 'VariableNames', {'CnName', 'Gender', 'SP' , 'SplitParts','BookID', 'RPD', 'IDX'});
    
    % 将新孩子加入到之前的孩子库中
    updatedLib = [MyLib; newChildren];
end