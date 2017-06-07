% Compare length constants of simulated Ca2+-inhibition for different
% model parameters
% ---
% Fiona Müllner, MPI Neurobiology
% Email: fiona.muellner at gmail.com

clearvars -except rootfolder
space = 5;
fitsingle = 0;

cd(sprintf('%s\\CA1_multi\\experiment\\mul2',rootfolder))
figure
NeuronSim_Summary

subplot(2,1,1)
tempx=[];
tempy=[];
xl=get(gca,'xlim'); xl=round(xl/space)*space;
for i=1:length(newx)
    s = find((diff(newx{1,i})==0).*(diff(resultv{1,i})==0)==0);
    newx{1,i}=newx{1,i}(s);
    resultv{1,i}=resultv{1,i}(s);
    if fitsingle
        sel1=(~isnan(resultv{1,i})).*(newx{1,i}>=0)==1;
        if sum(sel1)>1
            estimates1 = exp_nooffset2(newx{1,i}(sel1),resultv{1,i}(sel1));
        else
            estimates1 = NaN;
        end
        sel1=(~isnan(resultv{1,i})).*(newx{1,i}<=0)==1;
        if sum(sel1)>1
            estimates2 = exp_nooffset2(newx{1,i}(sel1),resultv{1,i}(sel1));
        else
            estimates2 = NaN;
        end
        k(1,i,1:2) = [1/estimates1,-1/estimates2];
    end
    tempy=[tempy,interp1(newx{1,i},resultv{1,i},xl(1):space:xl(2))];
    tempx=[tempx,xl(1):space:xl(2)];
end
newx=tempx; 
resultv=tempy;
sel1=(~isnan(resultv)).*(newx>=0)==1;
if sum(sel1)>1
    [estimates1, model] = exp_nooffset2(newx(sel1),resultv(sel1));
    plot([0:200],exp(-[0:200]*estimates1),'k-','LineWidth',2)
else
    estimates1 = NaN;
end
sel1=(~isnan(resultv)).*(newx<=0)==1;
if sum(sel1)>1
    [estimates2, model] = exp_nooffset2(newx(sel1),resultv(sel1));
    plot(-[0:1000],exp([0:1000]*estimates2),'k-','LineWidth',2)
else
    estimates2 = NaN;
end
text(-1000,0.7,sprintf('distal %1.1f um, proximal %1.1f um',1/estimates1,-1/estimates2))
title('mul2')

h(1,:)=[1/estimates1,-1/estimates2];

cd(sprintf('%s\\CA1_multi\\experiment\\regular',rootfolder))

figure
NeuronSim_Summary

subplot(2,1,1)
tempx=[];
tempy=[];
xl=get(gca,'xlim'); xl=round(xl/space)*space;
for i=1:length(newx)
    s = find((diff(newx{1,i})==0).*(diff(resultv{1,i})==0)==0);
    newx{1,i}=newx{1,i}(s);
    resultv{1,i}=resultv{1,i}(s);
    if fitsingle
        sel1=(~isnan(resultv{1,i})).*(newx{1,i}>=0)==1;
        if sum(sel1)>1
            estimates1 = exp_nooffset2(newx{1,i}(sel1),resultv{1,i}(sel1));
        else
            estimates1 = NaN;
        end
        sel1=(~isnan(resultv{1,i})).*(newx{1,i}<=0)==1;
        if sum(sel1)>1
            estimates2 = exp_nooffset2(newx{1,i}(sel1),resultv{1,i}(sel1));
        else
            estimates2 = NaN;
        end
        k(2,i,1:2) = [1/estimates1,-1/estimates2];
    end
    tempy=[tempy,interp1(newx{1,i},resultv{1,i},xl(1):space:xl(2))];
    tempx=[tempx,xl(1):space:xl(2)];
