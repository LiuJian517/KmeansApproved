%%
img = imread('panda.jpg');
fea = double(reshape(img, size(img, 1)*size(img, 2), 3)); %fea�Ǹ�RGBֵ�ľ���

[idx, ctrs,iter] = kmeans_optimized(fea, 8);
% 
%����ά��RGBֵ��ɾ�ֵ����
for k = 1 : size(fea,1) 
    fea(k,:) = ctrs(idx(k),:);
end
img_out = uint8(reshape(fea, size(img)));
toc;

% imshow(uint8(reshape(fea, size(img))));
imwrite(img_out,'result2.jpg');
%%
tic;
img = imread('panda.jpg');
fea = double(reshape(img, size(img, 1)*size(img, 2), 3)); %fea�Ǹ�RGBֵ�ľ���

[idx, ctrs,iter] = kmeans(fea, 8);
% 
%����ά��RGBֵ��ɾ�ֵ����
for k = 1 : size(fea,1) 
    fea(k,:) = ctrs(idx(k),:);
end
img_out = uint8(reshape(fea, size(img)));
toc;

% imshow(uint8(reshape(fea, size(img))));
imwrite(img_out,'result.jpg');




