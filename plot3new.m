%% plot errorbar
disp('Manually save the figure as pdf!'); 
Fsize=15;

list = dir('/home/yu/bcd/SNAP/plot_result/');
list(1:2)=[];

done_list=1:14;
string=cell(length(list),1);
figure(1),clf,grid on; set(gca,'fontsize',14);
colorList = [1 0 0; 1 0.5 0; 1 1 0; 0.5 1 0;...
             0 1 0; 0 1 0.5; 0 1 1; 0 0.5 1;...
             0 0 1; 0.5 0 1; 1 0 1; 1 0 0.5;...
             1 0.5 0.5; 0.5 0.5 0.5;];
for i=done_list%length(list)
    string{i} = list(i).name;
    load (['/home/yu/bcd/SNAP/plot_result/' list(i).name '/cover.mat']);
    load (['/home/yu/bcd/SNAP/plot_result/' list(i).name '/b33/exp.mat']); 

    figure(1),
    subplot(2,1,1),% size2, amd
    prc=prctile([[epoch2o1_0;epoch2o1_1;epoch2o1_5],[epoch2o1a_0;epoch2o1a_1;epoch2o1a_5]],[25 75],1);
    cover = [COVER(1,1),COVER(2,1)];
    mean_all = mean([[epoch2o1_0;epoch2o1_1;epoch2o1_5],[epoch2o1a_0;epoch2o1a_1;epoch2o1a_5]]);
    errorbar(cover,mean_all,prc(2,:)-mean_all,prc(1,:)-mean_all,'Color',colorList(i,:),'lineWidth',2);
    hold on;
    
    figure(2),
    subplot(2,1,1),% size3, amd
    prc=prctile([[epoch3o1_0;epoch3o1_1;epoch3o1_5],[epoch3o1a_0;epoch3o1a_1;epoch3o1a_5]],[25 75],1);
    cover = [COVER(1,2),COVER(2,2)];
    mean_all = mean([[epoch3o1_0;epoch3o1_1;epoch3o1_5],[epoch3o1a_0;epoch3o1a_1;epoch3o1a_5]]);
    errorbar(cover,mean_all,prc(2,:)-mean_all,prc(1,:)-mean_all,'Color',colorList(i,:),'lineWidth',2);
    hold on;
    
    figure(1),
    subplot(2,1,2),% size2, rcm
    prc=prctile([[epoch2o1_0;epoch2o1_1;epoch2o1_5],[epoch2o1r_0;epoch2o1r_1;epoch2o1r_5]],[25 75],1);
    cover = [COVER(1,1),COVER(3,1)];
    mean_all = mean([[epoch2o1_0;epoch2o1_1;epoch2o1_5],[epoch2o1r_0;epoch2o1r_1;epoch2o1r_5]]);
    errorbar(cover,mean_all,prc(2,:)-mean_all,prc(1,:)-mean_all,'Color',colorList(i,:),'lineWidth',2);
    hold on;
    
    figure(2),
    subplot(2,1,2),% size3, rcm
    prc=prctile([[epoch3o1_0;epoch3o1_1;epoch3o1_5],[epoch3o1r_0;epoch3o1r_1;epoch3o1r_5]],[25 75],1);
    cover = [COVER(1,2),COVER(3,2)];
    mean_all = mean([[epoch3o1_0;epoch3o1_1;epoch3o1_5],[epoch3o1r_0;epoch3o1r_1;epoch3o1r_5]]);
    errorbar(cover,mean_all,prc(2,:)-mean_all,prc(1,:)-mean_all,'Color',colorList(i,:),'lineWidth',2);
    hold on;
end
% title
figure(1),
subplot(2,1,1),
xlabel('elements in block 2/ NNZ');
ylabel('#epoch2/#epoch1');
title('Block size 2, amd');
grid on; set(gca,'fontsize',Fsize,'fontweight', 'bold');
axis([0 0.3 0.4 1.2]);
figure(2),
subplot(2,1,1),
xlabel('elements in block 3/ NNZ');
ylabel('#epoch3/#epoch1');
title('Block size 3, amd');
grid on; set(gca,'fontsize',Fsize,'fontweight', 'bold');
axis([0 0.3 0.4 1.2]);
figure(1),
subplot(2,1,2),
xlabel('elements in block 2/ NNZ');
ylabel('#epoch2/#epoch1');
title('Block size 2, rcm');
grid on; set(gca,'fontsize',Fsize,'fontweight', 'bold');
axis([0 0.3 0.4 1.2]);
figure(2),
subplot(2,1,2),
xlabel('elements in block 3/ NNZ');
ylabel('#epoch3/#epoch1');
title('Block size 3, rcm');
grid on; set(gca,'fontsize',Fsize,'fontweight', 'bold');
axis([0 0.3 0.4 1.2]);