end
newx=tempx; 
resultv=tempy;
sel1=(~isnan(resultv)).*(newx>=0)==1;
if sum(sel1)>1
    [estimates1, model] = exp_nooffset2(newx(sel1),resultv(sel1));
    plot([0:200],exp(-[0:200]*estimates1),'k-','LineWidth',2)
else
    estimates1 = NaN;
end
sel1=(~isnan(resultv)).*(newx<=0)==1;
if sum(sel1)>1
    [estimates2, model] = exp_nooffset2(newx(sel1),resultv(sel1));
    plot(-[0:500],exp([0:500]*estimates2),'k-','LineWidth',2)
else
    estimates2 = NaN;
end
text(-500,0.7,sprintf('distal %1.1f um, proximal %1.1f um',1/estimates1,-1/estimates2))
title('regular')

h(2,:)=[1/estimates1,-1/estimates2];

cd(sprintf('%s\\CA1_multi\\experiment\\div2',rootfolder))
figure
NeuronSim_Summary

subplot(2,1,1)
tempx=[];
tempy=[];
xl=get(gca,'xlim'); xl=round(xl/space)*space;
for i=1:length(newx)
    s = find((diff(newx{1,i})==0).*(diff(resultv{1,i})==0)==0);
    newx{1,i}=newx{1,i}(s);
    resultv{1,i}=resultv{1,i}(s);
    if fitsingle
        sel1=(~isnan(resultv{1,i})).*(newx{1,i}>=0)==1;
        if sum(sel1)>1
            estimates1 = exp_nooffset2(newx{1,i}(sel1),resultv{1,i}(sel1));
        else
            estimates1 = NaN;
        end
        sel1=(~isnan(resultv{1,i})).*(newx{1,i}<=0)==1;
        if sum(sel1)>1
            estimates2 = exp_nooffset2(newx{1,i}(sel1),resultv{1,i}(sel1));
        else
            estimates2 = NaN;
        end
        k(3,i,1:2) = [1/estimates1,-1/estimates2];
    end
    tempy=[tempy,interp1(newx{1,i},resultv{1,i},xl(1):space:xl(2))];
    tempx=[tempx,xl(1):space:xl(2)];
end
newx=tempx; 
resultv=tempy;
sel1=(~isnan(resultv)).*(newx>=0)==1;
if sum(sel1)>1
    [estimates1, model] = exp_nooffset2(newx(sel1),resultv(sel1));
    plot([0:100],exp(-[0:100]*estimates1),'k-','LineWidth',2)
else
    estimates1 = NaN;
end
sel1=(~isnan(resultv)).*(newx<=0)==1;
if sum(sel1)>1
    [estimates2, model] = exp_nooffset2(newx(sel1),resultv(sel1));
    plot(-[0:250],exp([0:250]*estimates2),'k-','LineWidth',2)
else
    estimates2 = NaN;
end
text(-250,0.7,sprintf('distal %1.1f um, proximal %1.1f um',1/estimates1,-1/estimates2))
title('div2')

h(3,:)=[1/estimates1,-1/estimates2];

cd(sprintf('%s\\CA1_multi\\experiment\\spinesadded',rootfolder))
figure
NeuronSim_Summary

subplot(2,1,1)
tempx=[];
tempy=[];
xl=get(gca,'xlim'); xl=round(xl/space)*space;
for i=1:length(newx)
    s = find((diff(newx{1,i})==0).*(diff(resultv{1,i})==0)==0);
    newx{1,i}=newx{1,i}(s);
    resultv{1,i}=resultv{1,i}(s);
    if fitsingle
        sel1=(~isnan(resultv{1,i})).*(newx{1,i}>=0)==1;
        if sum(sel1)>1
            estimates1 = exp_nooffset2(newx{1,i}(sel1),resultv{1,i}(sel1));
        else
            estimates1 = NaN;
        end
        sel1=(~isnan(resultv{1,i})).*(newx{1,i}<=0)==1;
        if sum(sel1)>1
            estimates2 = exp_nooffset2(newx{1,i}(sel1),resultv{1,i}(sel1));
        else
            estimates2 = NaN;
        end
        k(6,i,1:2) = [1/estimates1,-1/estimates2];
    end
    tempy=[tempy,interp1(newx{1,i},resultv{1,i},xl(1):space:xl(2))];
    tempx=[tempx,xl(1):space:xl(2)];
