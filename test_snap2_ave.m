function test_snap2_ave(matClass,Mat)
%% test_cvxbqp1
% with amd and rcm, rand and randn of b
%% set path of loading and saving
addpath ../../BCD
dataDir=['/home/yu/datasets/SNAP/' matClass '/mat/' Mat '.mat'];
saveDir=['/home/yu/bcd/SNAP/plot_result/' Mat '/b22/'];
if ~exist(['/home/yu/datasets/SNAP/' matClass '/mat/'],'dir')
    error('matClass input error');
end
if ~exist(saveDir,'dir')
    mkdir(saveDir);
end
logfilename='2.log';
fid = fopen([saveDir logfilename],'w+');
fprintf(fid,'matClass: %s\nMat: %s\n',matClass,Mat);
fclose(fid);
% refine matList
%% set parameters
N=10;
l=0;
u=1;
pre1=1E-10;
iters = 2E7;
%%
rng(1)
%% load data and reordering
load (dataDir);
% add lambda*I to A
d = size(A,1);
D=spdiags(ones(d,1)*1E-5,0,d,d);
A=A+D;
% first do amd reordering
p1=symamd(A);
A_amd=A(p1,p1);
% second rcm reordering
p2=symrcm(A);
A_rcm=A(p2,p2);
  

% #epoch mat A
epoch1_0 = zeros(N,1);epoch1_1 = zeros(N,1);epoch1_5 = zeros(N,1);
epoch2_0 = zeros(N,1);epoch2_1 = zeros(N,1);epoch2_5 = zeros(N,1);
epoch3_0 = zeros(N,1);epoch3_1 = zeros(N,1);epoch3_5 = zeros(N,1);
% #epoch mat A amd
epoch1a_0 = zeros(N,1);epoch1a_1 = zeros(N,1);epoch1a_5 = zeros(N,1);
epoch2a_0 = zeros(N,1);epoch2a_1 = zeros(N,1);epoch2a_5 = zeros(N,1);
epoch3a_0 = zeros(N,1);epoch3a_1 = zeros(N,1);epoch3a_5 = zeros(N,1);
% #epoch mat A rcm
epoch1r_0 = zeros(N,1);epoch1r_1 = zeros(N,1);epoch1r_5 = zeros(N,1);
epoch2r_0 = zeros(N,1);epoch2r_1 = zeros(N,1);epoch2r_5 = zeros(N,1);
epoch3r_0 = zeros(N,1);epoch3r_1 = zeros(N,1);epoch3r_5 = zeros(N,1);
for i=1:N
    % set b1 b2 b3
    x=rand(d,1);
    % x2 in [-0.5,1.5]
    x2=2.0*x-0.5;
    b2=A*x2;
    b=b2;
    b1_amd=b(p1);
    b1_rcm=b(p2);
    %% first run with b1 -> [0.1,0.9], compare block size123
    % A,A_amd,A_rcm,b1,init:0,0.5,1
    %% run original matrix with init 0
    init=l;
    [~, c0y1] = CBCD1(A, b, d, iters,pre1,l,u,init);
    [~, c0y2] = CBCD2(A, b, d, iters,pre1,l,u,init);
    [~, c0y3] = CBCD3(A, b, d, iters,pre1,l,u,init);
    epoch1_0(i)=length(c0y1);
    epoch2_0(i)=length(c0y2);
    epoch3_0(i)=length(c0y3);
    %% run original matrix with init 1
    init=u;
    [~, c1y1] = CBCD1(A, b, d, iters,pre1,l,u,init);
    [~, c1y2] = CBCD2(A, b, d, iters,pre1,l,u,init);
    [~, c1y3] = CBCD3(A, b, d, iters,pre1,l,u,init);
    epoch1_1(i)=length(c1y1);
    epoch2_1(i)=length(c1y2);
    epoch3_1(i)=length(c1y3);
    %% run original matrix with init 0.5
    init=(l+u)/2;
    [~, c5y1] = CBCD1(A, b, d, iters,pre1,l,u,init);
    [~, c5y2] = CBCD2(A, b, d, iters,pre1,l,u,init);
    [~, c5y3] = CBCD3(A, b, d, iters,pre1,l,u,init);
    epoch1_5(i)=length(c5y1);
    epoch2_5(i)=length(c5y2);
    epoch3_5(i)=length(c5y3);
    disp('----------------------------------------');
    disp(['||EXP: ' Mat  '(b2); i=' num2str(i) '/' num2str(N) '; A done  ||']);
    disp('----------------------------------------');
    %% run matrix after amd with init 0
    init=l;
    [~, c0ay1] = CBCD1(A_amd, b1_amd, d, iters,pre1,l,u,init);
    [~, c0ay2] = CBCD2(A_amd, b1_amd, d, iters,pre1,l,u,init);
    [~, c0ay3] = CBCD3(A_amd, b1_amd, d, iters,pre1,l,u,init);
    epoch1a_0(i)=length(c0ay1);
    epoch2a_0(i)=length(c0ay2);
    epoch3a_0(i)=length(c0ay3);
    %% run matrix after amd with init 1
    init=u;
    [~, c1ay1] = CBCD1(A_amd, b1_amd, d, iters,pre1,l,u,init);
    [~, c1ay2] = CBCD2(A_amd, b1_amd, d, iters,pre1,l,u,init);
    [~, c1ay3] = CBCD3(A_amd, b1_amd, d, iters,pre1,l,u,init);
    epoch1a_1(i)=length(c1ay1);
    epoch2a_1(i)=length(c1ay2);
    epoch3a_1(i)=length(c1ay3);
    %% run matrix after amd with init 0.5
    init=(u+l)/2;
    [~, c5ay1] = CBCD1(A_amd, b1_amd, d, iters,pre1,l,u,init);
    [~, c5ay2] = CBCD2(A_amd, b1_amd, d, iters,pre1,l,u,init);
    [~, c5ay3] = CBCD3(A_amd, b1_amd, d, iters,pre1,l,u,init);
    epoch1a_5(i)=length(c5ay1);
    epoch2a_5(i)=length(c5ay2);
    epoch3a_5(i)=length(c5ay3);
    disp('----------------------------------------');
    disp(['||EXP: ' Mat  '(b2); i=' num2str(i) '/' num2str(N) '; A_amd done  ||']);
    disp('----------------------------------------');
    %% run matrix after rcm with init 0
    init=l;
    [~, c0ry1] = CBCD1(A_rcm, b1_rcm, d, iters,pre1,l,u,init);
    [~, c0ry2] = CBCD2(A_rcm, b1_rcm, d, iters,pre1,l,u,init);
    [~, c0ry3] = CBCD3(A_rcm, b1_rcm, d, iters,pre1,l,u,init);
    epoch1r_0(i)=length(c0ry1);
    epoch2r_0(i)=length(c0ry2);
    epoch3r_0(i)=length(c0ry3);
    %% run matrix after rcm with init 1
    init=u;
    [~, c1ry1] = CBCD1(A_rcm, b1_rcm, d, iters,pre1,l,u,init);
    [~, c1ry2] = CBCD2(A_rcm, b1_rcm, d, iters,pre1,l,u,init);
    [~, c1ry3] = CBCD3(A_rcm, b1_rcm, d, iters,pre1,l,u,init);
    epoch1r_1(i)=length(c1ry1);
    epoch2r_1(i)=length(c1ry2);
    epoch3r_1(i)=length(c1ry3);
    %% run matrix after rcm with init 0.5
    init=(u+l)/2;
    [~, c5ry1] = CBCD1(A_rcm, b1_rcm, d, iters,pre1,l,u,init);
    [~, c5ry2] = CBCD2(A_rcm, b1_rcm, d, iters,pre1,l,u,init);
    [~, c5ry3] = CBCD3(A_rcm, b1_rcm, d, iters,pre1,l,u,init);
    epoch1r_5(i)=length(c5ry1);
    epoch2r_5(i)=length(c5ry2);
    epoch3r_5(i)=length(c5ry3);
    disp('----------------------------------------');
    disp(['||EXP: ' Mat  '(b2); i=' num2str(i) '/' num2str(N) '; A_rcm done  ||']);
    disp('----------------------------------------');

    %log file
    fid = fopen([saveDir logfilename],'a');
    fprintf(fid,'%s\n',datestr(now,0)); 
    fprintf(fid,'exp No. %d finished.\n',i);
    fclose(fid);
