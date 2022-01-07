%Long Master

%2/17/2020 Files
%Combine 2/17 Flight RSP Files
h5file = 'ACTIVATE-HSRL2_UC12_20200217_RA.h5'

ncfile1 = 'RSP1-UC12_20200217_T170728-172546_wcld_v1_1.nc'
ncfile2 = 'RSP1-UC12_20200217_T173126-175509_wcld_v1_1.nc'

lon1 = ncread(ncfile1,'lon')
lat1 = ncread(ncfile1,'lat')
time_utc1 = ncread(ncfile1,'time_utc')
alt_aggr1 = ncread(ncfile1,'alt_aggr')
cloud_ot_863nm1 = ncread(ncfile1,'cloud_ot_863nm')
cloud_reff_pol_863nm1 = ncread(ncfile1,'cloud_reff_pol_863nm')
cloud_reff_nk1 = ncread(ncfile1,'cloud_reff_nk')
cloud_reff_nk_1588nm1 = cloud_reff_nk1(:,1)
cloud_veff_pol_863nm1 = ncread(ncfile1,'cloud_veff_pol_863nm')
wv_column_nk1 = ncread(ncfile1,'wv_column_nk')
wv_column_pol1 = ncread(ncfile1,'wv_column_pol')

lon2 = ncread(ncfile2,'lon')
lat2 = ncread(ncfile2,'lat')
time_utc2 = ncread(ncfile2,'time_utc')
alt_aggr2 = ncread(ncfile2,'alt_aggr')
cloud_ot_863nm2 = ncread(ncfile2,'cloud_ot_863nm')
cloud_reff_pol_863nm2 = ncread(ncfile2,'cloud_reff_pol_863nm')
cloud_reff_nk2 = ncread(ncfile2,'cloud_reff_nk')
cloud_reff_nk_1588nm2 = cloud_reff_nk2(:,1)
cloud_veff_pol_863nm2 = ncread(ncfile2,'cloud_veff_pol_863nm')
wv_column_nk2 = ncread(ncfile2,'wv_column_nk')
wv_column_pol2 = ncread(ncfile2,'wv_column_pol')

lon = vertcat(lon1, lon2)
lat = vertcat(lat1, lat2)
time_utc = vertcat(time_utc1, time_utc2)
alt_aggr = vertcat(alt_aggr1, alt_aggr2)
cloud_ot_863nm = vertcat(cloud_ot_863nm1, cloud_ot_863nm2)
cloud_reff_pol_863nm = vertcat(cloud_reff_pol_863nm1, cloud_reff_pol_863nm2)
cloud_reff_nk = vertcat(cloud_reff_nk1, cloud_reff_nk2)
cloud_veff_pol_863nm = vertcat(cloud_veff_pol_863nm1, cloud_veff_pol_863nm2)
cloud_reff_nk_1588nm = vertcat(cloud_reff_nk_1588nm1, cloud_reff_nk_1588nm2)
wv_column_nk = vertcat(wv_column_nk1, wv_column_nk2)
wv_column_pol = vertcat(wv_column_pol1, wv_column_pol2)

%Change -999 values to NaN
lId = cloud_ot_863nm == -999;
cloud_ot_863nm(lId) = NaN
lId = cloud_reff_pol_863nm == -999;
cloud_reff_pol_863nm(lId) = NaN
lId = cloud_veff_pol_863nm == -999;
cloud_veff_pol_863nm(lId) = NaN
lId = cloud_reff_nk_1588nm == -999;
cloud_reff_nk_1588nm(lId) = NaN
lId = wv_column_nk == -999;
wv_column_nk(lId) = NaN
lId = wv_column_pol == -999;
wv_column_pol(lId) = NaN
lId = wv_column_pol == -999;
wv_column_pol(lId) = NaN
wv_column = wv_column_nk - wv_column_pol

%Create Matlab File
date_str = extractAfter(ncfile1,10)
date_str = extractBefore(date_str,9)
filename = strcat('RSP-HSRL_',date_str,'.mat')

%Download HSLR Data from file
gps_alt = h5read(h5file,'/Nav_Data/gps_alt')
gps_lat = h5read(h5file,'/Nav_Data/gps_lat')
gps_lon = h5read(h5file,'/Nav_Data/gps_lon')
gps_time = h5read(h5file,'/Nav_Data/gps_time')
bsc_532 = h5read(h5file,'/DataProducts/532_bsc')
ext_532 = h5read(h5file,'/DataProducts/532_ext')
cloud_top_height = h5read(h5file,'/DataProducts/cloud_top_height')
Altitude = h5read(h5file,'/DataProducts/Altitude')
Temperature = h5read(h5file,'/State/Temperature')
Pressure = h5read(h5file,'/State/Pressure')

%Create Matlab file
date_str_hslr = extractAfter(h5file,20)
date_str_hslr = extractBefore(date_str_hslr,9)

%Add on Flight Information if Necessary
flight = extractAfter(h5file,32)
flight = extractBefore(flight,3)
tf1 = strcmp("L1",flight)
tf2 = strcmp("L2",flight)
tfh5 = strcmp("h5",flight)
if tf1 == 0 & tf2 == 0
    flight = []
end
if tf1 == 1
    flight = "_Flight_1"
end
if tf2 == 1
    flight = "_Flight_2"
end

%Save HSLR Data to file
filename = strcat('RSP-HSRL_',date_str_hslr,flight,'.mat')
save(filename,'gps_alt','gps_lat','gps_lon','gps_time','bsc_532','ext_532','cloud_top_height','Altitude','Temperature','Pressure','alt_aggr','cloud_ot_863nm','cloud_reff_nk','cloud_reff_nk_1588nm','cloud_reff_pol_863nm','cloud_veff_pol_863nm','lat','lon','time_utc','wv_column','wv_column_nk','wv_column_pol')

%Create RSP Quicklooks
%Optical Thickness subplot
date = [date_str(5:6),'/',date_str(7:8),'/',date_str(1:4)]
rsp = ["RSP Data - "]

rsp_title = strcat(rsp,date)

subplot(4,1,1);
plot(time_utc, cloud_ot_863nm,'linewidth',2)
grid on
ylabel('Optical Thickness','Fontsize',14)
ylim([0 80])
title(rsp_title,'Fontsize',14)
set(gca,'linewidth',1)

%Effective Radius subplot
subplot(4,1,2);
plot(time_utc, cloud_reff_nk_1588nm, 'linewidth',2)
hold on
grid on
plot(time_utc, cloud_reff_pol_863nm,'linewidth',2)
ylabel('R_e_f_f (\mum)','Fontsize',14)
ylim([0 40])
legend({'NK 1588','Polarized'},'FontSize',6,'Location','northeast')
set(gca,'linewidth',1)

%Effective Variance subplot
subplot(4,1,3);
plot(time_utc, cloud_veff_pol_863nm,'linewidth',2)
grid on
ylabel('V_e_f_f','Fontsize',14)
ylim([0 .4])
set(gca,'linewidth',1)

%Water Vapor subplot
subplot(4,1,4);
hold on
grid on
plot(time_utc, wv_column_nk, 'LineWidth',2)
plot(time_utc, wv_column_pol, 'LineWidth',2)
plot(time_utc, wv_column, 'LineWidth', 3)
xlabel('Time (UTC)','Fontsize',14)
ylabel('W.V. (cm atm^-^1)','Fontsize',14)
ylim([-1 4])
legend({'Radiance Water Vapor Retrieval','Polarized Water Vapor Retrieval','Net Water Vapor Retrieval'},'FontSize',6,'Location','northeast')
set(gca,'linewidth',1)

%Save RSP Quicklooks
rsp_file_name = strcat(date_str,'_RSP.png')
saveas(figure(1), rsp_file_name)
clf

%Make HSLR Quicklooks
%Get Max and Min values for Images
time_min = min(gps_time)
time_max = max(gps_time)
alt_min = min(gps_alt)
alt_max = max(gps_alt)

%Altitude subplot
date = [date_str_hslr(5:6),'/',date_str_hslr(7:8),'/',date_str_hslr(1:4)]
hsrl = ["HSRL Data - "]
hsrl_title = strcat(hsrl,date)
subplot(4,1,1);
plot(gps_time, gps_alt,'linewidth',2)
grid on
xlim([time_min time_max])
ylabel('Altitude (m)','Fontsize',16)
title(hsrl_title,'Fontsize',16)
set(gca,'linewidth',1)

%Cloud Top Height subplot
subplot(4,1,2);
plot(gps_time, cloud_top_height,'linewidth',2)
grid on
xlabel('Time (UTC)','Fontsize',16)
ylabel('C.T.H. (m)','Fontsize',16)
ylim([0 8000])
xlim([time_min time_max])
set(gca,'linewidth',1)

%Backscattering subplot
subplot(4,1,3);
image([time_min time_max], [alt_min alt_max], bsc_532*1000000)
colorbar
h = colorbar
ylabel(h, 'Backscattering (Gm^-^1sr^-^1)','Fontsize',10)
ylabel('Altitude (m)','Fontsize',16)
ax = gca;
ax.YDir = 'normal'

%Extinction subplot
subplot(4,1,4);
imagesc([time_min time_max], [alt_min alt_max], ext_532)
h = colorbar
ylabel(h, 'Extinction (km^-^1)','Fontsize',10)
xlabel('Time (UTC)','Fontsize',16)
ylabel('Altitude (m)','Fontsize',16)
ax = gca;
ax.YDir = 'normal'

%Save HSRL Quicklooks
hsrl_file_name = strcat(date_str,'_HSRL.png')
saveas(figure(1), hsrl_file_name)
clf
clear

%2/27/2020 Files
%Combine 2/27 Flight RSP Files

h5file = 'ACTIVATE-HSRL2_UC12_20200227_RA.h5'

ncfile1 = 'RSP1-UC12_20200227_T185428-192748_wcld_v1_1.nc'
ncfile2 = 'RSP1-UC12_20200227_T193112-195824_wcld_v1_1.nc'
ncfile3 = 'RSP1-UC12_20200227_T202647-205054_wcld_v1_1.nc'

lon1 = ncread(ncfile1,'lon')
lat1 = ncread(ncfile1,'lat')
time_utc1 = ncread(ncfile1,'time_utc')
alt_aggr1 = ncread(ncfile1,'alt_aggr')
cloud_ot_863nm1 = ncread(ncfile1,'cloud_ot_863nm')
cloud_reff_pol_863nm1 = ncread(ncfile1,'cloud_reff_pol_863nm')
cloud_reff_nk1 = ncread(ncfile1,'cloud_reff_nk')
cloud_reff_nk_1588nm1 = cloud_reff_nk1(:,1)
cloud_veff_pol_863nm1 = ncread(ncfile1,'cloud_veff_pol_863nm')
wv_column_nk1 = ncread(ncfile1,'wv_column_nk')
wv_column_pol1 = ncread(ncfile1,'wv_column_pol')

lon2 = ncread(ncfile2,'lon')
lat2 = ncread(ncfile2,'lat')
time_utc2 = ncread(ncfile2,'time_utc')
alt_aggr2 = ncread(ncfile2,'alt_aggr')
cloud_ot_863nm2 = ncread(ncfile2,'cloud_ot_863nm')
cloud_reff_pol_863nm2 = ncread(ncfile2,'cloud_reff_pol_863nm')
cloud_reff_nk2 = ncread(ncfile2,'cloud_reff_nk')
cloud_reff_nk_1588nm2 = cloud_reff_nk2(:,1)
cloud_veff_pol_863nm2 = ncread(ncfile2,'cloud_veff_pol_863nm')
wv_column_nk2 = ncread(ncfile2,'wv_column_nk')
wv_column_pol2 = ncread(ncfile2,'wv_column_pol')

lon3 = ncread(ncfile3,'lon')
lat3 = ncread(ncfile3,'lat')
time_utc3 = ncread(ncfile3,'time_utc')
alt_aggr3 = ncread(ncfile3,'alt_aggr')
cloud_ot_863nm3 = ncread(ncfile3,'cloud_ot_863nm')
cloud_reff_pol_863nm3 = ncread(ncfile3,'cloud_reff_pol_863nm')
cloud_reff_nk3 = ncread(ncfile3,'cloud_reff_nk')
cloud_reff_nk_1588nm3 = cloud_reff_nk3(:,1)
cloud_veff_pol_863nm3 = ncread(ncfile3,'cloud_veff_pol_863nm')
wv_column_nk3 = ncread(ncfile3,'wv_column_nk')
wv_column_pol3 = ncread(ncfile3,'wv_column_pol')

