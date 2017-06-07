% Compare temporal profiles of simulated Ca2+-inhibition
% ---
% Fiona Müllner, MPI Neurobiology
% Email: fiona.muellner at gmail.com

clearvars -except rootfolder
cd(sprintf('%s\\CA1_multi\\experiment\\regular',rootfolder))
TemporalProfile
xdata=-1:0.1:5;
gmax = 1;
onset = -1;
tau = 1;
alphasynapse = max(0,gmax * (xdata - onset)/tau .* exp(-(xdata - onset - tau)/tau));
plot(xdata(end:-1:1)-4,alphasynapse,'k','Linewidth',3)
title('1x APs with tau = 1, compared to flipped conductance')
xlabel('time [ms]')
ylabel('Ca2+ inhibition')

cd(sprintf('%s\\CA1_multi\\experiment\\triple',rootfolder))
TemporalProfile
title('3x APs with tau = 1ms')
xlabel('time [ms]')
ylabel('Ca2+ inhibition')

cd(sprintf('%s\\CA1_multi\\experiment\\triple_tau3',rootfolder))
TemporalProfile
title('3x APs with tau = 3ms')
xlabel('time [ms]')
ylabel('Ca2+ inhibition')
