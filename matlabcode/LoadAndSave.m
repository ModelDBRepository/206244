% Load Neuron simulation data and extract basic information
% ---
% Fiona Müllner, MPI Neurobiology
% Email: fiona.muellner at gmail.com

% [filen,pathn] = uigetfile('simulationData_*.dat');
A=dlmread(strcat(pathn,'\',filen));
B=dlmread(strcat(pathn,'\',regexprep(filen,'Data','Data_param')));
B=B(:,1:end-1);
n=B(1,end); % number of recordings (chan)
branchid=A(1:n,end-1);
distv=A(1:n,end-2);
timeref=A(2:end-2,end-3);

ni=B(2,end); % numi, recording pos (pos)
nj=B(3,end); % numj, timing (time)
nk=B(4,end); % numk, conductance (cond)


stimstart=B(1,1);
posv=B(2,1:nj*nk:nj*nk*ni);
timev=B(3,1:nj);
condv=B(4,1:nj:nj*nk);
if size(B,1)>4
    excv=B(5,1:nj*nk:nj*nk*ni);
end


baseStart = 2;
baseEnd = find(timeref<min(stimstart(1),timev(1)),1,'last');
M=zeros(ni,nk,nj,n);
for chan = 1:n
    for time = 1:nj
        for cond = 1:nk
            for pos = 1:ni
                temp = A(2:end-2,(pos-1)*nk*nj*n + (cond-1)*nj*n + (time-1)*n + chan);
                M(pos,cond,time,chan) = ...
                max(temp) - mean(temp(baseStart:baseEnd));
            end
        end
    end
end

clear pos time chan cond


