% Compare Ca2+-inhibition in spine and shaft for increasing excitatory
% conductances
% ---
% Fiona Müllner, MPI Neurobiology
% Email: fiona.muellner at gmail.com

clearvars -except rootfolder
cd(sprintf('%s\\CA1_multi\\experiment\\spine',rootfolder))
list=dir('simulationRes*');
h1 = figure;
cmap(1,:)=[0 1 0];
cmap(2,:)=[1 0 0];
cmap(3,:)=[0 0 1];

maxinh = 0.3;
fixedcond = NaN;
AllI=[];
ncomp1=zeros(2,0);
ncomp2=zeros(2,0);
for i=1:size(list,1)
    clearvars -except list i maxinh fixedcond h1 tag cmap AllI ncomp1 ncomp2 rootfolder
    load(list(i,1).name);
    
    distv1 = [distv(1:n/2)',distv(1:n/2)'];
    posv1 = posv;
    chan=n/2+1:n;
    dist = distv1(chan);
    [~,s]=sort(dist);
    amp=squeeze(M(1:length(posv),1,1,chan(s(end)))); % uninhibited Ca2+-amplitudes;
    relamp=amp/amp(1);

    mp=[];
    for pos1 = 1:length(posv)
        yvect = dist(s)-posv1(pos1);
        conds = NaN;
        ix=NaN;
        cond1=1:length(condv);
        time=1:length(timev);
        temp1=1-squeeze(M(pos1,cond1,time,chan(s(2)))./repmat(M(pos1,1,time,chan(s(2))),[1,length(condv),1,1]));
        temp2=1-squeeze(M(pos1,cond1,time,chan(s(end)))./repmat(M(pos1,1,time,chan(s(end))),[1,length(condv),1,1]));
        for c=1:length(condv)
            [Inh1(c,1),mp1]=max(temp1(c,:));
            [Inh2(c,1),mp2]=max(temp2(c,:));
        end
        if pos1==1
            mp = find(Inh1<=maxinh,1,'last');
            AllI=[AllI,Inh1(mp)];
        end
        if ~isnan(fixedcond)
            Comp(pos1,1) = Inh1(fixedcond);
            Comp(pos1,2) = Inh2(fixedcond);
        elseif ~isempty(mp) && mp>1
            Comp(pos1,1) = Inh1(mp);
            Comp(pos1,2) = Inh2(mp);
        else
            Comp(pos1,1) = NaN;
            Comp(pos1,2) = NaN;
            disp(filen);
        end
    end
    ncomp2=cat(2,ncomp2,[relamp';(Comp(:,2)./Comp(:,1))']);
    ncomp1=cat(2,ncomp1,[relamp';(Comp(:,2)/Comp(1,1))']);
    figure(h1)
    subplot(2,1,1)
    plot(relamp,Comp(:,2)./Comp(:,1),'-');
    xlim([1,2.5])
    hold all
    subplot(2,1,2)
    plot(relamp,Comp(:,2)./Comp(1,1),'-');
    xlim([1,2.5])
    hold all
end

figure(h1)
subplot(2,1,1)
set(gca,'box','off')
xlabel('Excitatory conductance [nS]')
ylabel('(Spine inh.)/(Shaft inh.)')
xlim([1,2.5])

subplot(2,1,2)
set(gca,'box','off')
xlabel('Excitatory conductancre [nS]')
ylabel('(Spine inh.)/(Shaft inh. at ge=0)')
xlim([1,2.5])

BinInt=[0.9:0.2:15.1];
newx=zeros(length(BinInt)-1,1);
resultv=zeros(length(BinInt)-1,1);
for i=1:length(BinInt)-1
    f=find((ncomp2(1,:)>=BinInt(i)).*(ncomp2(1,:)<BinInt(i+1)));
    newx(i,1)=(BinInt(i)+BinInt(i+1))/2;
    resultv(i,1)=median(ncomp2(2,f));
end
figure(h1)
subplot(2,1,1)
plot(newx,resultv,'-k','LineWidth',3)
line([1 2.5],[1 1],'Color','k')

for i=1:length(BinInt)-1
    f=find((ncomp1(1,:)>=BinInt(i)).*(ncomp1(1,:)<BinInt(i+1)));
    newx(i,1)=(BinInt(i)+BinInt(i+1))/2;
    resultv(i,1)=median(ncomp1(2,f));
end
figure(h1)
subplot(2,1,2)
plot(newx,resultv,'-k','LineWidth',3)
line([1 2.5],[1 1],'Color','k')


figure
filen='simulationData_4.dat';
pathn=cd;
LoadAndSave
mat=jet;
pos=2;cond=1:8;time=10;chan=7;
hold off
for cond=1:8
plot(timeref,A(2:end-2,(pos-1)*nk*nj*n + (cond-1)*nj*n + (time-1)*n + chan),'color',mat(floor(condv(cond)/0.02*64)+1,:));

hold all
end
xlim([5 15])
set(gca,'box','off')
ch=colorbar;
set(gca,'clim',[0 20])
set(ch,'ytick',[0:5:20])


figure
filen='simulationData_2.dat';
pathn=cd;
LoadAndSave
pos=4;cond=1:8;time=10;chan=7;
hold off
for cond=1:8
plot(timeref,A(2:end-2,(pos-1)*nk*nj*n + (cond-1)*nj*n + (time-1)*n + chan),'color',mat(floor(condv(cond)/0.02*64)+1,:));
hold all
end
xlim([5 15])
set(gca,'box','off')
ch=colorbar;
set(gca,'clim',[0 20])
set(ch,'ytick',[0:5:20])