lon = vertcat(lon1, lon2, lon3)
lat = vertcat(lat1, lat2, lat3)
time_utc = vertcat(time_utc1, time_utc2, time_utc3)
alt_aggr = vertcat(alt_aggr1, alt_aggr2, alt_aggr3)
cloud_ot_863nm = vertcat(cloud_ot_863nm1, cloud_ot_863nm2, cloud_ot_863nm3)
cloud_reff_pol_863nm = vertcat(cloud_reff_pol_863nm1, cloud_reff_pol_863nm2, cloud_reff_pol_863nm3)
cloud_reff_nk = vertcat(cloud_reff_nk1, cloud_reff_nk2, cloud_reff_nk3)
cloud_reff_nk_1588nm = vertcat(cloud_reff_nk_1588nm1, cloud_reff_nk_1588nm2, cloud_reff_nk_1588nm3)
cloud_veff_pol_863nm = vertcat(cloud_veff_pol_863nm1, cloud_veff_pol_863nm2, cloud_veff_pol_863nm3)
wv_column_nk = vertcat(wv_column_nk1, wv_column_nk2, wv_column_nk3)
wv_column_pol = vertcat(wv_column_pol1, wv_column_pol2, wv_column_pol3)

%Change -999 values to NaN
lId = cloud_ot_863nm == -999;
cloud_ot_863nm(lId) = NaN
lId = cloud_reff_pol_863nm == -999;
cloud_reff_pol_863nm(lId) = NaN
lId = cloud_veff_pol_863nm == -999;
cloud_veff_pol_863nm(lId) = NaN
lId = cloud_reff_nk_1588nm == -999;
cloud_reff_nk_1588nm(lId) = NaN
lId = wv_column_nk == -999;
wv_column_nk(lId) = NaN
lId = wv_column_pol == -999;
wv_column_pol(lId) = NaN
lId = wv_column_pol == -999;
wv_column_pol(lId) = NaN
wv_column = wv_column_nk - wv_column_pol

%Create Matlab File
date_str = extractAfter(ncfile1,10)
date_str = extractBefore(date_str,9)
filename = strcat('RSP-HSRL_',date_str,'.mat')

%Download HSLR Data from file
gps_alt = h5read(h5file,'/Nav_Data/gps_alt')
gps_lat = h5read(h5file,'/Nav_Data/gps_lat')
gps_lon = h5read(h5file,'/Nav_Data/gps_lon')
gps_time = h5read(h5file,'/Nav_Data/gps_time')
bsc_532 = h5read(h5file,'/DataProducts/532_bsc')
ext_532 = h5read(h5file,'/DataProducts/532_ext')
cloud_top_height = h5read(h5file,'/DataProducts/cloud_top_height')
Altitude = h5read(h5file,'/DataProducts/Altitude')
Temperature = h5read(h5file,'/State/Temperature')
Pressure = h5read(h5file,'/State/Pressure')

%Create Matlab file
date_str_hslr = extractAfter(h5file,20)
date_str_hslr = extractBefore(date_str_hslr,9)

%Add on Flight Information if Necessary
flight = extractAfter(h5file,32)
flight = extractBefore(flight,3)
tf1 = strcmp("L1",flight)
tf2 = strcmp("L2",flight)
tfh5 = strcmp("h5",flight)
if tf1 == 0 & tf2 == 0
    flight = []
end
if tf1 == 1
    flight = "_Flight_1"
end
if tf2 == 1
    flight = "_Flight_2"
end

%Save HSLR Data to file
filename = strcat('RSP-HSRL_',date_str_hslr,flight,'.mat')
save(filename,'gps_alt','gps_lat','gps_lon','gps_time','bsc_532','ext_532','cloud_top_height','Altitude','Temperature','Pressure','alt_aggr','cloud_ot_863nm','cloud_reff_nk','cloud_reff_nk_1588nm','cloud_reff_pol_863nm','cloud_veff_pol_863nm','lat','lon','time_utc','wv_column','wv_column_nk','wv_column_pol')

%Create RSP Quicklooks
%Optical Thickness subplot
date = [date_str(5:6),'/',date_str(7:8),'/',date_str(1:4)]
rsp = ["RSP Data - "]

rsp_title = strcat(rsp,date)

subplot(4,1,1);
plot(time_utc, cloud_ot_863nm,'linewidth',2)
grid on
ylabel('Optical Thickness','Fontsize',14)
ylim([0 80])
title(rsp_title,'Fontsize',14)
set(gca,'linewidth',1)

%Effective Radius subplot
subplot(4,1,2);
plot(time_utc, cloud_reff_nk_1588nm, 'linewidth',2)
hold on
grid on
plot(time_utc, cloud_reff_pol_863nm,'linewidth',2)
ylabel('R_e_f_f (\mum)','Fontsize',14)
ylim([0 40])
legend({'NK 1588','Polarized'},'FontSize',6,'Location','northeast')
set(gca,'linewidth',1)

%Effective Variance subplot
subplot(4,1,3);
plot(time_utc, cloud_veff_pol_863nm,'linewidth',2)
grid on
ylabel('V_e_f_f','Fontsize',14)
ylim([0 .4])
set(gca,'linewidth',1)

%Water Vapor subplot
subplot(4,1,4);
hold on
grid on
plot(time_utc, wv_column_nk, 'LineWidth',2)
plot(time_utc, wv_column_pol, 'LineWidth',2)
plot(time_utc, wv_column, 'LineWidth', 3)
xlabel('Time (UTC)','Fontsize',14)
ylabel('W.V. (cm atm^-^1)','Fontsize',14)
ylim([-1 4])
legend({'Radiance Water Vapor Retrieval','Polarized Water Vapor Retrieval','Net Water Vapor Retrieval'},'FontSize',6,'Location','northeast')
set(gca,'linewidth',1)

%Save RSP Quicklooks
rsp_file_name = strcat(date_str,'_RSP.png')
saveas(figure(1), rsp_file_name)
clf

%Make HSLR Quicklooks
%Get Max and Min values for Images
time_min = min(gps_time)
time_max = max(gps_time)
alt_min = min(gps_alt)
alt_max = max(gps_alt)

%Altitude subplot
date = [date_str_hslr(5:6),'/',date_str_hslr(7:8),'/',date_str_hslr(1:4)]
hsrl = ["HSRL Data - "]
hsrl_title = strcat(hsrl,date)
subplot(4,1,1);
plot(gps_time, gps_alt,'linewidth',2)
grid on
xlim([time_min time_max])
ylabel('Altitude (m)','Fontsize',16)
title(hsrl_title,'Fontsize',16)
set(gca,'linewidth',1)

%Cloud Top Height subplot
subplot(4,1,2);
plot(gps_time, cloud_top_height,'linewidth',2)
grid on
xlabel('Time (UTC)','Fontsize',16)
ylabel('C.T.H. (m)','Fontsize',16)
ylim([0 8000])
xlim([time_min time_max])
set(gca,'linewidth',1)

%Backscattering subplot
subplot(4,1,3);
image([time_min time_max], [alt_min alt_max], bsc_532*1000000)
colorbar
h = colorbar
ylabel(h, 'Backscattering (Gm^-^1sr^-^1)','Fontsize',10)
ylabel('Altitude (m)','Fontsize',16)
ax = gca;
ax.YDir = 'normal'

%Extinction subplot
subplot(4,1,4);
imagesc([time_min time_max], [alt_min alt_max], ext_532)
h = colorbar
ylabel(h, 'Extinction (km^-^1)','Fontsize',10)
xlabel('Time (UTC)','Fontsize',16)
ylabel('Altitude (m)','Fontsize',16)
ax = gca;
ax.YDir = 'normal'

%Save HSRL Quicklooks
hsrl_file_name = strcat(date_str,'_HSRL.png')
saveas(figure(1), hsrl_file_name)
clf

%2/28/2020 Files Flight 1
%Combine 2/28 Flight 1 RSP Files

h5file = 'ACTIVATE-HSRL2_UC12_20200228_RA_L1.h5'

ncfile1 = 'RSP1-UC12_20200228_T142653-150948_wcld_v1_1.nc'
ncfile2 = 'RSP1-UC12_20200228_T155705-160113_wcld_v1_1.nc'
ncfile3 = 'RSP1-UC12_20200228_T162030-162646_wcld_v1_1.nc'
ncfile4 = 'RSP1-UC12_20200228_T164646-170612_wcld_v1_1.nc'

lon1 = ncread(ncfile1,'lon')
lat1 = ncread(ncfile1,'lat')
time_utc1 = ncread(ncfile1,'time_utc')
alt_aggr1 = ncread(ncfile1,'alt_aggr')
cloud_ot_863nm1 = ncread(ncfile1,'cloud_ot_863nm')
cloud_reff_pol_863nm1 = ncread(ncfile1,'cloud_reff_pol_863nm')
cloud_reff_nk1 = ncread(ncfile1,'cloud_reff_nk')
cloud_reff_nk_1588nm1 = cloud_reff_nk1(:,1)
cloud_veff_pol_863nm1 = ncread(ncfile1,'cloud_veff_pol_863nm')
wv_column_nk1 = ncread(ncfile1,'wv_column_nk')
wv_column_pol1 = ncread(ncfile1,'wv_column_pol')

lon2 = ncread(ncfile2,'lon')
lat2 = ncread(ncfile2,'lat')
time_utc2 = ncread(ncfile2,'time_utc')
alt_aggr2 = ncread(ncfile2,'alt_aggr')
cloud_ot_863nm2 = ncread(ncfile2,'cloud_ot_863nm')
cloud_reff_pol_863nm2 = ncread(ncfile2,'cloud_reff_pol_863nm')
cloud_reff_nk2 = ncread(ncfile2,'cloud_reff_nk')
cloud_reff_nk_1588nm2 = cloud_reff_nk2(:,1)
cloud_veff_pol_863nm2 = ncread(ncfile2,'cloud_veff_pol_863nm')
wv_column_nk2 = ncread(ncfile2,'wv_column_nk')
wv_column_pol2 = ncread(ncfile2,'wv_column_pol')

lon3 = ncread(ncfile3,'lon')
lat3 = ncread(ncfile3,'lat')
time_utc3 = ncread(ncfile3,'time_utc')
alt_aggr3 = ncread(ncfile3,'alt_aggr')
cloud_ot_863nm3 = ncread(ncfile3,'cloud_ot_863nm')
cloud_reff_pol_863nm3 = ncread(ncfile3,'cloud_reff_pol_863nm')
cloud_reff_nk3 = ncread(ncfile3,'cloud_reff_nk')
cloud_reff_nk_1588nm3 = cloud_reff_nk3(:,1)
cloud_veff_pol_863nm3 = ncread(ncfile3,'cloud_veff_pol_863nm')
wv_column_nk3 = ncread(ncfile3,'wv_column_nk')
wv_column_pol3 = ncread(ncfile3,'wv_column_pol')

lon4 = ncread(ncfile4,'lon')
lat4 = ncread(ncfile4,'lat')
time_utc4 = ncread(ncfile4,'time_utc')
alt_aggr4 = ncread(ncfile4,'alt_aggr')
cloud_ot_863nm4 = ncread(ncfile4,'cloud_ot_863nm')
cloud_reff_pol_863nm4 = ncread(ncfile4,'cloud_reff_pol_863nm')
cloud_reff_nk4 = ncread(ncfile4,'cloud_reff_nk')
cloud_reff_nk_1588nm4 = cloud_reff_nk4(:,1)
cloud_veff_pol_863nm4 = ncread(ncfile4,'cloud_veff_pol_863nm')
wv_column_nk4 = ncread(ncfile4,'wv_column_nk')
wv_column_pol4 = ncread(ncfile4,'wv_column_pol')

lon = vertcat(lon1, lon2, lon3, lon4)
lat = vertcat(lat1, lat2, lat3, lat4)
time_utc = vertcat(time_utc1, time_utc2, time_utc3, time_utc4)
alt_aggr = vertcat(alt_aggr1, alt_aggr2, alt_aggr3, alt_aggr4)
cloud_ot_863nm = vertcat(cloud_ot_863nm1, cloud_ot_863nm2, cloud_ot_863nm3, cloud_ot_863nm4)
cloud_reff_pol_863nm = vertcat(cloud_reff_pol_863nm1, cloud_reff_pol_863nm2, cloud_reff_pol_863nm3, cloud_reff_pol_863nm4)
cloud_reff_nk = vertcat(cloud_reff_nk1, cloud_reff_nk2, cloud_reff_nk3, cloud_reff_nk4)
cloud_reff_nk_1588nm = vertcat(cloud_reff_nk_1588nm1, cloud_reff_nk_1588nm2, cloud_reff_nk_1588nm3, cloud_reff_nk_1588nm4)
cloud_veff_pol_863nm = vertcat(cloud_veff_pol_863nm1, cloud_veff_pol_863nm2, cloud_veff_pol_863nm3, cloud_veff_pol_863nm4)
wv_column_nk = vertcat(wv_column_nk1, wv_column_nk2, wv_column_nk3, wv_column_nk4)
wv_column_pol = vertcat(wv_column_pol1, wv_column_pol2, wv_column_pol3, wv_column_pol4)

