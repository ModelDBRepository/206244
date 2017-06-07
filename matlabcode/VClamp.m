% Compare synapse activation to voltage-clamp at the same position
% ---
% Fiona Müllner, MPI Neurobiology
% Email: fiona.muellner at gmail.com

clearvars -except rootfolder
figure;
cd(sprintf('%s\\CA1_multi\\experiment\\regular',rootfolder))
filen='simulationData_2.dat';
pathn=cd;
LoadAndSave

subplot(2,3,1)
hold all; xlim([5 12])
pos=1;cond=[1];time=9;chan=4;
plot(timeref,A(2:end-2,(pos-1)*nk*nj*n + (cond-1)*nj*n + (time-1)*n + chan),'b','LineWidth',2);
pos=1;cond=[3];time=9;chan=4;
plot(timeref,A(2:end-2,(pos-1)*nk*nj*n + (cond-1)*nj*n + (time-1)*n + chan),'r','LineWidth',2);
subplot(2,3,2)
hold all; xlim([5 12])
pos=1;cond=[1];time=9;chan=2;
plot(timeref,A(2:end-2,(pos-1)*nk*nj*n + (cond-1)*nj*n + (time-1)*n + chan),'b','LineWidth',2);
pos=1;cond=[3];time=9;chan=2;
plot(timeref,A(2:end-2,(pos-1)*nk*nj*n + (cond-1)*nj*n + (time-1)*n + chan),'r','LineWidth',2);
subplot(2,3,3)
hold all; xlim([5 12])
pos=1;cond=[1];time=9;chan=12;
plot(timeref,A(2:end-2,(pos-1)*nk*nj*n + (cond-1)*nj*n + (time-1)*n + chan),'b','LineWidth',2);
pos=1;cond=[3];time=9;chan=12;
plot(timeref,A(2:end-2,(pos-1)*nk*nj*n + (cond-1)*nj*n + (time-1)*n + chan),'r','LineWidth',2);

subplot(2,3,4)
hold all; xlim([5 12]); ylim([1 1.42]*1e-4)
pos=1;cond=[1];time=9;chan=4+n/2;
plot(timeref,A(2:end-2,(pos-1)*nk*nj*n + (cond-1)*nj*n + (time-1)*n + chan),'b','LineWidth',2);
pos=1;cond=[3];time=9;chan=4+n/2;
plot(timeref,A(2:end-2,(pos-1)*nk*nj*n + (cond-1)*nj*n + (time-1)*n + chan),'r','LineWidth',2);
subplot(2,3,5)
hold all; xlim([5 12]); ylim([1 1.42]*1e-4)
pos=1;cond=[1];time=9;chan=2+n/2;
plot(timeref,A(2:end-2,(pos-1)*nk*nj*n + (cond-1)*nj*n + (time-1)*n + chan),'b','LineWidth',2);
pos=1;cond=[3];time=9;chan=2+n/2;
plot(timeref,A(2:end-2,(pos-1)*nk*nj*n + (cond-1)*nj*n + (time-1)*n + chan),'r','LineWidth',2);
subplot(2,3,6)
hold all; xlim([5 12]); ylim([1 1.42]*1e-4)
pos=1;cond=[1];time=9;chan=12+n/2;
plot(timeref,A(2:end-2,(pos-1)*nk*nj*n + (cond-1)*nj*n + (time-1)*n + chan),'b','LineWidth',2);
pos=1;cond=[3];time=9;chan=12+n/2;
plot(timeref,A(2:end-2,(pos-1)*nk*nj*n + (cond-1)*nj*n + (time-1)*n + chan),'r','LineWidth',2);

clearvars -except rootfolder
cd(sprintf('%s\\CA1_multi\\experiment\\vclamp',rootfolder))
filen='simulationData_2.dat';
pathn=cd;
LoadAndSave

subplot(2,3,1)
hold all; xlim([5 12])
pos=1;cond=[1];time=9;chan=4;
plot(timeref,A(2:end-2,(pos-1)*nk*nj*n + (cond-1)*nj*n + (time-1)*n + chan),'c','LineWidth',1);
pos=1;cond=[3];time=9;chan=4;
plot(timeref,A(2:end-2,(pos-1)*nk*nj*n + (cond-1)*nj*n + (time-1)*n + chan),'m','LineWidth',1);
subplot(2,3,2)
hold all; xlim([5 12])
pos=1;cond=[1];time=9;chan=2;
plot(timeref,A(2:end-2,(pos-1)*nk*nj*n + (cond-1)*nj*n + (time-1)*n + chan),'c','LineWidth',1);
pos=1;cond=[3];time=9;chan=2;
plot(timeref,A(2:end-2,(pos-1)*nk*nj*n + (cond-1)*nj*n + (time-1)*n + chan),'m','LineWidth',1);
subplot(2,3,3)
hold all; xlim([5 12])
pos=1;cond=[1];time=9;chan=12;
plot(timeref,A(2:end-2,(pos-1)*nk*nj*n + (cond-1)*nj*n + (time-1)*n + chan),'c','LineWidth',1);
pos=1;cond=[3];time=9;chan=12;
plot(timeref,A(2:end-2,(pos-1)*nk*nj*n + (cond-1)*nj*n + (time-1)*n + chan),'m','LineWidth',1);

subplot(2,3,4)
hold all; xlim([5 12]); ylim([1 1.42]*1e-4)
pos=1;cond=[1];time=9;chan=4+n/2;
plot(timeref,A(2:end-2,(pos-1)*nk*nj*n + (cond-1)*nj*n + (time-1)*n + chan),'c','LineWidth',1);
pos=1;cond=[3];time=9;chan=4+n/2;
plot(timeref,A(2:end-2,(pos-1)*nk*nj*n + (cond-1)*nj*n + (time-1)*n + chan),'m','LineWidth',1);
subplot(2,3,5)
hold all; xlim([5 12]); ylim([1 1.42]*1e-4)
pos=1;cond=[1];time=9;chan=2+n/2;
plot(timeref,A(2:end-2,(pos-1)*nk*nj*n + (cond-1)*nj*n + (time-1)*n + chan),'c','LineWidth',1);
pos=1;cond=[3];time=9;chan=2+n/2;
plot(timeref,A(2:end-2,(pos-1)*nk*nj*n + (cond-1)*nj*n + (time-1)*n + chan),'m','LineWidth',1);
subplot(2,3,6)
hold all; xlim([5 12]); ylim([1 1.42]*1e-4)
pos=1;cond=[1];time=9;chan=12+n/2;
plot(timeref,A(2:end-2,(pos-1)*nk*nj*n + (cond-1)*nj*n + (time-1)*n + chan),'c','LineWidth',1);
pos=1;cond=[3];time=9;chan=12+n/2;
plot(timeref,A(2:end-2,(pos-1)*nk*nj*n + (cond-1)*nj*n + (time-1)*n + chan),'m','LineWidth',1);