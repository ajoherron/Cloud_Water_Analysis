%Quicklooks

%Optical Thickness subplot
subplot(6,1,1);
plot(time_utc, cloud_ot_863nm,'linewidth',2)
grid on
ylabel('Optical Thickness','Fontsize',14)
ylim([0 70])
title(page1_title,'Fontsize',20)
%xlim([19.1 19.5])
%xlim([19.5 20])
%xlim([19.59 19.68])
%xlim([19.74 19.8])
%xlim([19.85 19.91])
%xlim([19.7 20])
%xlim([19.7 19.85])
%xlim([19 19.5])
%xlim([19.2 19.26])
xlim([19.1 20])

%Effective Radius subplot
subplot(6,1,2);
plot(time_utc, cloud_reff_pol_863nm,'linewidth',2)
hold on
grid on
plot(time_utc, cloud_reff_2260,'linewidth',2)
ylabel('R_e_f_f (\mum)','Fontsize',14)
ylim([0 40])
%legend({'Polarized 863nm','NK 2260nm'},'Fontsize',10,'Location','northeast')
%xlim([19.1 19.5])
%xlim([19.5 20])
%xlim([19.59 19.68])
%xlim([19.74 19.8])
%xlim([19.85 19.91])
%xlim([19.7 20])
%xlim([19.7 19.85])
%xlim([19 19.5])
%xlim([19.2 19.26])
xlim([19.1 20])

%Effective Variance subplot
subplot(6,1,3);
plot(time_utc, cloud_veff_pol_863nm,'linewidth',2)
grid on
ylabel('V_e_f_f','Fontsize',14)
ylim([0 .4])
%xlim([19.1 19.5])
%xlim([19.5 20])
%xlim([19.59 19.68])
%xlim([19.74 19.8])
%xlim([19.85 19.91])
%xlim([19.7 20])
%xlim([19.7 19.85])
%xlim([19 19.5])
%xlim([19.2 19.26])
xlim([19.1 20])

%Water Vapor subplot
subplot(6,1,4);
hold on
grid on
plot(time_utc, wv_column_nk, 'LineWidth',2)
plot(time_utc, wv_column_pol, 'LineWidth',2)
plot(time_utc, wv_column, 'LineWidth', 3)
ylabel('W.V. (cm atm^-^1)','Fontsize',14)
ylim([-1 4])
%legend({'Radiance Water Vapor Retrieval','Polarized Water Vapor Retrieval','Net Water Vapor Retrieval'},'FontSize',6,'Location','northeast')
%xlim([19.1 19.5])
%xlim([19.5 20])
%xlim([19.59 19.68])
%xlim([19.74 19.8])
%xlim([19.85 19.91])
%xlim([19.7 20])
%xlim([19.7 19.85])
%xlim([19 19.5])
%xlim([19.2 19.26])
xlim([19.1 20])

%Cloud Top Height Subplot
subplot(6,1,5)
grid on
hold on
plot(time_utc, alt_aggr, 'linewidth',2)
plot(gps_time, cloud_top_height,'linewidth',5)
plot(jgps_time, cloud_height_j,'linewidth',2)
ylabel('C.T.H. (m)','Fontsize',16)
%legend({'RSP','HSRL','Johns Data'},'FontSize',6,'Location','northeast')
ylim([0 8000])
%xlim([19.1 19.5])
%xlim([19.5 20])
%xlim([19.59 19.68])
%xlim([19.74 19.8])
%xlim([19.85 19.91])
%xlim([19.7 20])
%xlim([19.7 19.85])
%xlim([19 19.5])
%xlim([19.2 19.26])
xlim([19.1 20])

%Cloud Top Temperature
subplot(6,1,6)
plot(gps_time, ctt,'Linewidth',2)
grid on
xlabel('Time (UTC)','Fontsize',14)
ylabel('C.T.T. (K)','Fontsize',14)
%xlim([19.1 19.5])
%xlim([19.5 20])
%xlim([19.59 19.68])
%xlim([19.74 19.8])
%xlim([19.85 19.91])
%xlim([19.7 20])
%xlim([19.7 19.85])
%xlim([19 19.5])
%xlim([19.2 19.26])
xlim([19.1 20])

%saveas(figure(1),'20200227_ot_195_200_pg1.png')
%saveas(figure(1),'20200227_ot_191_195_pg1.png')
%saveas(figure(1),'20200227_1959_1968_pg1.png')
%saveas(figure(1),'20200227_1974_1980_pg1.png')
%saveas(figure(1),'20200227_1985_1991_pg1.png')
%saveas(figure(1),'20200227_197_20_pg1.png')
%saveas(figure(1),'20200227_197_1985_pg1.png')
%saveas(figure(1),'20200227_19_195_pg1.png')
%saveas(figure(1),'20200227_192_1926_pg1.png')
saveas(figure(1),'20200227_191_20_pg1.png')

