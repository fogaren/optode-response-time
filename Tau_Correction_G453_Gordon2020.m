%% Tau Correction based on Gordon 2020 for G453 2018
%
% * Used casts from Glider 453 (June 12-13 2018)
% * Compares upcasts and downcasts to calculate an offset for the oxygen sensor 
% based on the offset that minimizes the RMSD for lags from 1:100 seconds 
% * Used data from 0 to 250 m 
% * Slightly different result for each comparison but an average of 49.6 s which 
% is same as Hilary's result of 50 s 
% * Need up and down casts, needed OOI to program gliders to do that at the 
% beginning 
% * Then OOI usually does only upcasts or only downcasts
% * Could make recommendation on which is better 

gpath('Data_Files\From_Roo') 
load G453.mat
%%
glider = G453;
paired = find(glider.daten > datenum(2018,6,12,19,22,0) & glider.daten < datenum(2018,6,13,8,39,0) & glider.profile_direction ~=0);
paired = find(glider.daten > datenum(2018,6,12,19,22,0) & glider.daten < datenum(2018,6,12,23,39,0) & glider.profile_direction ==+1);

figure 
%plot(glider.daten(paired), glider.depth_interp(paired), 'k.'); hold on;
scatter(glider.daten(paired), glider.depth_interp(paired), [], glider.oxygen_saturation(paired),'filled'); colorbar; %caxis([85 100])
set(gca,'YDir','reverse'); 
xlim([datenum(2018,6,12,19,15,0) datenum(2018,6,13,08,40,0)])
ylim([0 200])
datetick('x','keepticks','keeplimits')
ylabel('Depth (m)')
title('Glider 453, oxygen saturation (6/12-6/13/2018)')
%%
figure 
%plot(glider.daten(paired), glider.depth_interp(paired), 'k.'); hold on;
scatter(glider.daten(paired), glider.depth_interp(paired), [], glider.oxygen_concentration(paired),'filled'); colorbar; %caxis([85 100])
set(gca,'YDir','reverse'); 
xlim([datenum(2018,6,12,19,15,0) datenum(2018,6,13,08,40,0)])
ylim([0 200])
datetick('x','keepticks','keeplimits')
ylabel('Depth (m)')
title('Glider 453, oxygen (6/12-6/13/2018)')
%%
figure
plot(glider.oxygen_concentration(paired),glider.depth_interp(paired),'.')
axis ij

testDO = glider.oxygen_concentration(paired);
testdepth = glider.depth_interp(paired);
%%
% * Hard coded into necessary format for tau_correction code and saved as TauTest_G453.mat
% * Was really annoying to code this format, must be a more automated way

run('GeneralSettings.m') % For colors

gpath('Data_Files\From_Kristen')
%%
load TauTest_G453.mat % downcasts are odd rows, upcasts are even rows

figure
plot(DO(1,:),pres(1,:),'Color',cyan)
hold on
plot(DO(2,:),pres(2,:),'Color',red)
plot(DO(3,:),pres(3,:),'Color',blue)
plot(DO(5,:),pres(5,:),'Color',navy)
plot(DO(2,:),pres(2,:),'Color',red)
plot(DO(4,:),pres(4,:),'Color',maroon)
plot(DO(6,:),pres(6,:),'Color','red')
axis ij
ylim([0 150])
legend('Downcast','Upcast','Location','SE')
title('Glider 453, oxygen saturation (6/12-6/13/2018)')

% * Can change z limits of water column
% * I edited Gordon's calculate_tau.m to output the RMSD so that each errors 
% from upcast/downcast tau corrections could be plotted and visually compared 

[ tau, time_constants, rmsd ] = calculate_tau( t, pres, DO, 'zlim',[0 250]);

tau % in seconds 
tau_average = nanmean(tau)

figure
plot(time_constants,rmsd,'.')
xlabel('\tau (sec)')
ylabel('RMSD (%)')
title('Tau Correction (Gordon et al 2020)')