%Change -999 values to NaN
lId = cloud_ot_863nm == -999;
cloud_ot_863nm(lId) = NaN
lId = cloud_reff_pol_863nm == -999;
cloud_reff_pol_863nm(lId) = NaN
lId = cloud_veff_pol_863nm == -999;
cloud_veff_pol_863nm(lId) = NaN
lId = cloud_reff_nk_1588nm == -999;
cloud_reff_nk_1588nm(lId) = NaN
lId = wv_column_nk == -999;
wv_column_nk(lId) = NaN
lId = wv_column_pol == -999;
wv_column_pol(lId) = NaN
lId = wv_column_pol == -999;
wv_column_pol(lId) = NaN
wv_column = wv_column_nk - wv_column_pol

%Create Matlab File
date_str = extractAfter(ncfile1,10)
date_str = extractBefore(date_str,9)
filename = strcat('RSP-HSRL_',date_str,'.mat')

%Download HSLR Data from file
gps_alt = h5read(h5file,'/Nav_Data/gps_alt')
gps_lat = h5read(h5file,'/Nav_Data/gps_lat')
gps_lon = h5read(h5file,'/Nav_Data/gps_lon')
gps_time = h5read(h5file,'/Nav_Data/gps_time')
bsc_532 = h5read(h5file,'/DataProducts/532_bsc')
ext_532 = h5read(h5file,'/DataProducts/532_ext')
cloud_top_height = h5read(h5file,'/DataProducts/cloud_top_height')
Altitude = h5read(h5file,'/DataProducts/Altitude')
Temperature = h5read(h5file,'/State/Temperature')
Pressure = h5read(h5file,'/State/Pressure')

%Create Matlab file
date_str_hslr = extractAfter(h5file,20)
date_str_hslr = extractBefore(date_str_hslr,9)

%Add on Flight Information if Necessary
flight = extractAfter(h5file,32)
flight = extractBefore(flight,3)
tf1 = strcmp("L1",flight)
tf2 = strcmp("L2",flight)
tfh5 = strcmp("h5",flight)
if tf1 == 0 & tf2 == 0
    flight = []
end
if tf1 == 1
    flight = "_Flight_1"
end
if tf2 == 1
    flight = "_Flight_2"
end

%Save HSLR Data to file
filename = strcat('RSP-HSRL_',date_str_hslr,flight,'.mat')
save(filename,'gps_alt','gps_lat','gps_lon','gps_time','bsc_532','ext_532','cloud_top_height','Altitude','Temperature','Pressure','alt_aggr','cloud_ot_863nm','cloud_reff_nk','cloud_reff_nk_1588nm','cloud_reff_pol_863nm','cloud_veff_pol_863nm','lat','lon','time_utc','wv_column','wv_column_nk','wv_column_pol')

%Create RSP Quicklooks
%Optical Thickness subplot
date = [date_str(5:6),'/',date_str(7:8),'/',date_str(1:4)]
date = ' 02/28/2020'
rsp = ["RSP Data - "]

rsp_title = strcat(rsp,'Flight 1 - ',date)

subplot(4,1,1);
plot(time_utc, cloud_ot_863nm,'linewidth',2)
grid on
ylabel('Optical Thickness','Fontsize',14)
ylim([0 80])
title(rsp_title,'Fontsize',14)
set(gca,'linewidth',1)

%Effective Radius subplot
subplot(4,1,2);
plot(time_utc, cloud_reff_nk_1588nm, 'linewidth',2)
hold on
grid on
plot(time_utc, cloud_reff_pol_863nm,'linewidth',2)
ylabel('R_e_f_f (\mum)','Fontsize',14)
ylim([0 40])
legend({'NK 1588','Polarized'},'FontSize',6,'Location','northeast')
set(gca,'linewidth',1)

%Effective Variance subplot
subplot(4,1,3);
plot(time_utc, cloud_veff_pol_863nm,'linewidth',2)
grid on
ylabel('V_e_f_f','Fontsize',14)
ylim([0 .4])
set(gca,'linewidth',1)

%Water Vapor subplot
subplot(4,1,4);
hold on
grid on
plot(time_utc, wv_column_nk, 'LineWidth',2)
plot(time_utc, wv_column_pol, 'LineWidth',2)
plot(time_utc, wv_column, 'LineWidth', 3)
xlabel('Time (UTC)','Fontsize',14)
ylabel('W.V. (cm atm^-^1)','Fontsize',14)
ylim([-1 4])
legend({'Radiance Water Vapor Retrieval','Polarized Water Vapor Retrieval','Net Water Vapor Retrieval'},'FontSize',6,'Location','northeast')
set(gca,'linewidth',1)

%Save RSP Quicklooks
rsp_file_name = strcat(date_str,'F1_RSP.png')
saveas(figure(1), rsp_file_name)
clf

%Make HSLR Quicklooks
%Get Max and Min values for Images
time_min = min(gps_time)
time_max = max(gps_time)
alt_min = min(gps_alt)
alt_max = max(gps_alt)

%Altitude subplot
date = [date_str_hslr(5:6),'/',date_str_hslr(7:8),'/',date_str_hslr(1:4)]
hsrl = ["HSRL Data - "]
hsrl_title = strcat(hsrl,'Flight 1 - 02/28/2020')
subplot(4,1,1);
plot(gps_time, gps_alt,'linewidth',2)
grid on
xlim([time_min time_max])
ylabel('Altitude (m)','Fontsize',16)
title(hsrl_title,'Fontsize',16)
set(gca,'linewidth',1)

%Cloud Top Height subplot
subplot(4,1,2);
plot(gps_time, cloud_top_height,'linewidth',2)
grid on
xlabel('Time (UTC)','Fontsize',16)
ylabel('C.T.H. (m)','Fontsize',16)
ylim([0 8000])
xlim([time_min time_max])
set(gca,'linewidth',1)

%Backscattering subplot
subplot(4,1,3);
image([time_min time_max], [alt_min alt_max], bsc_532*1000000)
colorbar
h = colorbar
ylabel(h, 'Backscattering (Gm^-^1sr^-^1)','Fontsize',10)
ylabel('Altitude (m)','Fontsize',16)
ax = gca;
ax.YDir = 'normal'

%Extinction subplot
subplot(4,1,4);
imagesc([time_min time_max], [alt_min alt_max], ext_532)
h = colorbar
ylabel(h, 'Extinction (km^-^1)','Fontsize',10)
xlabel('Time (UTC)','Fontsize',16)
ylabel('Altitude (m)','Fontsize',16)
ax = gca;
ax.YDir = 'normal'

%Save HSRL Quicklooks
hsrl_file_name = strcat(date_str,'F1_HSRL.png')
saveas(figure(1), hsrl_file_name)
clf

%2/28/2020 Files Flight 2
%Combine 2/28 Flight 2 RSP Files

h5file = 'ACTIVATE-HSRL2_UC12_20200228_RA_L2.h5'

ncfile1 = 'RSP1-UC12_20200228_T204654-205811_wcld_v1_1.nc'
ncfile2 = 'RSP1-UC12_20200228_T210323-215344_wcld_v1_1.nc'

lon1 = ncread(ncfile1,'lon')
lat1 = ncread(ncfile1,'lat')
time_utc1 = ncread(ncfile1,'time_utc')
alt_aggr1 = ncread(ncfile1,'alt_aggr')
cloud_ot_863nm1 = ncread(ncfile1,'cloud_ot_863nm')
cloud_reff_pol_863nm1 = ncread(ncfile1,'cloud_reff_pol_863nm')
cloud_reff_nk1 = ncread(ncfile1,'cloud_reff_nk')
cloud_reff_nk_1588nm1 = cloud_reff_nk1(:,1)
cloud_veff_pol_863nm1 = ncread(ncfile1,'cloud_veff_pol_863nm')
wv_column_nk1 = ncread(ncfile1,'wv_column_nk')
wv_column_pol1 = ncread(ncfile1,'wv_column_pol')

lon2 = ncread(ncfile2,'lon')
lat2 = ncread(ncfile2,'lat')
time_utc2 = ncread(ncfile2,'time_utc')
alt_aggr2 = ncread(ncfile2,'alt_aggr')
cloud_ot_863nm2 = ncread(ncfile2,'cloud_ot_863nm')
cloud_reff_pol_863nm2 = ncread(ncfile2,'cloud_reff_pol_863nm')
cloud_reff_nk2 = ncread(ncfile2,'cloud_reff_nk')
cloud_reff_nk_1588nm2 = cloud_reff_nk2(:,1)
cloud_veff_pol_863nm2 = ncread(ncfile2,'cloud_veff_pol_863nm')
wv_column_nk2 = ncread(ncfile2,'wv_column_nk')
wv_column_pol2 = ncread(ncfile2,'wv_column_pol')

lon = vertcat(lon1, lon2)
lat = vertcat(lat1, lat2)
time_utc = vertcat(time_utc1, time_utc2)
alt_aggr = vertcat(alt_aggr1, alt_aggr2)
cloud_ot_863nm = vertcat(cloud_ot_863nm1, cloud_ot_863nm2)
cloud_reff_pol_863nm = vertcat(cloud_reff_pol_863nm1, cloud_reff_pol_863nm2)
cloud_reff_nk = vertcat(cloud_reff_nk1, cloud_reff_nk2)
cloud_veff_pol_863nm = vertcat(cloud_veff_pol_863nm1, cloud_veff_pol_863nm2)
cloud_reff_nk_1588nm = vertcat(cloud_reff_nk_1588nm1, cloud_reff_nk_1588nm2)
wv_column_nk = vertcat(wv_column_nk1, wv_column_nk2)
wv_column_pol = vertcat(wv_column_pol1, wv_column_pol2)

%Change -999 values to NaN
lId = cloud_ot_863nm == -999;
cloud_ot_863nm(lId) = NaN
lId = cloud_reff_pol_863nm == -999;
cloud_reff_pol_863nm(lId) = NaN
lId = cloud_veff_pol_863nm == -999;
cloud_veff_pol_863nm(lId) = NaN
lId = cloud_reff_nk_1588nm == -999;
cloud_reff_nk_1588nm(lId) = NaN
lId = wv_column_nk == -999;
wv_column_nk(lId) = NaN
lId = wv_column_pol == -999;
wv_column_pol(lId) = NaN
lId = wv_column_pol == -999;
wv_column_pol(lId) = NaN
wv_column = wv_column_nk - wv_column_pol

%Create Matlab File
date_str = extractAfter(ncfile1,10)
date_str = extractBefore(date_str,9)
filename = strcat('RSP-HSRL_',date_str,'.mat')

%Download HSLR Data from file
gps_alt = h5read(h5file,'/Nav_Data/gps_alt')
gps_lat = h5read(h5file,'/Nav_Data/gps_lat')
gps_lon = h5read(h5file,'/Nav_Data/gps_lon')
gps_time = h5read(h5file,'/Nav_Data/gps_time')
bsc_532 = h5read(h5file,'/DataProducts/532_bsc')
ext_532 = h5read(h5file,'/DataProducts/532_ext')
cloud_top_height = h5read(h5file,'/DataProducts/cloud_top_height')
Altitude = h5read(h5file,'/DataProducts/Altitude')
Temperature = h5read(h5file,'/State/Temperature')
Pressure = h5read(h5file,'/State/Pressure')

%Create Matlab file
date_str_hslr = extractAfter(h5file,20)
date_str_hslr = extractBefore(date_str_hslr,9)

%Add on Flight Information if Necessary
flight = extractAfter(h5file,32)
flight = extractBefore(flight,3)
tf1 = strcmp("L1",flight)
tf2 = strcmp("L2",flight)
tfh5 = strcmp("h5",flight)
if tf1 == 0 & tf2 == 0
    flight = []
end
if tf1 == 1
    flight = "_Flight_1"
end
if tf2 == 1
    flight = "_Flight_2"
end

