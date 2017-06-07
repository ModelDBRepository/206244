% Plot spatiotemporal profile of Ca2+-inhibition for a selected simulation
% ---
% Fiona Müllner, MPI Neurobiology
% Email: fiona.muellner at gmail.com

clearvars -except rootfolder
%  Choose file:
cd(sprintf('%s\\CA1_multi\\experiment\\regular',rootfolder))
load('simulationRes_2.mat')
% Choose conductance:
cond1 = 4;

figure
distv1 = [distv(1:n/2)',distv(1:n/2)'];
posv1 = posv;
pos1 = min(3,length(posv1));
fbp=find(branchid(1:n/2-1)>1,1,'first')+1;
if isempty(fbp)
    chan=n/2+1:n;
else
    chan=n/2+1:n/2+fbp-1;
end
dist = distv1(chan);
[~,s]=sort(dist);

Inh=1-(squeeze(M(pos1,cond1,1:length(timev),chan(s)))./squeeze(repmat(M(pos1,1,1,chan(s)),[1,1,nj,1])))';
if size(Inh,1)==1
    Inh=Inh';
end
newdist=floor(min(dist(s)-posv1(pos1))):ceil(max(dist(s)-posv1(pos1)));
Int=zeros(length(newdist),size(Inh,2));
for i = 1:size(Inh,2)
    for j = 1:length(newdist);
        f = find(dist(s)-posv1(pos1)>newdist(j),1,'first');
        if f == 1
            Int(j,i)=Inh(f,i);
        elseif isempty(f)
            Int(j,i)=Inh(end,i);
        elseif f>1 && dist(s(f))-posv1(pos1)-newdist(j)<=newdist(j)-dist(s(f-1))+posv1(pos1)
            Int(j,i)=Inh(f,i);
        elseif f>1 && dist(s(f))-posv1(pos1)-newdist(j)>newdist(j)-dist(s(f-1))+posv1(pos1)
            Int(j,i)=Inh(f-1,i);
        end
    end
end
iptsetpref('ImshowAxesVisible','on');
if size(Inh,2)==1
    imshow(Int','XData',newdist/20,'InitialMagnification','fit');
else
    imshow(Int','XData',newdist/20,'YData',timev-stimstart,'InitialMagnification','fit');
end
set(gca,'clim',[-1 1])
colormap(jet);
xlabel('Distance [20 um]')
ylabel('Timing [ms]')
colorbar
set(gca,'clim',[-0.3 0.5])
