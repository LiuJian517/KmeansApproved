function [idx, ctrs,iter] = kmeans(X, K)
%KMEANS K-Means clustering algorithm
%
%   Input: X - data point features, n-by-p maxtirx.
%          K - the number of clusters
%
%   OUTPUT: idx  - cluster label
%           ctrs - cluster centers, K-by-p matrix.
%           iter
[n,p] =size(X);
out = randperm(n);
R = out(1:K); %生成N个随机数

iter = 1;
for j = 1:K
    ctrs(j,:) = X(R(j),:);  %随机选择K个初始均值向量
end;
    
while true
    %划分簇
    for i = 1:n
        temp = pdist2(X(i,:),ctrs);
        [a,pos] = sort(temp,2);
        idx(i) = pos(1);
    end
    %更新均值向量
    flag = 0;
    ctrs_temp = zeros(1,p);
    for i = 1:K
        cnt = 0;
        for j = 1:n
            if idx(j) == i
                ctrs_temp = ctrs_temp + X(j,:);
                cnt = cnt + 1;
            end
        end
        ctrs_temp = ctrs_temp/cnt;
        if isequal(ctrs_temp,ctrs(i,:)) == 0
            ctrs(i,:) = ctrs_temp;
            flag = 1;
        end
    end
    %判断是否当前均值向量均未更新
    if flag == 0;
        break;
    end;
    iter = iter + 1; 
end

end