%Save HSLR Data to file
filename = strcat('RSP-HSRL_',date_str_hslr,flight,'.mat')
save(filename,'gps_alt','gps_lat','gps_lon','gps_time','bsc_532','ext_532','cloud_top_height','Altitude','Temperature','Pressure','alt_aggr','cloud_ot_863nm','cloud_reff_nk','cloud_reff_nk_1588nm','cloud_reff_pol_863nm','cloud_veff_pol_863nm','lat','lon','time_utc','wv_column','wv_column_nk','wv_column_pol')

%Create RSP Quicklooks
%Optical Thickness subplot
date = [date_str(5:6),'/',date_str(7:8),'/',date_str(1:4)]
date = ' 02/28/2020'
rsp = ["RSP Data - "]

rsp_title = strcat(rsp,'Flight 2 - ',date)

subplot(4,1,1);
plot(time_utc, cloud_ot_863nm,'linewidth',2)
grid on
ylabel('Optical Thickness','Fontsize',14)
ylim([0 80])
title(rsp_title,'Fontsize',14)
set(gca,'linewidth',1)

%Effective Radius subplot
subplot(4,1,2);
plot(time_utc, cloud_reff_nk_1588nm, 'linewidth',2)
hold on
grid on
plot(time_utc, cloud_reff_pol_863nm,'linewidth',2)
ylabel('R_e_f_f (\mum)','Fontsize',14)
ylim([0 40])
legend({'NK 1588','Polarized'},'FontSize',6,'Location','northeast')
set(gca,'linewidth',1)

%Effective Variance subplot
subplot(4,1,3);
plot(time_utc, cloud_veff_pol_863nm,'linewidth',2)
grid on
ylabel('V_e_f_f','Fontsize',14)
ylim([0 .4])
set(gca,'linewidth',1)

%Water Vapor subplot
subplot(4,1,4);
hold on
grid on
plot(time_utc, wv_column_nk, 'LineWidth',2)
plot(time_utc, wv_column_pol, 'LineWidth',2)
plot(time_utc, wv_column, 'LineWidth', 3)
xlabel('Time (UTC)','Fontsize',14)
ylabel('W.V. (cm atm^-^1)','Fontsize',14)
ylim([-1 4])
legend({'Radiance Water Vapor Retrieval','Polarized Water Vapor Retrieval','Net Water Vapor Retrieval'},'FontSize',6,'Location','northeast')
set(gca,'linewidth',1)

%Save RSP Quicklooks
rsp_file_name = strcat(date_str,'F2_RSP.png')
saveas(figure(1), rsp_file_name)
clf

%Make HSLR Quicklooks
%Get Max and Min values for Images
time_min = min(gps_time)
time_max = max(gps_time)
alt_min = min(gps_alt)
alt_max = max(gps_alt)

%Altitude subplot
date = [date_str_hslr(5:6),'/',date_str_hslr(7:8),'/',date_str_hslr(1:4)]
hsrl = ["HSRL Data - "]
hsrl_title = strcat(hsrl,'Flight 2 - 02/28/2020')
subplot(4,1,1);
plot(gps_time, gps_alt,'linewidth',2)
grid on
xlim([time_min time_max])
ylabel('Altitude (m)','Fontsize',16)
title(hsrl_title,'Fontsize',16)
set(gca,'linewidth',1)

%Cloud Top Height subplot
subplot(4,1,2);
plot(gps_time, cloud_top_height,'linewidth',2)
grid on
xlabel('Time (UTC)','Fontsize',16)
ylabel('C.T.H. (m)','Fontsize',16)
ylim([0 8000])
xlim([time_min time_max])
set(gca,'linewidth',1)

%Backscattering subplot
subplot(4,1,3);
image([time_min time_max], [alt_min alt_max], bsc_532*1000000)
colorbar
h = colorbar
ylabel(h, 'Backscattering (Gm^-^1sr^-^1)','Fontsize',10)
ylabel('Altitude (m)','Fontsize',16)
ax = gca;
ax.YDir = 'normal'

%Extinction subplot
subplot(4,1,4);
imagesc([time_min time_max], [alt_min alt_max], ext_532)
h = colorbar
ylabel(h, 'Extinction (km^-^1)','Fontsize',10)
xlabel('Time (UTC)','Fontsize',16)
ylabel('Altitude (m)','Fontsize',16)
ax = gca;
ax.YDir = 'normal'

%Save HSRL Quicklooks
hsrl_file_name = strcat(date_str,'F2_HSRL.png')
saveas(figure(1), hsrl_file_name)
clf

%3/1/2020 Files Flight 1
%Combine 3/1 Flight 1 RSP Files

h5file = 'ACTIVATE-HSRL2_UC12_20200301_RA_L1.h5'

ncfile1 = 'RSP1-UC12_20200301_T145226-145616_wcld_v1_1.nc'
ncfile2 = 'RSP1-UC12_20200301_T151940-152642_wcld_v1_1.nc'
ncfile3 = 'RSP1-UC12_20200301_T152713-153317_wcld_v1_1.nc'

lon1 = ncread(ncfile1,'lon')
lat1 = ncread(ncfile1,'lat')
time_utc1 = ncread(ncfile1,'time_utc')
alt_aggr1 = ncread(ncfile1,'alt_aggr')
cloud_ot_863nm1 = ncread(ncfile1,'cloud_ot_863nm')
cloud_reff_pol_863nm1 = ncread(ncfile1,'cloud_reff_pol_863nm')
cloud_reff_nk1 = ncread(ncfile1,'cloud_reff_nk')
cloud_reff_nk_1588nm1 = cloud_reff_nk1(:,1)
cloud_veff_pol_863nm1 = ncread(ncfile1,'cloud_veff_pol_863nm')
wv_column_nk1 = ncread(ncfile1,'wv_column_nk')
wv_column_pol1 = ncread(ncfile1,'wv_column_pol')

lon2 = ncread(ncfile2,'lon')
lat2 = ncread(ncfile2,'lat')
time_utc2 = ncread(ncfile2,'time_utc')
alt_aggr2 = ncread(ncfile2,'alt_aggr')
cloud_ot_863nm2 = ncread(ncfile2,'cloud_ot_863nm')
cloud_reff_pol_863nm2 = ncread(ncfile2,'cloud_reff_pol_863nm')
cloud_reff_nk2 = ncread(ncfile2,'cloud_reff_nk')
cloud_reff_nk_1588nm2 = cloud_reff_nk2(:,1)
cloud_veff_pol_863nm2 = ncread(ncfile2,'cloud_veff_pol_863nm')
wv_column_nk2 = ncread(ncfile2,'wv_column_nk')
wv_column_pol2 = ncread(ncfile2,'wv_column_pol')

lon3 = ncread(ncfile3,'lon')
lat3 = ncread(ncfile3,'lat')
time_utc3 = ncread(ncfile3,'time_utc')
alt_aggr3 = ncread(ncfile3,'alt_aggr')
cloud_ot_863nm3 = ncread(ncfile3,'cloud_ot_863nm')
cloud_reff_pol_863nm3 = ncread(ncfile3,'cloud_reff_pol_863nm')
cloud_reff_nk3 = ncread(ncfile3,'cloud_reff_nk')
cloud_reff_nk_1588nm3 = cloud_reff_nk3(:,1)
cloud_veff_pol_863nm3 = ncread(ncfile3,'cloud_veff_pol_863nm')
wv_column_nk3 = ncread(ncfile3,'wv_column_nk')
wv_column_pol3 = ncread(ncfile3,'wv_column_pol')

lon = vertcat(lon1, lon2, lon3)
lat = vertcat(lat1, lat2, lat3)
time_utc = vertcat(time_utc1, time_utc2, time_utc3)
alt_aggr = vertcat(alt_aggr1, alt_aggr2, alt_aggr3)
cloud_ot_863nm = vertcat(cloud_ot_863nm1, cloud_ot_863nm2, cloud_ot_863nm3)
cloud_reff_pol_863nm = vertcat(cloud_reff_pol_863nm1, cloud_reff_pol_863nm2, cloud_reff_pol_863nm3)
cloud_reff_nk = vertcat(cloud_reff_nk1, cloud_reff_nk2, cloud_reff_nk3)
cloud_reff_nk_1588nm = vertcat(cloud_reff_nk_1588nm1, cloud_reff_nk_1588nm2, cloud_reff_nk_1588nm3)
cloud_veff_pol_863nm = vertcat(cloud_veff_pol_863nm1, cloud_veff_pol_863nm2, cloud_veff_pol_863nm3)
wv_column_nk = vertcat(wv_column_nk1, wv_column_nk2, wv_column_nk3)
wv_column_pol = vertcat(wv_column_pol1, wv_column_pol2, wv_column_pol3)

%Change -999 values to NaN
lId = cloud_ot_863nm == -999;
cloud_ot_863nm(lId) = NaN
lId = cloud_reff_pol_863nm == -999;
cloud_reff_pol_863nm(lId) = NaN
lId = cloud_veff_pol_863nm == -999;
cloud_veff_pol_863nm(lId) = NaN
lId = cloud_reff_nk_1588nm == -999;
cloud_reff_nk_1588nm(lId) = NaN
lId = wv_column_nk == -999;
wv_column_nk(lId) = NaN
lId = wv_column_pol == -999;
wv_column_pol(lId) = NaN
lId = wv_column_pol == -999;
wv_column_pol(lId) = NaN
wv_column = wv_column_nk - wv_column_pol

%Create Matlab File
date_str = extractAfter(ncfile1,10)
date_str = extractBefore(date_str,9)
filename = strcat('RSP-HSRL_',date_str,'.mat')

%Download HSLR Data from file
gps_alt = h5read(h5file,'/Nav_Data/gps_alt')
gps_lat = h5read(h5file,'/Nav_Data/gps_lat')
gps_lon = h5read(h5file,'/Nav_Data/gps_lon')
gps_time = h5read(h5file,'/Nav_Data/gps_time')
bsc_532 = h5read(h5file,'/DataProducts/532_bsc')
ext_532 = h5read(h5file,'/DataProducts/532_ext')
cloud_top_height = h5read(h5file,'/DataProducts/cloud_top_height')
Altitude = h5read(h5file,'/DataProducts/Altitude')
Temperature = h5read(h5file,'/State/Temperature')
Pressure = h5read(h5file,'/State/Pressure')

%Create Matlab file
date_str_hslr = extractAfter(h5file,20)
date_str_hslr = extractBefore(date_str_hslr,9)

%Add on Flight Information if Necessary
flight = extractAfter(h5file,32)
flight = extractBefore(flight,3)
tf1 = strcmp("L1",flight)
tf2 = strcmp("L2",flight)
tfh5 = strcmp("h5",flight)
if tf1 == 0 & tf2 == 0
    flight = []
end
if tf1 == 1
    flight = "_Flight_1"
end
if tf2 == 1
    flight = "_Flight_2"
end

%Save HSLR Data to file
filename = strcat('RSP-HSRL_',date_str_hslr,flight,'.mat')
save(filename,'gps_alt','gps_lat','gps_lon','gps_time','bsc_532','ext_532','cloud_top_height','Altitude','Temperature','Pressure','alt_aggr','cloud_ot_863nm','cloud_reff_nk','cloud_reff_nk_1588nm','cloud_reff_pol_863nm','cloud_veff_pol_863nm','lat','lon','time_utc','wv_column','wv_column_nk','wv_column_pol')

%Create RSP Quicklooks
%Optical Thickness subplot
date = [date_str(5:6),'/',date_str(7:8),'/',date_str(1:4)]
date = ' 03/01/2020'
rsp = ["RSP Data - "]

rsp_title = strcat(rsp,'Flight 1 - ',date)

subplot(4,1,1);
plot(time_utc, cloud_ot_863nm,'linewidth',2)
grid on
ylabel('Optical Thickness','Fontsize',14)
ylim([0 80])
title(rsp_title,'Fontsize',14)
set(gca,'linewidth',1)

%Effective Radius subplot
subplot(4,1,2);
plot(time_utc, cloud_reff_nk_1588nm, 'linewidth',2)
hold on
grid on
plot(time_utc, cloud_reff_pol_863nm,'linewidth',2)
ylabel('R_e_f_f (\mum)','Fontsize',14)
ylim([0 40])
legend({'NK 1588','Polarized'},'FontSize',6,'Location','northeast')
set(gca,'linewidth',1)

%Effective Variance subplot
subplot(4,1,3);
plot(time_utc, cloud_veff_pol_863nm,'linewidth',2)
grid on
ylabel('V_e_f_f','Fontsize',14)
ylim([0 .4])
set(gca,'linewidth',1)

