% Plot distance and spiketiming dependence of simulated Ca2+-inhibition
% ---
% Fiona Müllner, MPI Neurobiology
% Email: fiona.muellner at gmail.com

list=dir('simulationRes*');

cmap(1,:)=[0 1 0];
cmap(2,:)=[1 0 0];
cmap(3,:)=[0 0 1];
figure
maxinh = 0.3;
newx=cell(1,size(list,1));
resultv=cell(1,size(list,1));
for in=1:size(list,1)
    clearvars -except rootfolder list in maxinh timeval h k fitsingle tag cmap space newx resultv
    load(list(in,1).name);
    
    distv1 = [distv(1:n/2)',distv(1:n/2)'];
    posv1 = posv;
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
    conds = NaN;
    cond1 = 2;
    mv=0;
    ix=NaN;
    iy=NaN;
    while cond1<=length(condv) && mv<maxinh
        time=1:length(timev);
        temp=1-squeeze(M(pos1,cond1,time,chan(s))./M(pos1,1,time,chan(s)));
        [mv,mp]=max(temp(:));
        if mv<maxinh
            lastmv = mv;
            Inh = temp/mv;
            [ix,iy] = ind2sub(size(Inh),mp);
            conds = cond1;
        end
        cond1=cond1+1;
    end
    if ~isnan(iy)
        subplot(2,1,1)
        if exist('tag','var')
            plot(yvect,Inh(ix,:),'-','color',cmap(tag(in)+1,:));
        else
            plot(yvect,Inh(ix,:),'-');
        end
        newx{1,in}=yvect;
        resultv{1,in}=Inh(ix,:);
        hold all
        subplot(2,1,2)
        [~,mp]=max(Inh(:,iy));
        if exist('tag','var')
            plot(timev-timev(mp),Inh(:,iy),'-','color',cmap(tag(in)+1,:));
        else
            plot(timev-timev(mp),Inh(:,iy),'-');
        end
        hold all
    else
        disp(cd);        
        disp(filen);
    end
end