end
    %log file
    fid = fopen([saveDir logfilename],'a');
    fprintf(fid,' N=%d.\n l=%d.\n u=%d.\n pre1=%.10f.\n maxIter=%.10f\n',...
        N,l,u,pre1,iters);
    fclose(fid);
    %% save 
    % mat A
    epoch2o1_0=epoch2_0./epoch1_0;
    epoch2o1_1=epoch2_1./epoch1_1;
    epoch2o1_5=epoch2_5./epoch1_5;
    epoch3o1_0=epoch3_0./epoch1_0;
    epoch3o1_1=epoch3_1./epoch1_1;
    epoch3o1_5=epoch3_5./epoch1_5;
    % mat A amd
    epoch2o1a_0=epoch2a_0./epoch1a_0;
    epoch2o1a_1=epoch2a_1./epoch1a_1;
    epoch2o1a_5=epoch2a_5./epoch1a_5;
    epoch3o1a_0=epoch3a_0./epoch1a_0;
    epoch3o1a_1=epoch3a_1./epoch1a_1;
    epoch3o1a_5=epoch3a_5./epoch1a_5;
    % mat A rcm
    epoch2o1r_0=epoch2r_0./epoch1r_0;
    epoch2o1r_1=epoch2r_1./epoch1r_1;
    epoch2o1r_5=epoch2r_5./epoch1r_5;
    epoch3o1r_0=epoch3r_0./epoch1r_0;
    epoch3o1r_1=epoch3r_1./epoch1r_1;
    epoch3o1r_5=epoch3r_5./epoch1r_5;
    Epoch=[epoch1_0,epoch2_0,epoch3_0,epoch1_1,epoch2_1,epoch3_1,...
        epoch1_5,epoch2_5,epoch3_5,epoch1a_0,epoch2a_0,epoch3a_0,...
        epoch1a_1,epoch2a_1,epoch3a_1,epoch1a_5,epoch2a_5,epoch3a_5,...
        epoch1r_0,epoch2r_0,epoch3r_0,epoch1r_1,epoch2r_1,epoch3r_1,...
        epoch1r_5,epoch2r_5,epoch3r_5];
    save([saveDir 'exp.mat'],...
        'epoch2o1_0','epoch2o1_1','epoch2o1_5',...
        'epoch3o1_0','epoch3o1_1','epoch3o1_5',...
        'epoch2o1a_0','epoch2o1a_1','epoch2o1a_5',...
        'epoch3o1a_0','epoch3o1a_1','epoch3o1a_5',...
        'epoch2o1r_0','epoch2o1r_1','epoch2o1r_5',...
        'epoch3o1r_0','epoch3o1r_1','epoch3o1r_5','Epoch');
    


end