%Water Vapor subplot
subplot(4,1,4);
hold on
grid on
plot(time_utc, wv_column_nk, 'LineWidth',2)
plot(time_utc, wv_column_pol, 'LineWidth',2)
plot(time_utc, wv_column, 'LineWidth', 3)
xlabel('Time (UTC)','Fontsize',14)
ylabel('W.V. (cm atm^-^1)','Fontsize',14)
ylim([-1 4])
legend({'Radiance Water Vapor Retrieval','Polarized Water Vapor Retrieval','Net Water Vapor Retrieval'},'FontSize',6,'Location','northeast')
set(gca,'linewidth',1)

%Save RSP Quicklooks
rsp_file_name = strcat(date_str,'F1_RSP.png')
saveas(figure(1), rsp_file_name)
clf

%Make HSLR Quicklooks
%Get Max and Min values for Images
time_min = min(gps_time)
time_max = max(gps_time)
alt_min = min(gps_alt)
alt_max = max(gps_alt)

%Altitude subplot
date = [date_str_hslr(5:6),'/',date_str_hslr(7:8),'/',date_str_hslr(1:4)]
hsrl = ["HSRL Data - "]
hsrl_title = strcat(hsrl,'Flight 1 - 03/01/2020')
subplot(4,1,1);
plot(gps_time, gps_alt,'linewidth',2)
grid on
xlim([time_min time_max])
ylabel('Altitude (m)','Fontsize',16)
title(hsrl_title,'Fontsize',16)
set(gca,'linewidth',1)

%Cloud Top Height subplot
subplot(4,1,2);
plot(gps_time, cloud_top_height,'linewidth',2)
grid on
xlabel('Time (UTC)','Fontsize',16)
ylabel('C.T.H. (m)','Fontsize',16)
ylim([0 8000])
xlim([time_min time_max])
set(gca,'linewidth',1)

%Backscattering subplot
subplot(4,1,3);
image([time_min time_max], [alt_min alt_max], bsc_532*1000000)
colorbar
h = colorbar
ylabel(h, 'Backscattering (Gm^-^1sr^-^1)','Fontsize',10)
ylabel('Altitude (m)','Fontsize',16)
ax = gca;
ax.YDir = 'normal'

%Extinction subplot
subplot(4,1,4);
imagesc([time_min time_max], [alt_min alt_max], ext_532)
h = colorbar
ylabel(h, 'Extinction (km^-^1)','Fontsize',10)
xlabel('Time (UTC)','Fontsize',16)
ylabel('Altitude (m)','Fontsize',16)
ax = gca;
ax.YDir = 'normal'

%Save HSRL Quicklooks
hsrl_file_name = strcat(date_str,'F1_HSRL.png')
saveas(figure(1), hsrl_file_name)
clf

%3/1/2020 Files Flight 2
%Combine 3/1 Flight 2 RSP Files

h5file = 'ACTIVATE-HSRL2_UC12_20200301_RA_L2.h5'

ncfile = 'RSP1-UC12_20200301_T190609-194137_wcld_v1_1.nc'

lon = ncread(ncfile,'lon')
lat = ncread(ncfile,'lat')
time_utc = ncread(ncfile,'time_utc')
alt_aggr = ncread(ncfile,'alt_aggr')
cloud_ot_863nm = ncread(ncfile,'cloud_ot_863nm')
cloud_reff_pol_863nm = ncread(ncfile,'cloud_reff_pol_863nm')
cloud_reff_nk = ncread(ncfile,'cloud_reff_nk')
cloud_reff_nk_1588nm = cloud_reff_nk(:,1)
cloud_veff_pol_863nm = ncread(ncfile,'cloud_veff_pol_863nm')
wv_column_nk = ncread(ncfile,'wv_column_nk')
wv_column_pol = ncread(ncfile,'wv_column_pol')

%Change -999 values to NaN
lId = cloud_ot_863nm == -999;
cloud_ot_863nm(lId) = NaN
lId = cloud_reff_pol_863nm == -999;
cloud_reff_pol_863nm(lId) = NaN
lId = cloud_veff_pol_863nm == -999;
cloud_veff_pol_863nm(lId) = NaN
lId = cloud_reff_nk_1588nm == -999;
cloud_reff_nk_1588nm(lId) = NaN
lId = wv_column_nk == -999;
wv_column_nk(lId) = NaN
lId = wv_column_pol == -999;
wv_column_pol(lId) = NaN
lId = wv_column_pol == -999;
wv_column_pol(lId) = NaN
wv_column = wv_column_nk - wv_column_pol

%Create Matlab File
date_str = extractAfter(ncfile1,10)
date_str = extractBefore(date_str,9)
filename = strcat('RSP-HSRL_',date_str,'.mat')

%Download HSLR Data from file
gps_alt = h5read(h5file,'/Nav_Data/gps_alt')
gps_lat = h5read(h5file,'/Nav_Data/gps_lat')
gps_lon = h5read(h5file,'/Nav_Data/gps_lon')
gps_time = h5read(h5file,'/Nav_Data/gps_time')
bsc_532 = h5read(h5file,'/DataProducts/532_bsc')
ext_532 = h5read(h5file,'/DataProducts/532_ext')
cloud_top_height = h5read(h5file,'/DataProducts/cloud_top_height')
Altitude = h5read(h5file,'/DataProducts/Altitude')
Temperature = h5read(h5file,'/State/Temperature')
Pressure = h5read(h5file,'/State/Pressure')

%Create Matlab file
date_str_hslr = extractAfter(h5file,20)
date_str_hslr = extractBefore(date_str_hslr,9)

%Add on Flight Information if Necessary
flight = extractAfter(h5file,32)
flight = extractBefore(flight,3)
tf1 = strcmp("L1",flight)
tf2 = strcmp("L2",flight)
tfh5 = strcmp("h5",flight)
if tf1 == 0 & tf2 == 0
    flight = []
end
if tf1 == 1
    flight = "_Flight_1"
end
if tf2 == 1
    flight = "_Flight_2"
end

%Save HSLR Data to file
filename = strcat('RSP-HSRL_',date_str_hslr,flight,'.mat')
save(filename,'gps_alt','gps_lat','gps_lon','gps_time','bsc_532','ext_532','cloud_top_height','Altitude','Temperature','Pressure','alt_aggr','cloud_ot_863nm','cloud_reff_nk','cloud_reff_nk_1588nm','cloud_reff_pol_863nm','cloud_veff_pol_863nm','lat','lon','time_utc','wv_column','wv_column_nk','wv_column_pol')

%Create RSP Quicklooks
%Optical Thickness subplot
date = [date_str(5:6),'/',date_str(7:8),'/',date_str(1:4)]
date = ' 03/01/2020'
rsp = ["RSP Data - "]

rsp_title = strcat(rsp,'Flight 2 - ',date)

subplot(4,1,1);
plot(time_utc, cloud_ot_863nm,'linewidth',2)
grid on
ylabel('Optical Thickness','Fontsize',14)
ylim([0 80])
title(rsp_title,'Fontsize',14)
set(gca,'linewidth',1)

%Effective Radius subplot
subplot(4,1,2);
plot(time_utc, cloud_reff_nk_1588nm, 'linewidth',2)
hold on
grid on
plot(time_utc, cloud_reff_pol_863nm,'linewidth',2)
ylabel('R_e_f_f (\mum)','Fontsize',14)
ylim([0 40])
legend({'NK 1588','Polarized'},'FontSize',6,'Location','northeast')
set(gca,'linewidth',1)

%Effective Variance subplot
subplot(4,1,3);
plot(time_utc, cloud_veff_pol_863nm,'linewidth',2)
grid on
ylabel('V_e_f_f','Fontsize',14)
ylim([0 .4])
set(gca,'linewidth',1)

%Water Vapor subplot
subplot(4,1,4);
hold on
grid on
plot(time_utc, wv_column_nk, 'LineWidth',2)
plot(time_utc, wv_column_pol, 'LineWidth',2)
plot(time_utc, wv_column, 'LineWidth', 3)
xlabel('Time (UTC)','Fontsize',14)
ylabel('W.V. (cm atm^-^1)','Fontsize',14)
ylim([-1 4])
legend({'Radiance Water Vapor Retrieval','Polarized Water Vapor Retrieval','Net Water Vapor Retrieval'},'FontSize',6,'Location','northeast')
set(gca,'linewidth',1)

%Save RSP Quicklooks
rsp_file_name = strcat(date_str,'F2_RSP.png')
saveas(figure(1), rsp_file_name)
clf

%Make HSLR Quicklooks
%Get Max and Min values for Images
time_min = min(gps_time)
time_max = max(gps_time)
alt_min = min(gps_alt)
alt_max = max(gps_alt)

%Altitude subplot
date = [date_str_hslr(5:6),'/',date_str_hslr(7:8),'/',date_str_hslr(1:4)]
hsrl = ["HSRL Data - "]
hsrl_title = strcat(hsrl,'Flight 2 - 03/01/2020')
subplot(4,1,1);
plot(gps_time, gps_alt,'linewidth',2)
grid on
xlim([time_min time_max])
ylabel('Altitude (m)','Fontsize',16)
title(hsrl_title,'Fontsize',16)
set(gca,'linewidth',1)

%Cloud Top Height subplot
subplot(4,1,2);
plot(gps_time, cloud_top_height,'linewidth',2)
grid on
xlabel('Time (UTC)','Fontsize',16)
ylabel('C.T.H. (m)','Fontsize',16)
ylim([0 8000])
xlim([time_min time_max])
set(gca,'linewidth',1)

%Backscattering subplot
subplot(4,1,3);
image([time_min time_max], [alt_min alt_max], bsc_532*1000000)
colorbar
h = colorbar
ylabel(h, 'Backscattering (Gm^-^1sr^-^1)','Fontsize',10)
ylabel('Altitude (m)','Fontsize',16)
ax = gca;
ax.YDir = 'normal'

%Extinction subplot
subplot(4,1,4);
imagesc([time_min time_max], [alt_min alt_max], ext_532)
h = colorbar
ylabel(h, 'Extinction (km^-^1)','Fontsize',10)
xlabel('Time (UTC)','Fontsize',16)
ylabel('Altitude (m)','Fontsize',16)
ax = gca;
ax.YDir = 'normal'

%Save HSRL Quicklooks
hsrl_file_name = strcat(date_str,'F2_HSRL.png')
saveas(figure(1), hsrl_file_name)
clf

%3/2/2020 Files
%Combine 3/2 RSP Files

h5file = 'ACTIVATE-HSRL2_UC12_20200302_RA.h5'

ncfile = 'RSP1-UC12_20200302_T175327-181702_wcld_v1_1.nc'

lon = ncread(ncfile,'lon')
lat = ncread(ncfile,'lat')
time_utc = ncread(ncfile,'time_utc')
alt_aggr = ncread(ncfile,'alt_aggr')
cloud_ot_863nm = ncread(ncfile,'cloud_ot_863nm')
cloud_reff_pol_863nm = ncread(ncfile,'cloud_reff_pol_863nm')
cloud_reff_nk = ncread(ncfile,'cloud_reff_nk')
cloud_reff_nk_1588nm = cloud_reff_nk(:,1)
cloud_veff_pol_863nm = ncread(ncfile,'cloud_veff_pol_863nm')
wv_column_nk = ncread(ncfile,'wv_column_nk')
wv_column_pol = ncread(ncfile,'wv_column_pol')

%Change -999 values to NaN
lId = cloud_ot_863nm == -999;
cloud_ot_863nm(lId) = NaN
lId = cloud_reff_pol_863nm == -999;
cloud_reff_pol_863nm(lId) = NaN
lId = cloud_veff_pol_863nm == -999;
cloud_veff_pol_863nm(lId) = NaN
lId = cloud_reff_nk_1588nm == -999;
cloud_reff_nk_1588nm(lId) = NaN
lId = wv_column_nk == -999;
wv_column_nk(lId) = NaN
lId = wv_column_pol == -999;
wv_column_pol(lId) = NaN
lId = wv_column_pol == -999;
wv_column_pol(lId) = NaN
wv_column = wv_column_nk - wv_column_pol

%Create Matlab File
date_str = extractAfter(ncfile1,10)
date_str = extractBefore(date_str,9)
filename = strcat('RSP-HSRL_',date_str,'.mat')

