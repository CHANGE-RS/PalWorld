function [minDistance, closestNumber] = compareClosest(floorNum1, floorNum2, target)
    % 先对两个数进行向下取整
    num1 = floor(floorNum1);
    num2 = floor(floorNum2);
    
    % 计算两个数与目标数的绝对差值
    distance1 = abs(target - num1);
    distance2 = abs(target - num2);
    
    % 比较两个距离，并返回最小距离及其对应的数
    if distance1 < distance2
        minDistance = distance1;
        closestNumber = num1;
    elseif distance2 < distance1
        minDistance = distance2;
        closestNumber = num2;
    else
        % 如果距离相等，返回两者中较小的一个数和距离
        minDistance = distance1; % distance2 也一样
        closestNumber = min(num1, num2);
    end
end