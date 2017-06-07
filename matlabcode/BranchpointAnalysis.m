% Compare length constants of simulated Ca2+-inhibition depending on
% distance from branchpoint
% ---
% Fiona Müllner, MPI Neurobiology
% Email: fiona.muellner at gmail.com

clearvars -except rootfolder
cd(sprintf('%s\\CA1_multi\\experiment\\branchpoint+',rootfolder))
load('BranchpointPositions.mat')
list=dir('simulationRes*');
branchn=size(dir('simulationRes*a1.mat'),1);
figure

cmap(1,:)=[0 1 0];
cmap(2,:)=[1 0 0];
cmap(3,:)=[0 0 1];

maxinh = 0.3;
AllLambda = zeros(size(list,1),3);
for ci=1:size(list,1)
    clearvars -except list ci maxinh tag cmap a AllLambda branchn rootfolder
    load(list(ci,1).name);
    
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
    while cond1<=length(condv) && mv<=maxinh
        time=1:length(timev);
        temp=1-squeeze(M(pos1,cond1,time,chan(s))./M(pos1,1,time,chan(s)));
        [mv,mp]=max(temp(:));
        if mv<=maxinh
            Inh = temp/mv;
            [ix,iy] = ind2sub(size(Inh),mp);
            conds = cond1;
        elseif maxinh==0 && cond1==2
            Inh = temp/mv;
            [ix,iy] = ind2sub(size(Inh),mp);
            conds = cond1;
        end
        cond1=cond1+1;
    end
    if ~isnan(iy)
        fa = find(a(:,1)==str2double(list(ci,1).name(15)));
        distbp = posv(pos1) - a(fa,2);
        newx = yvect;
        resultv = Inh(ix,:);
        sel1=(~isnan(resultv)).*(newx>=0)==1;
        [estimates1] = exp_nooffset(newx(sel1),resultv(sel1));
        sel1=(~isnan(resultv)).*(newx<=0).*(newx>=-distbp)==1;
        hold off
        plot(newx,resultv,'*-')
        if sum(sel1)>1
            [estimates2] = exp_nooffset(newx(sel1),resultv(sel1));
            hold all
            plot(newx(newx<=0),exp(-newx(newx<=0)*estimates2),'-k');
            line(-distbp*[1 1],[0 1])
        else
            estimates2=NaN;
        end
        AllLambda(ci,:)=[distbp,1/estimates1,1/estimates2];
    else
        disp(filen);
    end
end

v1 = reshape(AllLambda(:,1),size(AllLambda,1)/branchn,branchn);
v2 = reshape(AllLambda(:,2),size(AllLambda,1)/branchn,branchn);
v3 = reshape(AllLambda(:,3),size(AllLambda,1)/branchn,branchn);
for j=1:branchn
    [~,s]=sort(v1(:,j));
    subplot(2,1,1)
    plot(v1(s,j),v2(s,j),'-')
    hold all
    subplot(2,1,2)
    plot(v1(s,j),-v3(s,j),'-')
    hold all
end
subplot(2,1,1)
set(gca,'box','off')
xlabel('Distance from branchpoint [um]')
ylabel('Length constant distal [um]')
legend('terminal','terminal','terminal','oblique','Location','NorthWest')
legend 'boxoff'
set(gca,'ylim',[10 2000])
set(gca,'YScale','log')

subplot(2,1,2)
set(gca,'box','off')
xlabel('Distance from branchpoint [um]')
ylabel('Length constant proximal [um]')
legend('267','157','358','229','Location','SouthEast')
legend 'boxoff'
set(gca,'ylim',[10 2000])
set(gca,'YScale','log')