end
newx=tempx; 
resultv=tempy;
sel1=(~isnan(resultv)).*(newx>=0)==1;
if sum(sel1)>1
    [estimates1, model] = exp_nooffset2(newx(sel1),resultv(sel1));
    plot([0:100],exp(-[0:100]*estimates1),'k-','LineWidth',2)
else
    estimates1 = NaN;
end
sel1=(~isnan(resultv)).*(newx<=0)==1;
if sum(sel1)>1
    [estimates2, model] = exp_nooffset2(newx(sel1),resultv(sel1));
    plot(-[0:250],exp([0:250]*estimates2),'k-','LineWidth',2)
else
    estimates2 = NaN;
end
text(-250,0.7,sprintf('distal %1.1f um, proximal %1.1f um',1/estimates1,-1/estimates2))
title('spinesadded')

h(4,:)=[1/estimates1,-1/estimates2];


cd(sprintf('%s\\CA1_multi\\experiment\\smalltau',rootfolder))
figure
NeuronSim_Summary

subplot(2,1,1)
tempx=[];
tempy=[];
xl=get(gca,'xlim'); xl=round(xl/space)*space;
for i=1:length(newx)
    s = find((diff(newx{1,i})==0).*(diff(resultv{1,i})==0)==0);
    newx{1,i}=newx{1,i}(s);
    resultv{1,i}=resultv{1,i}(s);
    if fitsingle
        sel1=(~isnan(resultv{1,i})).*(newx{1,i}>=0)==1;
        if sum(sel1)>1
            estimates1 = exp_nooffset2(newx{1,i}(sel1),resultv{1,i}(sel1));
        else
            estimates1 = NaN;
        end
        sel1=(~isnan(resultv{1,i})).*(newx{1,i}<=0)==1;
        if sum(sel1)>1
            estimates2 = exp_nooffset2(newx{1,i}(sel1),resultv{1,i}(sel1));
        else
            estimates2 = NaN;
        end
        k(2,i,1:2) = [1/estimates1,-1/estimates2];
    end
    tempy=[tempy,interp1(newx{1,i},resultv{1,i},xl(1):space:xl(2))];
    tempx=[tempx,xl(1):space:xl(2)];
end
newx=tempx; 
resultv=tempy;
sel1=(~isnan(resultv)).*(newx>=0)==1;
if sum(sel1)>1
    [estimates1, model] = exp_nooffset2(newx(sel1),resultv(sel1));
    plot([0:200],exp(-[0:200]*estimates1),'k-','LineWidth',2)
else
    estimates1 = NaN;
end
sel1=(~isnan(resultv)).*(newx<=0)==1;
if sum(sel1)>1
    [estimates2, model] = exp_nooffset2(newx(sel1),resultv(sel1));
    plot(-[0:500],exp([0:500]*estimates2),'k-','LineWidth',2)
else
    estimates2 = NaN;
end
text(-500,0.7,sprintf('distal %1.1f um, proximal %1.1f um',1/estimates1,-1/estimates2))
title('smalltau')

h(5,:)=[1/estimates1,-1/estimates2];


figure
plot([2,1,0.5],h(1:3,1),'bo-')
hold all
plot([2,1,0.5],h(1:3,2),'c^-')
plot(1,h(4,1),'om')
plot(1,h(5,1),'og')
plot(1,h(4,2),'^m')
plot(1,h(5,2),'^g')


xlim([0,2.5])
legend('regular prox','regular dist','spines 0.5','tau0.5')




