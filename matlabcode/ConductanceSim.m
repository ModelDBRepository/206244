% Plot conductance dependence of simulated Ca2+-inhibition
% ---
% Fiona Müllner, MPI Neurobiology
% Email: fiona.muellner at gmail.com

clearvars -except rootfolder
cd(sprintf('%s\\CA1_multi\\experiment\\regular',rootfolder))
load('Branch type.mat')
list=dir('simulationRes*');
figure
for i=1:size(list,1)
    clearvars -except list i tag rootfolder
    load(list(i,1).name); 
    
    posv1=posv;
    distv1 = [distv(1:n/2)',distv(1:n/2)'];
    fbp=find(branchid(1:n/2-1)>1,1,'first')+1;
    if isempty(fbp)
        chan=n/2+1:n;
    else
        chan=n/2+1:n/2+fbp-1;
    end
    dist = distv1(chan);
    [~,s]=sort(dist);
    pos1=1; 
    yvect = dist(s)-posv1(pos1);
    
    mv=zeros(length(condv),1);
    for cond1=1:length(condv)
        time=1:length(timev);
        temp=1-squeeze(M(pos1,cond1,time,chan(s))./M(pos1,1,time,chan(s)));
        [mv(cond1,1),mp]=max(temp(:));
        [ix,iy] = ind2sub(size(temp),mp);
    end
    if exist('tag','var')
        ho = plot(condv*1000,mv'*100,'-','color',[0.5*tag(i) 1-0.5*tag(i) 0.5]);
    else
        ho = plot(condv*1000,mv'*100,'-');
    end
    
    hold all

end
xlabel('Conductance [nS]')
ylabel('% Inhibition')

