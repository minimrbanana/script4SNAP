%% load .txt files and form .mat files
dataPath = '/home/yu/datasets/SNAP/Autonomous_systems_graphs/txt/';
savePath = '/home/yu/datasets/SNAP/Autonomous_systems_graphs/mat/';

txtList=dir(dataPath);
txtList(1:2)=[];
%% parameter

for i=1:1
    dataDir=[dataPath txtList(i).name];
    fid = fopen(dataDir);
    %% if not Location_social_networks, skip first 4 lines
    C=textscan(fid,'%f%f%f','Headerlines',4);
    %% if Location_social_networks, include first 4 lines
    %C=textscan(fid,'%f%f');
    fclose(fid);
    % form 2 vectors of nodes from data C
    v1 = C{1,1};
    v2 = C{1,2};
    l=size(v1,1);
    [c,ia,ic] = unique([v1;v2]);
    ic1=ic(1:l);ic2=ic(l+1:2*l);
    A = sparse(ic1,ic2,-1);
    d = size(A,1);
    A=spdiags(zeros(d,1),0,A);
    diagonal = -sum(A);
    A = spdiags(diagonal',0,A);
    save([savePath txtList(i).name(1:end-4) '.mat'], 'A');
    fprintf('file %d saved\n',i);
end
for i=2:size(txtList,1)
    dataDir=[dataPath txtList(i).name];
    fid = fopen(dataDir);
    %% if not Location_social_networks, skip first 4 lines
    C=textscan(fid,'%f%f','Headerlines',4);
    %% if Location_social_networks, include first 4 lines
    %C=textscan(fid,'%f%f');
    fclose(fid);
    % form 2 vectors of nodes from data C
    v1 = C{1,1};
    v2 = C{1,2};
    l=size(v1,1);
    [c,ia,ic] = unique([v1;v2]);
    ic1=ic(1:l);ic2=ic(l+1:2*l);
    A = sparse(ic1,ic2,-1);
    [d1,d2]=size(A);
    if d1>d2
        A=[A,zeros(d1,d1-d2)];
    else if d1<d2
            A=[A;zeros(d2-d1,d2)];
        end
    end
    d = size(A,1);
    A=min(A,A');
    A=spdiags(zeros(d,1),0,A);
    diagonal = -sum(A);
    A = spdiags(diagonal',0,A);
    save([savePath txtList(i).name(1:end-4) '.mat'], 'A');
    fprintf('file %d saved\n',i);
end
% p=symamd(A);
% B=A(p,p);
% spy(A);