% Profiles to compare 2 and 3
figure
subplot(1,2,1)
plot(DO(2,:),pres(2,:),'Color',red)
hold on
plot(DO(3,:),pres(3,:),'Color',blue)
axis ij
ylim([0 250])
legend('Upcast','Downcast','Location','SE')
title('Compare 2 to 3')

subplot(1,2,2) % 4 and 5
plot(DO(4,:),pres(4,:),'Color',maroon)
hold on
plot(DO(5,:),pres(5,:),'Color',navy)
axis ij
ylim([0 250])
legend('Upcast','Downcast','Location','SE')
title('Compare 4 to 5')
%%
t23 = t(2:3,:); pres23 = pres(2:3,:); DO23 = DO(2:3,:);
[ tau23, time_constants23, rmsd23 ] = calculate_tau( t23, pres23, DO23, 'zlim',[0 250]);


% filter nan values (for correct_oxygen_profile.m code) 
    ind2 = ~(isnan(DO(2,:)) | isnan(pres(2,:)) | isnan(t(2,:)));
    ind3 = ~(isnan(DO(3,:)) | isnan(pres(3,:)) | isnan(t(3,:)));
[ DO2corr ] = correct_oxygen_profile( t(2,ind2), DO(2,ind2), 50);
[ DO3corr ] = correct_oxygen_profile( t(3,ind3), DO(3,ind3), 50);

t45 = t(4:5,:); pres45 = pres(4:5,:); DO45 = DO(4:5,:);
[ tau45, time_constants45, rmsd45 ] = calculate_tau( t45, pres45, DO45, 'zlim',[0 250]);

% filter nan values (for correct_oxygen_profile.m code) 
    ind4 = ~(isnan(DO(4,:)) | isnan(pres(4,:)) | isnan(t(4,:)));
    ind5 = ~(isnan(DO(5,:)) | isnan(pres(5,:)) | isnan(t(5,:)));
[ DO4corr ] = correct_oxygen_profile( t(4,ind4), DO(4,ind4), 50);
[ DO5corr ] = correct_oxygen_profile( t(5,ind5), DO(5,ind5), 50);

tau23
tau45

figure
subplot(1,2,1)
plot(DO(2,:),pres(2,:),'Color',red)
hold on
plot(DO(3,:),pres(3,:),'Color',blue)
plot(DO2corr,pres(2,ind2),'Color',maroon,'Linewidth',1.5)
plot(DO3corr,pres(3,ind3),'Color',navy,'Linewidth',1.5)
axis ij
ylim([0 250])
title('Compare 2 to 3')

subplot(1,2,2)
plot(DO(4,:),pres(4,:),'Color',red)
hold on
plot(DO(5,:),pres(5,:),'Color',blue)
plot(DO4corr,pres(4,ind4),'Color',maroon,'Linewidth',1.5)
plot(DO5corr,pres(5,ind5),'Color',navy,'Linewidth',1.5)
axis ij
ylim([0 250])
legend('Upcast','Downcast','UpCorr','DownCorr','Location','SE')
title('Compare 4 to 5')

figure
plot(DO2corr,pres(2,ind2),'Color',red,'Linewidth',1.5)
hold on
plot(DO3corr,pres(3,ind3),'Color',blue,'Linewidth',1.5)
plot(DO4corr,pres(4,ind4),'Color',maroon,'Linewidth',1.5)
plot(DO5corr,pres(5,ind5),'Color',navy,'Linewidth',1.5)
title('Corrected profiles')
axis ij
ylim([10 250])
%%
figure 
%plot(glider.daten(paired), glider.depth_interp(paired), 'k.'); hold on;
scatter(glider.daten(paired), glider.depth_interp(paired), [], glider.oxygen_saturation(paired),'filled'); colorbar; caxis([85 100])
set(gca,'YDir','reverse'); 
xlim([datenum(2018,6,12,19,15,0) datenum(2018,6,13,08,40,0)])
ylim([0 200])
datetick('x','keepticks','keeplimits')
ylabel('Depth (m)')
title('Glider 453, oxygen saturation (6/12-6/13/2018)')