%Download HSLR Data from file
gps_alt = h5read(h5file,'/Nav_Data/gps_alt')
gps_lat = h5read(h5file,'/Nav_Data/gps_lat')
gps_lon = h5read(h5file,'/Nav_Data/gps_lon')
gps_time = h5read(h5file,'/Nav_Data/gps_time')
bsc_532 = h5read(h5file,'/DataProducts/532_bsc')
ext_532 = h5read(h5file,'/DataProducts/532_ext')
cloud_top_height = h5read(h5file,'/DataProducts/cloud_top_height')
Altitude = h5read(h5file,'/DataProducts/Altitude')
Temperature = h5read(h5file,'/State/Temperature')
Pressure = h5read(h5file,'/State/Pressure')

%Create Matlab file
date_str_hslr = extractAfter(h5file,20)
date_str_hslr = extractBefore(date_str_hslr,9)

%Add on Flight Information if Necessary
flight = extractAfter(h5file,32)
flight = extractBefore(flight,3)
tf1 = strcmp("L1",flight)
tf2 = strcmp("L2",flight)
tfh5 = strcmp("h5",flight)
if tf1 == 0 & tf2 == 0
    flight = []
end
if tf1 == 1
    flight = "_Flight_1"
end
if tf2 == 1
    flight = "_Flight_2"
end

%Save HSLR Data to file
filename = strcat('RSP-HSRL_',date_str_hslr,flight,'.mat')
save(filename,'gps_alt','gps_lat','gps_lon','gps_time','bsc_532','ext_532','cloud_top_height','Altitude','Temperature','Pressure','alt_aggr','cloud_ot_863nm','cloud_reff_nk','cloud_reff_nk_1588nm','cloud_reff_pol_863nm','cloud_veff_pol_863nm','lat','lon','time_utc','wv_column','wv_column_nk','wv_column_pol')

%Create RSP Quicklooks
%Optical Thickness subplot
date = [date_str(5:6),'/',date_str(7:8),'/',date_str(1:4)]
date = ' 03/02/2020'
rsp = ["RSP Data - "]

rsp_title = strcat(rsp,date)

subplot(4,1,1);
plot(time_utc, cloud_ot_863nm,'linewidth',2)
grid on
ylabel('Optical Thickness','Fontsize',14)
ylim([0 80])
title(rsp_title,'Fontsize',14)
set(gca,'linewidth',1)

%Effective Radius subplot
subplot(4,1,2);
plot(time_utc, cloud_reff_nk_1588nm, 'linewidth',2)
hold on
grid on
plot(time_utc, cloud_reff_pol_863nm,'linewidth',2)
ylabel('R_e_f_f (\mum)','Fontsize',14)
ylim([0 40])
legend({'NK 1588','Polarized'},'FontSize',6,'Location','northeast')
set(gca,'linewidth',1)

%Effective Variance subplot
subplot(4,1,3);
plot(time_utc, cloud_veff_pol_863nm,'linewidth',2)
grid on
ylabel('V_e_f_f','Fontsize',14)
ylim([0 .4])
set(gca,'linewidth',1)

%Water Vapor subplot
subplot(4,1,4);
hold on
grid on
plot(time_utc, wv_column_nk, 'LineWidth',2)
plot(time_utc, wv_column_pol, 'LineWidth',2)
plot(time_utc, wv_column, 'LineWidth', 3)
xlabel('Time (UTC)','Fontsize',14)
ylabel('W.V. (cm atm^-^1)','Fontsize',14)
ylim([-1 4])
legend({'Radiance Water Vapor Retrieval','Polarized Water Vapor Retrieval','Net Water Vapor Retrieval'},'FontSize',6,'Location','northeast')
set(gca,'linewidth',1)

%Save RSP Quicklooks
rsp_file_name = strcat(date_str,'RSP.png')
saveas(figure(1), rsp_file_name)
clf

%Make HSLR Quicklooks
%Get Max and Min values for Images
time_min = min(gps_time)
time_max = max(gps_time)
alt_min = min(gps_alt)
alt_max = max(gps_alt)

%Altitude subplot
date = [date_str_hslr(5:6),'/',date_str_hslr(7:8),'/',date_str_hslr(1:4)]
hsrl = ["HSRL Data - "]
hsrl_title = strcat(hsrl,' - 03/02/2020')
subplot(4,1,1);
plot(gps_time, gps_alt,'linewidth',2)
grid on
xlim([time_min time_max])
ylabel('Altitude (m)','Fontsize',16)
title(hsrl_title,'Fontsize',16)
set(gca,'linewidth',1)

%Cloud Top Height subplot
subplot(4,1,2);
plot(gps_time, cloud_top_height,'linewidth',2)
grid on
xlabel('Time (UTC)','Fontsize',16)
ylabel('C.T.H. (m)','Fontsize',16)
ylim([0 8000])
xlim([time_min time_max])
set(gca,'linewidth',1)

%Backscattering subplot
subplot(4,1,3);
image([time_min time_max], [alt_min alt_max], bsc_532*1000000)
colorbar
h = colorbar
ylabel(h, 'Backscattering (Gm^-^1sr^-^1)','Fontsize',10)
ylabel('Altitude (m)','Fontsize',16)
ax = gca;
ax.YDir = 'normal'

%Extinction subplot
subplot(4,1,4);
imagesc([time_min time_max], [alt_min alt_max], ext_532)
h = colorbar
ylabel(h, 'Extinction (km^-^1)','Fontsize',10)
xlabel('Time (UTC)','Fontsize',16)
ylabel('Altitude (m)','Fontsize',16)
ax = gca;
ax.YDir = 'normal'

%Save HSRL Quicklooks
hsrl_file_name = strcat(date_str,'HSRL.png')
saveas(figure(1), hsrl_file_name)
clf

%3/6/2020 Files
%Combine 3/6 Flight RSP Files
h5file = 'ACTIVATE-HSRL2_UC12_20200306_RA.h5'

ncfile1 = 'RSP1-UC12_20200306_T182326-183617_wcld_v1_1.nc'
ncfile2 = 'RSP1-UC12_20200306_T191747-200619_wcld_v1_1.nc'

lon1 = ncread(ncfile1,'lon')
lat1 = ncread(ncfile1,'lat')
time_utc1 = ncread(ncfile1,'time_utc')
alt_aggr1 = ncread(ncfile1,'alt_aggr')
cloud_ot_863nm1 = ncread(ncfile1,'cloud_ot_863nm')
cloud_reff_pol_863nm1 = ncread(ncfile1,'cloud_reff_pol_863nm')
cloud_reff_nk1 = ncread(ncfile1,'cloud_reff_nk')
cloud_reff_nk_1588nm1 = cloud_reff_nk1(:,1)
cloud_veff_pol_863nm1 = ncread(ncfile1,'cloud_veff_pol_863nm')
wv_column_nk1 = ncread(ncfile1,'wv_column_nk')
wv_column_pol1 = ncread(ncfile1,'wv_column_pol')

lon2 = ncread(ncfile2,'lon')
lat2 = ncread(ncfile2,'lat')
time_utc2 = ncread(ncfile2,'time_utc')
alt_aggr2 = ncread(ncfile2,'alt_aggr')
cloud_ot_863nm2 = ncread(ncfile2,'cloud_ot_863nm')
cloud_reff_pol_863nm2 = ncread(ncfile2,'cloud_reff_pol_863nm')
cloud_reff_nk2 = ncread(ncfile2,'cloud_reff_nk')
cloud_reff_nk_1588nm2 = cloud_reff_nk2(:,1)
cloud_veff_pol_863nm2 = ncread(ncfile2,'cloud_veff_pol_863nm')
wv_column_nk2 = ncread(ncfile2,'wv_column_nk')
wv_column_pol2 = ncread(ncfile2,'wv_column_pol')

lon = vertcat(lon1, lon2)
lat = vertcat(lat1, lat2)
time_utc = vertcat(time_utc1, time_utc2)
alt_aggr = vertcat(alt_aggr1, alt_aggr2)
cloud_ot_863nm = vertcat(cloud_ot_863nm1, cloud_ot_863nm2)
cloud_reff_pol_863nm = vertcat(cloud_reff_pol_863nm1, cloud_reff_pol_863nm2)
cloud_reff_nk = vertcat(cloud_reff_nk1, cloud_reff_nk2)
cloud_veff_pol_863nm = vertcat(cloud_veff_pol_863nm1, cloud_veff_pol_863nm2)
cloud_reff_nk_1588nm = vertcat(cloud_reff_nk_1588nm1, cloud_reff_nk_1588nm2)
wv_column_nk = vertcat(wv_column_nk1, wv_column_nk2)
wv_column_pol = vertcat(wv_column_pol1, wv_column_pol2)

%Change -999 values to NaN
lId = cloud_ot_863nm == -999;
cloud_ot_863nm(lId) = NaN
lId = cloud_reff_pol_863nm == -999;
cloud_reff_pol_863nm(lId) = NaN
lId = cloud_veff_pol_863nm == -999;
cloud_veff_pol_863nm(lId) = NaN
lId = cloud_reff_nk_1588nm == -999;
cloud_reff_nk_1588nm(lId) = NaN
lId = wv_column_nk == -999;
wv_column_nk(lId) = NaN
lId = wv_column_pol == -999;
wv_column_pol(lId) = NaN
lId = wv_column_pol == -999;
wv_column_pol(lId) = NaN
wv_column = wv_column_nk - wv_column_pol

%Create Matlab File
date_str = extractAfter(ncfile1,10)
date_str = extractBefore(date_str,9)
filename = strcat('RSP-HSRL_',date_str,'.mat')

%Download HSLR Data from file
gps_alt = h5read(h5file,'/Nav_Data/gps_alt')
gps_lat = h5read(h5file,'/Nav_Data/gps_lat')
gps_lon = h5read(h5file,'/Nav_Data/gps_lon')
gps_time = h5read(h5file,'/Nav_Data/gps_time')
bsc_532 = h5read(h5file,'/DataProducts/532_bsc')
ext_532 = h5read(h5file,'/DataProducts/532_ext')
cloud_top_height = h5read(h5file,'/DataProducts/cloud_top_height')
Altitude = h5read(h5file,'/DataProducts/Altitude')
Temperature = h5read(h5file,'/State/Temperature')
Pressure = h5read(h5file,'/State/Pressure')

%Create Matlab file
date_str_hslr = extractAfter(h5file,20)
date_str_hslr = extractBefore(date_str_hslr,9)

%Add on Flight Information if Necessary
flight = extractAfter(h5file,32)
flight = extractBefore(flight,3)
tf1 = strcmp("L1",flight)
tf2 = strcmp("L2",flight)
tfh5 = strcmp("h5",flight)
if tf1 == 0 & tf2 == 0
    flight = []
end
if tf1 == 1
    flight = "_Flight_1"
end
if tf2 == 1
    flight = "_Flight_2"
end

%Save HSLR Data to file
filename = strcat('RSP-HSRL_',date_str_hslr,flight,'.mat')
save(filename,'gps_alt','gps_lat','gps_lon','gps_time','bsc_532','ext_532','cloud_top_height','Altitude','Temperature','Pressure','alt_aggr','cloud_ot_863nm','cloud_reff_nk','cloud_reff_nk_1588nm','cloud_reff_pol_863nm','cloud_veff_pol_863nm','lat','lon','time_utc','wv_column','wv_column_nk','wv_column_pol')

%Create RSP Quicklooks
%Optical Thickness subplot
date = [date_str(5:6),'/',date_str(7:8),'/',date_str(1:4)]
rsp = ["RSP Data - "]

rsp_title = strcat(rsp,date)

subplot(4,1,1);
plot(time_utc, cloud_ot_863nm,'linewidth',2)
grid on
ylabel('Optical Thickness','Fontsize',14)
ylim([0 80])
title(rsp_title,'Fontsize',14)
set(gca,'linewidth',1)

%Effective Radius subplot
subplot(4,1,2);
plot(time_utc, cloud_reff_nk_1588nm, 'linewidth',2)
hold on
grid on
plot(time_utc, cloud_reff_pol_863nm,'linewidth',2)
ylabel('R_e_f_f (\mum)','Fontsize',14)
ylim([0 40])
legend({'NK 1588','Polarized'},'FontSize',6,'Location','northeast')
set(gca,'linewidth',1)

%Effective Variance subplot
subplot(4,1,3);
plot(time_utc, cloud_veff_pol_863nm,'linewidth',2)
grid on
ylabel('V_e_f_f','Fontsize',14)
ylim([0 .4])
set(gca,'linewidth',1)

