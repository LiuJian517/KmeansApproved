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
E = pdist2(X,X);  % �ֱ�������
M = max(max(E));  % ѡȡ���ֵ

while cnt > 2  
    position = [];
    [i,j] = find(E == max(max(E)));
    i = i(1);
    j = j(1);     % ���ֵ�������жԳƵ�����
    [a,pos] = sort(E,2);
    
    t = 1;
    u = zeros(1,p);
    while a(i,t) <= M/K
        u = u + X(pos(i,t),:);  % ��¼�¾���С��M/K�ĵ�
        position = [position,pos(i,t)];  %��¼�¸õ���±��
        t = t+1;
    end
    ctrs(cnt,:) = u/(t-1);    % �õ�һ����������
    cnt = cnt-1;
    
    t = 1;
    u = zeros(1,p);
    while a(j,t) <= M/K
        u = u + X(pos(j,t),:);
        position = [position,pos(j,t)];
        t = t+1;
    end
    ctrs(cnt,:) = u/(t-1);   % �õ�һ����������
    cnt = cnt-1;
    
    E(position,:) = [];
    E(:,position) = [];  % ȥ������������ѱ����ֵĵ�
    X(position,:) = [];  % ��ԭ�������ѱ����ֵĵ�ȥ��

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
    ctrs(cnt,:) = sum(X)/size(X,1);  % ���ֻʣ���һ���أ�����ʣ�������ľ�ֵ
end

end
