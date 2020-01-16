%%
   clear;clc
   addpath('E:\previous_work_brainnetome\MCAD\reviewer_add\LDA')
% %PCA��ά������492*491�����ж����ɷֽ�������
load('E:\previous_work_brainnetome\MCAD\reviewer_add\LDA\inter_site\label');
load('E:\previous_work_brainnetome\MCAD\reviewer_add\LDA\inter_site\center');
load('E:\previous_work_brainnetome\MCAD\reviewer_add\LDA\inter_site\data_all');
%[data1,PS]=mapminmax(data,0,1)
options = [ ];
options.PCARatio = 1 ;
[eigvector, eigvalue, meanData, data] = PCA(data_all, options);


%ѭ����pca��ǰ50ά������Щά��Ч�����
for i = 1:6
    train_data = data(find(center~=i),:);
    train_label = label(find(center~=i),:);
    test_data = data(find(center==i),:);
    test_label = label(find(center==i),:);
    
    for fea =5
        [model,k,ClassLabel]=LDATraining(train_data(:,1:fea),train_label);
        [tmp,target]=LDATesting(test_data(:,1:fea),k,model,ClassLabel);
        [TP,TN,FN,FP] = conclusion(target,test_label);
        SEN(i) = TP / (TP + FN);
        SPE(i) = TN / (TN + FP);
        ACC(i) = (TP + TN) / (TP + FP + FN + TN);
        [auc(i), curve] = rocplot(tmp(:,1)-tmp(:,2), test_label, 1, 0);
    end
end

    
