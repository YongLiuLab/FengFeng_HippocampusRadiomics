   clear;clc
% %PCA��ά������492*491�����ж����ɷֽ�������
addpath('C:\Users\Kunzh\Desktop\20200112\Classification\LDA')
load('C:\Users\Kunzh\Desktop\20200112\Classification\IN_ADNI\label_adni');
load('C:\Users\Kunzh\Desktop\20200112\Classification\IN_ADNI\label');
load('C:\Users\Kunzh\Desktop\20200112\Classification\IN_ADNI\data_all');
load('C:\Users\Kunzh\Desktop\20200112\Classification\IN_ADNI\data_adni');
data_inad = [data_all;data_adni];
label_inad = [label;label_adni'];
%[data1,PS]=mapminmax(data,0,1)
options = [ ];
options.PCARatio = 1 ;
[eigvector, eigvalue, meanData, data] = PCA(data_inad, options);


train_data = data(1:length(label),:);
test_data = data(length(label)+1:end,:);
test_label = label_adni;
train_label = label;
for i =4
    [model,k,ClassLabel]=LDATraining(train_data(:,1:i),train_label);
    [tmp,target]=LDATesting(test_data(:,1:i),k,model,ClassLabel);
    [TP,TN,FN,FP] = conclusion(target,test_label);
    SEN(i) = TP / (TP + FN);
    SPE(i) = TN / (TN + FP);
    ACC(i) = (TP + TN) / (TP + FP + FN + TN);
    [auc(i), curve] = rocplot(tmp(:,1)-tmp(:,2), test_label, 1, 0);
end

    