%Water Vapor subplot
subplot(4,1,4);
hold on
grid on
plot(time_utc, wv_column_nk, 'LineWidth',2)
plot(time_utc, wv_column_pol, 'LineWidth',2)
plot(time_utc, wv_column, 'LineWidth', 3)
xlabel('Time (UTC)','Fontsize',14)
ylabel('W.V. (cm atm^-^1)','Fontsize',14)
ylim([-1 4])
legend({'Radiance Water Vapor Retrieval','Polarized Water Vapor Retrieval','Net Water Vapor Retrieval'},'FontSize',6,'Location','northeast')
set(gca,'linewidth',1)

%Save RSP Quicklooks
rsp_file_name = strcat(date_str,'_RSP.png')
saveas(figure(1), rsp_file_name)
clf

%Make HSLR Quicklooks
%Get Max and Min values for Images
time_min = min(gps_time)
time_max = max(gps_time)
alt_min = min(gps_alt)
alt_max = max(gps_alt)

%Altitude subplot
date = [date_str_hslr(5:6),'/',date_str_hslr(7:8),'/',date_str_hslr(1:4)]
hsrl = ["HSRL Data - "]
hsrl_title = strcat(hsrl,date)
subplot(4,1,1);
plot(gps_time, gps_alt,'linewidth',2)
grid on
xlim([time_min time_max])
ylabel('Altitude (m)','Fontsize',16)
title(hsrl_title,'Fontsize',16)
set(gca,'linewidth',1)

%Cloud Top Height subplot
subplot(4,1,2);
plot(gps_time, cloud_top_height,'linewidth',2)
grid on
xlabel('Time (UTC)','Fontsize',16)
ylabel('C.T.H. (m)','Fontsize',16)
ylim([0 8000])
xlim([time_min time_max])
set(gca,'linewidth',1)

%Backscattering subplot
subplot(4,1,3);
image([time_min time_max], [alt_min alt_max], bsc_532*1000000)
colorbar
h = colorbar
ylabel(h, 'Backscattering (Gm^-^1sr^-^1)','Fontsize',10)
ylabel('Altitude (m)','Fontsize',16)
ax = gca;
ax.YDir = 'normal'

%Extinction subplot
subplot(4,1,4);
imagesc([time_min time_max], [alt_min alt_max], ext_532)
h = colorbar
ylabel(h, 'Extinction (km^-^1)','Fontsize',10)
xlabel('Time (UTC)','Fontsize',16)
ylabel('Altitude (m)','Fontsize',16)
ax = gca;
ax.YDir = 'normal'

%Save HSRL Quicklooks
hsrl_file_name = strcat(date_str,'_HSRL.png')
saveas(figure(1), hsrl_file_name)
clf

%3/9/2020 Files
%Combine 3/9 RSP Files

h5file = 'ACTIVATE-HSRL2_UC12_20200309_RA.h5'

ncfile1 = 'RSP1-UC12_20200309_T170651-172646_wcld_v1_1.nc'
ncfile2 = 'RSP1-UC12_20200309_T172731-173105_wcld_v1_1.nc'
ncfile3 = 'RSP1-UC12_20200309_T173148-180910_wcld_v1_1.nc'
ncfile4 = 'RSP1-UC12_20200309_T181440-184312_wcld_v1_1.nc'
ncfile5 = 'RSP1-UC12_20200309_T184358-184715_wcld_v1_1.nc'

lon1 = ncread(ncfile1,'lon')
lat1 = ncread(ncfile1,'lat')
time_utc1 = ncread(ncfile1,'time_utc')
alt_aggr1 = ncread(ncfile1,'alt_aggr')
cloud_ot_863nm1 = ncread(ncfile1,'cloud_ot_863nm')
cloud_reff_pol_863nm1 = ncread(ncfile1,'cloud_reff_pol_863nm')
cloud_reff_nk1 = ncread(ncfile1,'cloud_reff_nk')
cloud_reff_nk_1588nm1 = cloud_reff_nk1(:,1)
cloud_veff_pol_863nm1 = ncread(ncfile1,'cloud_veff_pol_863nm')
wv_column_nk1 = ncread(ncfile1,'wv_column_nk')
wv_column_pol1 = ncread(ncfile1,'wv_column_pol')

lon2 = ncread(ncfile2,'lon')
lat2 = ncread(ncfile2,'lat')
time_utc2 = ncread(ncfile2,'time_utc')
alt_aggr2 = ncread(ncfile2,'alt_aggr')
cloud_ot_863nm2 = ncread(ncfile2,'cloud_ot_863nm')
cloud_reff_pol_863nm2 = ncread(ncfile2,'cloud_reff_pol_863nm')
cloud_reff_nk2 = ncread(ncfile2,'cloud_reff_nk')
cloud_reff_nk_1588nm2 = cloud_reff_nk2(:,1)
cloud_veff_pol_863nm2 = ncread(ncfile2,'cloud_veff_pol_863nm')
wv_column_nk2 = ncread(ncfile2,'wv_column_nk')
wv_column_pol2 = ncread(ncfile2,'wv_column_pol')

lon3 = ncread(ncfile3,'lon')
lat3 = ncread(ncfile3,'lat')
time_utc3 = ncread(ncfile3,'time_utc')
alt_aggr3 = ncread(ncfile3,'alt_aggr')
cloud_ot_863nm3 = ncread(ncfile3,'cloud_ot_863nm')
cloud_reff_pol_863nm3 = ncread(ncfile3,'cloud_reff_pol_863nm')
cloud_reff_nk3 = ncread(ncfile3,'cloud_reff_nk')
cloud_reff_nk_1588nm3 = cloud_reff_nk3(:,1)
cloud_veff_pol_863nm3 = ncread(ncfile3,'cloud_veff_pol_863nm')
wv_column_nk3 = ncread(ncfile3,'wv_column_nk')
wv_column_pol3 = ncread(ncfile3,'wv_column_pol')

lon4 = ncread(ncfile4,'lon')
lat4 = ncread(ncfile4,'lat')
time_utc4 = ncread(ncfile4,'time_utc')
alt_aggr4 = ncread(ncfile4,'alt_aggr')
cloud_ot_863nm4 = ncread(ncfile4,'cloud_ot_863nm')
cloud_reff_pol_863nm4 = ncread(ncfile4,'cloud_reff_pol_863nm')
cloud_reff_nk4 = ncread(ncfile4,'cloud_reff_nk')
cloud_reff_nk_1588nm4 = cloud_reff_nk4(:,1)
cloud_veff_pol_863nm4 = ncread(ncfile4,'cloud_veff_pol_863nm')
wv_column_nk4 = ncread(ncfile4,'wv_column_nk')
wv_column_pol4 = ncread(ncfile4,'wv_column_pol')

lon5 = ncread(ncfile5,'lon')
lat5 = ncread(ncfile5,'lat')
time_utc5 = ncread(ncfile5,'time_utc')
alt_aggr5 = ncread(ncfile5,'alt_aggr')
cloud_ot_863nm5 = ncread(ncfile5,'cloud_ot_863nm')
cloud_reff_pol_863nm5 = ncread(ncfile5,'cloud_reff_pol_863nm')
cloud_reff_nk5 = ncread(ncfile5,'cloud_reff_nk')
cloud_reff_nk_1588nm5 = cloud_reff_nk5(:,1)
cloud_veff_pol_863nm5 = ncread(ncfile5,'cloud_veff_pol_863nm')
wv_column_nk5 = ncread(ncfile5,'wv_column_nk')
wv_column_pol5 = ncread(ncfile5,'wv_column_pol')

lon = vertcat(lon1, lon2, lon3, lon4, lon5)
lat = vertcat(lat1, lat2, lat3, lat4, lat4)
time_utc = vertcat(time_utc1, time_utc2, time_utc3, time_utc4, time_utc5)
alt_aggr = vertcat(alt_aggr1, alt_aggr2, alt_aggr3, alt_aggr4, alt_aggr5)
cloud_ot_863nm = vertcat(cloud_ot_863nm1, cloud_ot_863nm2, cloud_ot_863nm3, cloud_ot_863nm4, cloud_ot_863nm5)
cloud_reff_pol_863nm = vertcat(cloud_reff_pol_863nm1, cloud_reff_pol_863nm2, cloud_reff_pol_863nm3, cloud_reff_pol_863nm4, cloud_reff_pol_863nm5)
cloud_reff_nk = vertcat(cloud_reff_nk1, cloud_reff_nk2, cloud_reff_nk3, cloud_reff_nk4, cloud_reff_nk5)
cloud_reff_nk_1588nm = vertcat(cloud_reff_nk_1588nm1, cloud_reff_nk_1588nm2, cloud_reff_nk_1588nm3, cloud_reff_nk_1588nm4, cloud_reff_nk_1588nm5)
cloud_veff_pol_863nm = vertcat(cloud_veff_pol_863nm1, cloud_veff_pol_863nm2, cloud_veff_pol_863nm3, cloud_veff_pol_863nm4, cloud_veff_pol_863nm5)
wv_column_nk = vertcat(wv_column_nk1, wv_column_nk2, wv_column_nk3, wv_column_nk4, wv_column_nk5)
wv_column_pol = vertcat(wv_column_pol1, wv_column_pol2, wv_column_pol3, wv_column_pol4, wv_column_pol5)

%Change -999 values to NaN
lId = cloud_ot_863nm == -999;
cloud_ot_863nm(lId) = NaN
lId = cloud_reff_pol_863nm == -999;
cloud_reff_pol_863nm(lId) = NaN
lId = cloud_veff_pol_863nm == -999;
cloud_veff_pol_863nm(lId) = NaN
lId = cloud_reff_nk_1588nm == -999;
cloud_reff_nk_1588nm(lId) = NaN
lId = wv_column_nk == -999;
wv_column_nk(lId) = NaN
lId = wv_column_pol == -999;
wv_column_pol(lId) = NaN
lId = wv_column_pol == -999;
wv_column_pol(lId) = NaN
wv_column = wv_column_nk - wv_column_pol

%Create Matlab File
date_str = extractAfter(ncfile1,10)
date_str = extractBefore(date_str,9)
filename = strcat('RSP-HSRL_',date_str,'.mat')

%Download HSLR Data from file
gps_alt = h5read(h5file,'/Nav_Data/gps_alt')
gps_lat = h5read(h5file,'/Nav_Data/gps_lat')
gps_lon = h5read(h5file,'/Nav_Data/gps_lon')
gps_time = h5read(h5file,'/Nav_Data/gps_time')
bsc_532 = h5read(h5file,'/DataProducts/532_bsc')
ext_532 = h5read(h5file,'/DataProducts/532_ext')
cloud_top_height = h5read(h5file,'/DataProducts/cloud_top_height')
Altitude = h5read(h5file,'/DataProducts/Altitude')
Temperature = h5read(h5file,'/State/Temperature')
Pressure = h5read(h5file,'/State/Pressure')

%Create Matlab file
date_str_hslr = extractAfter(h5file,20)
date_str_hslr = extractBefore(date_str_hslr,9)

%Add on Flight Information if Necessary
flight = extractAfter(h5file,32)
flight = extractBefore(flight,3)
tf1 = strcmp("L1",flight)
tf2 = strcmp("L2",flight)
tfh5 = strcmp("h5",flight)
if tf1 == 0 & tf2 == 0
    flight = []
end
if tf1 == 1
    flight = "_Flight_1"
end
if tf2 == 1
    flight = "_Flight_2"
end

%Save HSLR Data to file
filename = strcat('RSP-HSRL_',date_str_hslr,flight,'.mat')
save(filename,'gps_alt','gps_lat','gps_lon','gps_time','bsc_532','ext_532','cloud_top_height','Altitude','Temperature','Pressure','alt_aggr','cloud_ot_863nm','cloud_reff_nk','cloud_reff_nk_1588nm','cloud_reff_pol_863nm','cloud_veff_pol_863nm','lat','lon','time_utc','wv_column','wv_column_nk','wv_column_pol')

%Create RSP Quicklooks
%Optical Thickness subplot
date = [date_str(5:6),'/',date_str(7:8),'/',date_str(1:4)]
date = ' 03/09/2020'
rsp = ["RSP Data - "]

rsp_title = strcat(rsp,date)

subplot(4,1,1);
plot(time_utc, cloud_ot_863nm,'linewidth',2)
grid on
ylabel('Optical Thickness','Fontsize',14)
ylim([0 80])
title(rsp_title,'Fontsize',14)
set(gca,'linewidth',1)

%Effective Radius subplot
subplot(4,1,2);
plot(time_utc, cloud_reff_nk_1588nm, 'linewidth',2)
hold on
grid on
plot(time_utc, cloud_reff_pol_863nm,'linewidth',2)
ylabel('R_e_f_f (\mum)','Fontsize',14)
ylim([0 40])
legend({'NK 1588','Polarized'},'FontSize',6,'Location','northeast')
set(gca,'linewidth',1)

