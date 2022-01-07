%Input RSP file names
ncfile = 'filename'

%Get date from file name
date_str = extractAfter(ncfile,10)
date_str = extractBefore(date_str,9)
%date = [date_str(5:6),'/',date_str(7:8),'/',date_str(1:4)]
%rsp = ["RSP Data - "]
%rsp_title = strcat(rsp,date)

%Create Matlab File
filename = strcat('RSP-HSRL_',date_str,'.mat')

%Download RSP Data from file
%ncinfo(ncfile)
%ncdisp(ncfile)
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

%Get filename for RSP files
%rsp_file_name = strcat(date_str,'_RSP.png')

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

%Save Files to Matlab Files
save(filename,'alt_aggr','cloud_ot_863nm','cloud_reff_nk','cloud_reff_nk_1588nm','cloud_reff_pol_863nm','cloud_veff_pol_863nm','lat','lon','time_utc','wv_column','wv_column_nk','wv_column_pol')

%Optical Thickness subplot
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
xlabel('Time (UTC)','Fontsize',20)
ylabel('W.V. (cm atm^-^1)','Fontsize',14)
ylim([-1 4])
legend({'Radiance Water Vapor Retrieval','Polarized Water Vapor Retrieval','Net Water Vapor Retrieval'},'FontSize',6,'Location','northeast')
set(gca,'linewidth',1)

saveas(figure(1), rsp_file_name)