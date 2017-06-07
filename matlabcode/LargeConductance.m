% Plot spatial profile of Ca2+-inhibition for strong Ca2+ inhibition (>0.5)
% ---
% Fiona Müllner, MPI Neurobiology
% Email: fiona.muellner at gmail.com

clearvars -except rootfolder
cd(sprintf('%s\\CA1_multi\\experiment\\regular',rootfolder))
list=dir('simulationRes*');

figure

for i=1:size(list,1)
    clearvars -except list i rootfolder
    load(list(i,1).name);
    distv1 = [distv(1:n/2)',distv(1:n/2)'];
    pos1=1;
    fbp=find(branchid(1:n/2-1)>1,1,'first')+1;
    if isempty(fbp)
        chan=n/2+1:n;
    else
        chan=n/2+1:n/2+fbp-1;
    end
    dist = distv1(chan);
    [~,s]=sort(dist);
    yvect = dist(s)-posv(pos1);
    cond1=length(condv);
    time=1:length(timev);
    Inh=1-squeeze(M(pos1,cond1,time,chan(s))./M(pos1,1,time,chan(s)));
    [mv,mp]=max(Inh(:));
    [ix,iy] = ind2sub(size(Inh),mp);
    if ~isnan(iy) && max(Inh(ix,:))>0.5
        plot(yvect,Inh(ix,:),'-');
        hold all
        xlim([-200,200])
    end
end