%Effective Variance subplot
subplot(4,1,3);
plot(time_utc, cloud_veff_pol_863nm,'linewidth',2)
grid on
ylabel('V_e_f_f','Fontsize',14)
ylim([0 .4])
set(gca,'linewidth',1)

%Water Vapor subplot
subplot(4,1,4);
hold on
grid on
plot(time_utc, wv_column_nk, 'LineWidth',2)
plot(time_utc, wv_column_pol, 'LineWidth',2)
plot(time_utc, wv_column, 'LineWidth', 3)
xlabel('Time (UTC)','Fontsize',14)
ylabel('W.V. (cm atm^-^1)','Fontsize',14)
ylim([-1 4])
legend({'Radiance Water Vapor Retrieval','Polarized Water Vapor Retrieval','Net Water Vapor Retrieval'},'FontSize',6,'Location','northeast')
set(gca,'linewidth',1)

%Save RSP Quicklooks
rsp_file_name = strcat(date_str,'RSP.png')
saveas(figure(1), rsp_file_name)
clf

%Make HSLR Quicklooks
%Get Max and Min values for Images
time_min = min(gps_time)
time_max = max(gps_time)
alt_min = min(gps_alt)
alt_max = max(gps_alt)

%Altitude subplot
date = [date_str_hslr(5:6),'/',date_str_hslr(7:8),'/',date_str_hslr(1:4)]
hsrl = ["HSRL Data - "]
hsrl_title = strcat(hsrl,'03/09/2020')
subplot(4,1,1);
plot(gps_time, gps_alt,'linewidth',2)
grid on
xlim([time_min time_max])
ylabel('Altitude (m)','Fontsize',16)
title(hsrl_title,'Fontsize',16)
set(gca,'linewidth',1)

%Cloud Top Height subplot
subplot(4,1,2);
plot(gps_time, cloud_top_height,'linewidth',2)
grid on
xlabel('Time (UTC)','Fontsize',16)
ylabel('C.T.H. (m)','Fontsize',16)
ylim([0 8000])
xlim([time_min time_max])
set(gca,'linewidth',1)

%Backscattering subplot
subplot(4,1,3);
image([time_min time_max], [alt_min alt_max], bsc_532*1000000)
colorbar
h = colorbar
ylabel(h, 'Backscattering (Gm^-^1sr^-^1)','Fontsize',10)
ylabel('Altitude (m)','Fontsize',16)
ax = gca;
ax.YDir = 'normal'

%Extinction subplot
subplot(4,1,4);
imagesc([time_min time_max], [alt_min alt_max], ext_532)
h = colorbar
ylabel(h, 'Extinction (km^-^1)','Fontsize',10)
xlabel('Time (UTC)','Fontsize',16)
ylabel('Altitude (m)','Fontsize',16)
ax = gca;
ax.YDir = 'normal'

%Save HSRL Quicklooks
hsrl_file_name = strcat(date_str,'HSRL.png')
saveas(figure(1), hsrl_file_name)
clf

%3/11/2020 Files
%Combine 3/11 Flight RSP Files
h5file = 'ACTIVATE-HSRL2_UC12_20200311_RA.h5'

ncfile1 = 'RSP1-UC12_20200311_T130448-131435_wcld_v1_1.nc'
ncfile2 = 'RSP1-UC12_20200311_T133927-135507_wcld_v1_1.nc'

lon1 = ncread(ncfile1,'lon')
lat1 = ncread(ncfile1,'lat')
time_utc1 = ncread(ncfile1,'time_utc')
alt_aggr1 = ncread(ncfile1,'alt_aggr')
cloud_ot_863nm1 = ncread(ncfile1,'cloud_ot_863nm')
cloud_reff_pol_863nm1 = ncread(ncfile1,'cloud_reff_pol_863nm')
cloud_reff_nk1 = ncread(ncfile1,'cloud_reff_nk')
cloud_reff_nk_1588nm1 = cloud_reff_nk1(:,1)
cloud_veff_pol_863nm1 = ncread(ncfile1,'cloud_veff_pol_863nm')
wv_column_nk1 = ncread(ncfile1,'wv_column_nk')
wv_column_pol1 = ncread(ncfile1,'wv_column_pol')

lon2 = ncread(ncfile2,'lon')
lat2 = ncread(ncfile2,'lat')
time_utc2 = ncread(ncfile2,'time_utc')
alt_aggr2 = ncread(ncfile2,'alt_aggr')
cloud_ot_863nm2 = ncread(ncfile2,'cloud_ot_863nm')
cloud_reff_pol_863nm2 = ncread(ncfile2,'cloud_reff_pol_863nm')
cloud_reff_nk2 = ncread(ncfile2,'cloud_reff_nk')
cloud_reff_nk_1588nm2 = cloud_reff_nk2(:,1)
cloud_veff_pol_863nm2 = ncread(ncfile2,'cloud_veff_pol_863nm')
wv_column_nk2 = ncread(ncfile2,'wv_column_nk')
wv_column_pol2 = ncread(ncfile2,'wv_column_pol')

lon = vertcat(lon1, lon2)
lat = vertcat(lat1, lat2)
time_utc = vertcat(time_utc1, time_utc2)
alt_aggr = vertcat(alt_aggr1, alt_aggr2)
cloud_ot_863nm = vertcat(cloud_ot_863nm1, cloud_ot_863nm2)
cloud_reff_pol_863nm = vertcat(cloud_reff_pol_863nm1, cloud_reff_pol_863nm2)
cloud_reff_nk = vertcat(cloud_reff_nk1, cloud_reff_nk2)
cloud_veff_pol_863nm = vertcat(cloud_veff_pol_863nm1, cloud_veff_pol_863nm2)
cloud_reff_nk_1588nm = vertcat(cloud_reff_nk_1588nm1, cloud_reff_nk_1588nm2)
wv_column_nk = vertcat(wv_column_nk1, wv_column_nk2)
wv_column_pol = vertcat(wv_column_pol1, wv_column_pol2)

%Change -999 values to NaN
lId = cloud_ot_863nm == -999;
cloud_ot_863nm(lId) = NaN
lId = cloud_reff_pol_863nm == -999;
cloud_reff_pol_863nm(lId) = NaN
lId = cloud_veff_pol_863nm == -999;
cloud_veff_pol_863nm(lId) = NaN
lId = cloud_reff_nk_1588nm == -999;
cloud_reff_nk_1588nm(lId) = NaN
lId = wv_column_nk == -999;
wv_column_nk(lId) = NaN
lId = wv_column_pol == -999;
wv_column_pol(lId) = NaN
lId = wv_column_pol == -999;
wv_column_pol(lId) = NaN
wv_column = wv_column_nk - wv_column_pol

%Create Matlab File
date_str = extractAfter(ncfile1,10)
date_str = extractBefore(date_str,9)
filename = strcat('RSP-HSRL_',date_str,'.mat')

%Download HSLR Data from file
gps_alt = h5read(h5file,'/Nav_Data/gps_alt')
gps_lat = h5read(h5file,'/Nav_Data/gps_lat')
gps_lon = h5read(h5file,'/Nav_Data/gps_lon')
gps_time = h5read(h5file,'/Nav_Data/gps_time')
bsc_532 = h5read(h5file,'/DataProducts/532_bsc')
ext_532 = h5read(h5file,'/DataProducts/532_ext')
cloud_top_height = h5read(h5file,'/DataProducts/cloud_top_height')
Altitude = h5read(h5file,'/DataProducts/Altitude')
Temperature = h5read(h5file,'/State/Temperature')
Pressure = h5read(h5file,'/State/Pressure')

%Create Matlab file
date_str_hslr = extractAfter(h5file,20)
date_str_hslr = extractBefore(date_str_hslr,9)

%Add on Flight Information if Necessary
flight = extractAfter(h5file,32)
flight = extractBefore(flight,3)
tf1 = strcmp("L1",flight)
tf2 = strcmp("L2",flight)
tfh5 = strcmp("h5",flight)
if tf1 == 0 & tf2 == 0
    flight = []
end
if tf1 == 1
    flight = "_Flight_1"
end
if tf2 == 1
    flight = "_Flight_2"
end

%Save HSLR Data to file
filename = strcat('RSP-HSRL_',date_str_hslr,flight,'.mat')
save(filename,'gps_alt','gps_lat','gps_lon','gps_time','bsc_532','ext_532','cloud_top_height','Altitude','Temperature','Pressure','alt_aggr','cloud_ot_863nm','cloud_reff_nk','cloud_reff_nk_1588nm','cloud_reff_pol_863nm','cloud_veff_pol_863nm','lat','lon','time_utc','wv_column','wv_column_nk','wv_column_pol')

%Create RSP Quicklooks
%Optical Thickness subplot
date = [date_str(5:6),'/',date_str(7:8),'/',date_str(1:4)]
rsp = ["RSP Data - "]

rsp_title = strcat(rsp,date)

subplot(4,1,1);
plot(time_utc, cloud_ot_863nm,'linewidth',2)
grid on
ylabel('Optical Thickness','Fontsize',14)
ylim([0 80])
title(rsp_title,'Fontsize',14)
set(gca,'linewidth',1)

%Effective Radius subplot
subplot(4,1,2);
plot(time_utc, cloud_reff_nk_1588nm, 'linewidth',2)
hold on
grid on
plot(time_utc, cloud_reff_pol_863nm,'linewidth',2)
ylabel('R_e_f_f (\mum)','Fontsize',14)
ylim([0 40])
legend({'NK 1588','Polarized'},'FontSize',6,'Location','northeast')
set(gca,'linewidth',1)

%Effective Variance subplot
subplot(4,1,3);
plot(time_utc, cloud_veff_pol_863nm,'linewidth',2)
grid on
ylabel('V_e_f_f','Fontsize',14)
ylim([0 .4])
set(gca,'linewidth',1)

%Water Vapor subplot
subplot(4,1,4);
hold on
grid on
plot(time_utc, wv_column_nk, 'LineWidth',2)
plot(time_utc, wv_column_pol, 'LineWidth',2)
plot(time_utc, wv_column, 'LineWidth', 3)
xlabel('Time (UTC)','Fontsize',14)
ylabel('W.V. (cm atm^-^1)','Fontsize',14)
ylim([-1 4])
legend({'Radiance Water Vapor Retrieval','Polarized Water Vapor Retrieval','Net Water Vapor Retrieval'},'FontSize',6,'Location','northeast')
set(gca,'linewidth',1)

%Save RSP Quicklooks
rsp_file_name = strcat(date_str,'_RSP.png')
saveas(figure(1), rsp_file_name)
clf

%Make HSLR Quicklooks
%Get Max and Min values for Images
time_min = min(gps_time)
time_max = max(gps_time)
alt_min = min(gps_alt)
alt_max = max(gps_alt)

%Altitude subplot
date = [date_str_hslr(5:6),'/',date_str_hslr(7:8),'/',date_str_hslr(1:4)]
hsrl = ["HSRL Data - "]
hsrl_title = strcat(hsrl,date)
subplot(4,1,1);
plot(gps_time, gps_alt,'linewidth',2)
grid on
xlim([time_min time_max])
ylabel('Altitude (m)','Fontsize',16)
title(hsrl_title,'Fontsize',16)
set(gca,'linewidth',1)

%Cloud Top Height subplot
subplot(4,1,2);
plot(gps_time, cloud_top_height,'linewidth',2)
grid on
xlabel('Time (UTC)','Fontsize',16)
ylabel('C.T.H. (m)','Fontsize',16)
ylim([0 8000])
xlim([time_min time_max])
set(gca,'linewidth',1)

%Backscattering subplot
subplot(4,1,3);
image([time_min time_max], [alt_min alt_max], bsc_532*1000000)
colorbar
h = colorbar
ylabel(h, 'Backscattering (Gm^-^1sr^-^1)','Fontsize',10)
ylabel('Altitude (m)','Fontsize',16)
ax = gca;
ax.YDir = 'normal'

%Extinction subplot
subplot(4,1,4);
imagesc([time_min time_max], [alt_min alt_max], ext_532)
h = colorbar
ylabel(h, 'Extinction (km^-^1)','Fontsize',10)
xlabel('Time (UTC)','Fontsize',16)
ylabel('Altitude (m)','Fontsize',16)
ax = gca;
ax.YDir = 'normal'

%Save HSRL Quicklooks
hsrl_file_name = strcat(date_str,'_HSRL.png')
saveas(figure(1), hsrl_file_name)
clf