figure(1),
legend(string{1}(1:end-8),string{2},string{3},string{4},string{5},string{6},string{7},...
    string{8},string{9}(1:end-8),string{10}(1:end-8),string{11},...
    'facebook','loc-brightkite','loc-gowalla');
set(gca,'fontsize',15,'fontweight', 'bold');

for i=done_list%length(list)
    string{i} = list(i).name;
    load (['/home/yu/bcd/SNAP/plot_result/' list(i).name '/cover.mat']);
    load (['/home/yu/bcd/SNAP/plot_result/' list(i).name '/b33/exp.mat']); 

    figure(1),
    subplot(2,1,1),% size2, amd
    prc=prctile([[epoch2o1_0;epoch2o1_1;epoch2o1_5],[epoch2o1a_0;epoch2o1a_1;epoch2o1a_5]],[25 75],1);
    cover = [COVER(1,1),COVER(2,1)];
    mean_all = mean([[epoch2o1_0;epoch2o1_1;epoch2o1_5],[epoch2o1a_0;epoch2o1a_1;epoch2o1a_5]]);
    errorbar(cover(1),mean_all(1),prc(2,1)-mean_all(1),prc(1,1)-mean_all(1),'Color',colorList(i,:),'Marker','o','lineWidth',2);
    errorbar(cover(2),mean_all(2),prc(2,2)-mean_all(2),prc(1,2)-mean_all(2),'Color',colorList(i,:),'MarkerFaceColor',colorList(i,:),'Marker','s','lineWidth',2);
    hold on;
    
    figure(2),
    subplot(2,1,1),% size3, amd
    prc=prctile([[epoch3o1_0;epoch3o1_1;epoch3o1_5],[epoch3o1a_0;epoch3o1a_1;epoch3o1a_5]],[25 75],1);
    cover = [COVER(1,2),COVER(2,2)];
    mean_all = mean([[epoch3o1_0;epoch3o1_1;epoch3o1_5],[epoch3o1a_0;epoch3o1a_1;epoch3o1a_5]]);
    errorbar(cover(1),mean_all(1),prc(2,1)-mean_all(1),prc(1,1)-mean_all(1),'Color',colorList(i,:),'Marker','o','lineWidth',2);
    errorbar(cover(2),mean_all(2),prc(2,2)-mean_all(2),prc(1,2)-mean_all(2),'Color',colorList(i,:),'MarkerFaceColor',colorList(i,:),'Marker','s','lineWidth',2);
    hold on;
    
    figure(1),
    subplot(2,1,2),% size2, rcm
    prc=prctile([[epoch2o1_0;epoch2o1_1;epoch2o1_5],[epoch2o1r_0;epoch2o1r_1;epoch2o1r_5]],[25 75],1);
    cover = [COVER(1,1),COVER(3,1)];
    mean_all = mean([[epoch2o1_0;epoch2o1_1;epoch2o1_5],[epoch2o1r_0;epoch2o1r_1;epoch2o1r_5]]);
    errorbar(cover(1),mean_all(1),prc(2,1)-mean_all(1),prc(1,1)-mean_all(1),'Color',colorList(i,:),'Marker','o','lineWidth',2);
    errorbar(cover(2),mean_all(2),prc(2,2)-mean_all(2),prc(1,2)-mean_all(2),'Color',colorList(i,:),'MarkerFaceColor',colorList(i,:),'Marker','s','lineWidth',2);
    hold on;
    
    figure(2),
    subplot(2,1,2),% size3, rcm
    prc=prctile([[epoch3o1_0;epoch3o1_1;epoch3o1_5],[epoch3o1r_0;epoch3o1r_1;epoch3o1r_5]],[25 75],1);
    cover = [COVER(1,2),COVER(3,2)];
    mean_all = mean([[epoch3o1_0;epoch3o1_1;epoch3o1_5],[epoch3o1r_0;epoch3o1r_1;epoch3o1r_5]]);
    errorbar(cover(1),mean_all(1),prc(2,1)-mean_all(1),prc(1,1)-mean_all(1),'Color',colorList(i,:),'Marker','o','lineWidth',2);
    errorbar(cover(2),mean_all(2),prc(2,2)-mean_all(2),prc(1,2)-mean_all(2),'Color',colorList(i,:),'MarkerFaceColor',colorList(i,:),'Marker','s','lineWidth',2);
    hold on;
end
