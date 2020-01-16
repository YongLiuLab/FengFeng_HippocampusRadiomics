%%
   clear;clc
% %PCA��ά������492*491�����ж����ɷֽ�������
load('E:\previous_work_brainnetome\MCAD\reviewer_add\LDA\intra_site\label');
load('E:\previous_work_brainnetome\MCAD\reviewer_add\LDA\intra_site\center');
load('E:\previous_work_brainnetome\MCAD\reviewer_add\LDA\intra_site\data_all');
%[data1,PS]=mapminmax(data,0,1)
options = [ ];
options.PCARatio = 1 ;
[eigvector, eigvalue, meanData, data] = PCA(data_all, options);


%ѭ����pca��ǰ50ά������Щά��Ч�����
for i = 1:1000
    train_data = [];
    train_label = [];
    test_data = [];
    test_label = [];
    for j = 1:6
        center_data = data(find(center==j),:);
        center_label = label(find(center==j));
        test_indx = randperm(length(center_label),10);
        train_indx = setdiff(1:length(center_label),test_indx);
        train_data = [train_data;center_data(train_indx,:)];
        test_data = [test_data;center_data(test_indx,:)];
        train_label = [train_label;center_label(train_indx)];
        test_label = [test_label;center_label(test_indx)];
    end
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

    