clf

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Page 2

%Extinction subplot
subplot(5,1,1);
ext_smooth = movmean(ext,5)
scatter(time_utc,ext_col,'Linewidth',2)
grid on
ylabel('\beta (km^-^1)','Fontsize',14,'Fontweight','bold')
title('2/27/2020 Page 2','Fontsize',20)
hold on
%xlim([19.1 19.5])
xlim([19.5 20])
%xlim([19.59 19.68])
%xlim([19.74 19.8])
%xlim([19.85 19.91])
%xlim([19.7 20])
%xlim([19.7 19.85])
%xlim([19 19.5])
%xlim([19.2 19.26])
%xlim([19.1 20])

%Extinction Cross-Section subplot
subplot(5,1,2);
scatter(time_utc, ext_cs,'Linewidth',2)
grid on
ylabel('\sigma (\mum^2)','Fontsize',14,'Fontweight','bold')
%xlim([19.1 19.5])
xlim([19.5 20])
%xlim([19.59 19.68])
%xlim([19.74 19.8])
%xlim([19.85 19.91])
%xlim([19.7 20])
%xlim([19.7 19.85])
%xlim([19 19.5])
%xlim([19.2 19.26])
%xlim([19.1 20])

%Droplet Concentration subplot
%Grosvenor Eq 11
subplot(5,1,3)
scatter(time_utc, RSD_ND3,30,'Linewidth',2)
hold on
scatter(time_utc, RSD_ND1,20,'Linewidth',2)
grid on
ylabel('N_d (cm^-^3)','Fontsize',14)
%legend({'MODIS w/ NK Reff 2260nm','MODIS w/ Pol Reff 863nm'},'FontSize',8,'Location','southeast')
set(gca, 'YScale', 'log')
ylim([1 10000])
yt = logspace(0,4,5)
set(gca,'YTick',yt)
%title('2/27/2020 Droplet Concentration','Fontsize',20)
%xlim([19.1 19.5])
xlim([19.5 20])
%xlim([19.59 19.68])
%xlim([19.74 19.8])
%xlim([19.85 19.91])
%xlim([19.7 20])
%xlim([19.7 19.85])
%xlim([19 19.5])
%xlim([19.2 19.26])
%xlim([19.1 20])

%Colocate ext and ext_cs variables 
subplot(5,1,4)
nd_c = ext_col./ext_cs
nd_c = nd_c.*1000
scatter(time_utc, nd_c,'*','Linewidth',2)
grid on
ylabel('N_d (cm^-^3)','Fontsize',14)
%legend({'Combined RSP-HSRL Method'},'FontSize',8,'Location','southeast')
set(gca, 'YScale', 'log')
ylim([1 10000])
yt = logspace(0,4,5)
set(gca,'YTick',yt)
%xlim([19.1 19.5])
xlim([19.5 20])
%xlim([19.59 19.68])
%xlim([19.74 19.8])
%xlim([19.85 19.91])
%xlim([19.7 20])
%xlim([19.7 19.85])
%xlim([19 19.5])
%xlim([19.2 19.26])
%xlim([19.1 20])

subplot(5,1,5)
scatter(time_utc, nd_c,30,'*','Linewidth',2)
hold on
scatter(time_utc, RSD_ND1,20,'Linewidth',2)
grid on
ylabel('N_d (cm^-^3)','Fontsize',14)
%legend({'Combined RSP-HSRL Method','Radiometric "MODIS" Method w/ Pol Reff 863nm'},'FontSize',8,'Location','southeast')
set(gca, 'YScale', 'log')
xlabel('Time (UTC)','Fontsize',14)
set(gca, 'YScale', 'log')
ylim([1 10000])
yt = logspace(0,4,5)
set(gca,'YTick',yt)
%xlim([19.1 19.5])
xlim([19.5 20])
%xlim([19.59 19.68])
%xlim([19.74 19.8])
%xlim([19.85 19.91])
%xlim([19.7 20])
%xlim([19.7 19.85])
%xlim([19 19.5])
%xlim([19.2 19.26])
%xlim([19.1 20])

%saveas(figure(1), '20200227_191_195_pg2.png')
saveas(figure(1), '20200227_195_200_pg2.png')
%saveas(figure(1),'20200227_1959_1968_pg2.png')
%saveas(figure(1),'20200227_1974_1980_pg2.png')
%saveas(figure(1),'20200227_1985_1991_pg2.png')
%saveas(figure(1),'20200227_197_20_pg2.png')
%saveas(figure(1),'20200227_197_1985_pg2.png')
%saveas(figure(1),'20200227_19_195_pg2.png')
%saveas(figure(1),'20200227_192_1926_pg2.png')
%saveas(figure(1),'20200227_191_20_pg2.png')


