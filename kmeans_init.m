function ctrs = kmeans_init(X, K)
%KMEANS K-Means clustering algorithm
%
%   Input: X - data point features, n-by-p maxtirx.
%          K - the number of clusters
%
%   OUTPUT:ctrs - cluster centers, K-by-p matrix.

[n,p] = size(X);
ctrs = zeros(K,p);
cnt = K;
E = pdist2(X,X);  % 分别计算距离
M = max(max(E));  % 选取最大值

while cnt > 2  
    position = [];
    [i,j] = find(E == max(max(E)));
    i = i(1);
    j = j(1);     % 最大值的坐标有对称的两个
    [a,pos] = sort(E,2);
    
    t = 1;
    u = zeros(1,p);
    while a(i,t) <= M/K
        u = u + X(pos(i,t),:);  % 记录下距离小于M/K的点
        position = [position,pos(i,t)];  %记录下该点的下标号
        t = t+1;
    end
    ctrs(cnt,:) = u/(t-1);    % 得到一个中心向量
    cnt = cnt-1;
    
    t = 1;
    u = zeros(1,p);
    while a(j,t) <= M/K
        u = u + X(pos(j,t),:);
        position = [position,pos(j,t)];
        t = t+1;
    end
    ctrs(cnt,:) = u/(t-1);   % 得到一个中心向量
    cnt = cnt-1;
    
    E(position,:) = [];
    E(:,position) = [];  % 去掉距离矩阵当中已被划分的点
    X(position,:) = [];  % 将原数据中已被划分的点去掉

end

if cnt == 2 
    position = [];
    [i,j] = find(E == max(max(E)));
    
    i = i(1);
    j = j(1);
    [a,pos] = sort(E,2);
    t = 1;
    u = zeros(1,p);
    while a(i,t) <= M/K
        u = u + X(pos(i,t),:);
        position = [position,pos(i,t)];
        t = t+1;
    end
    ctrs(cnt,:) = u/(t-1);
    cnt = cnt-1;
    
    E(position,:) = [];
    E(:,position) = [];
    X(position,:) = [];
   
    ctrs(cnt,:) = sum(X)/size(X,1); 
else
    ctrs(cnt,:) = sum(X)/size(X,1);  % 如果只剩最后一个簇，计算剩余向量的均值
end

end
