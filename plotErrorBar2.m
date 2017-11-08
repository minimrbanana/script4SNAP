%% plot errorbar
list = dir('/home/yu/bcd/SNAP/plot_result/');
list(1:2)=[];

done_list=1:14;
string=cell(length(list),1);
figure(1),clf,grid on; set(gca,'fontsize',14);
for i=done_list%length(list)
    string{i} = list(i).name;
    load (['/home/yu/bcd/SNAP/plot_result/' list(i).name '/cover.mat']);
    load (['/home/yu/bcd/SNAP/plot_result/' list(i).name '/b22/exp.mat']); 

    subplot(2,2,1),% size2, amd
    prc=prctile([epoch2o1_0,epoch2o1_1,epoch2o1_5,epoch2o1a_0,epoch2o1a_1,epoch2o1a_5],[25 75],1);
    cover = [COVER(1,1),COVER(1,1),COVER(1,1),COVER(2,1),COVER(2,1),COVER(2,1)];
    mean_all = mean([epoch2o1_0,epoch2o1_1,epoch2o1_5,epoch2o1a_0,epoch2o1a_1,epoch2o1a_5]);
    errorbar(cover,mean_all,prc(2,:)-mean_all,prc(1,:)-mean_all);
    hold on;
    subplot(2,2,2),% size3, amd
    prc=prctile([epoch3o1_0,epoch3o1_1,epoch3o1_5,epoch3o1a_0,epoch3o1a_1,epoch3o1a_5],[25 75],1);
    cover = [COVER(1,2),COVER(1,2),COVER(1,2),COVER(2,2),COVER(2,2),COVER(2,2)];
    mean_all = mean([epoch3o1_0,epoch3o1_1,epoch3o1_5,epoch3o1a_0,epoch3o1a_1,epoch3o1a_5]);
    errorbar(cover,mean_all,prc(2,:)-mean_all,prc(1,:)-mean_all);
    hold on;
    subplot(2,2,3),% size2, rcm
    prc=prctile([epoch2o1_0,epoch2o1_1,epoch2o1_5,epoch2o1r_0,epoch2o1r_1,epoch2o1r_5],[25 75],1);
    cover = [COVER(1,1),COVER(1,1),COVER(1,1),COVER(3,1),COVER(3,1),COVER(3,1)];
    mean_all = mean([epoch2o1_0,epoch2o1_1,epoch2o1_5,epoch2o1r_0,epoch2o1r_1,epoch2o1r_5]);
    errorbar(cover,mean_all,prc(2,:)-mean_all,prc(1,:)-mean_all);
    hold on;
    subplot(2,2,4),% size3, rcm
    prc=prctile([epoch3o1_0,epoch3o1_1,epoch3o1_5,epoch3o1r_0,epoch3o1r_1,epoch3o1r_5],[25 75],1);
    cover = [COVER(1,2),COVER(1,2),COVER(1,2),COVER(3,2),COVER(3,2),COVER(3,2)];
    mean_all = mean([epoch3o1_0,epoch3o1_1,epoch3o1_5,epoch3o1r_0,epoch3o1r_1,epoch3o1r_5]);
    errorbar(cover,mean_all,prc(2,:)-mean_all,prc(1,:)-mean_all);
    hold on;
end
% title
subplot(2,2,1),
xlabel('elements in block 2/ NNZ');
ylabel('#epoch2/#epoch1');
title('Block size 2, amd');
grid on; set(gca,'fontsize',14);
axis([0 0.3 0.4 1.2]);
subplot(2,2,2),
xlabel('elements in block 3/ NNZ');
ylabel('#epoch3/#epoch1');
title('Block size 3, amd');
grid on; set(gca,'fontsize',14);
axis([0 0.3 0.4 1.2]);
subplot(2,2,3),
xlabel('elements in block 2/ NNZ');
ylabel('#epoch2/#epoch1');
title('Block size 2, rcm');
grid on; set(gca,'fontsize',14);
axis([0 0.3 0.4 1.2]);
subplot(2,2,4),
xlabel('elements in block 3/ NNZ');
ylabel('#epoch3/#epoch1');
title('Block size 3, rcm');
grid on; set(gca,'fontsize',14);
axis([0 0.3 0.4 1.2]);

% ax(1)=subplot(2,2,1);ax(2)=subplot(2,2,2);
% ax(3)=subplot(2,2,3);ax(4)=subplot(2,2,4);
% linkaxes(ax)



legend(string{1},string{2},string{3},string{4},string{5},string{6},string{7},...
    string{8},string{9},string{10},string{11},...
    'facebook-combined','loc-brightkite-edges','loc-gowalla-edges');


