%2260 Timeseries

%Individual Flight Legs

h5file = 'RSP-HSRL_20200227.mat'
jdata = '20200227_F1_cloud_gzip.h5'
hsrl = 'ACTIVATE-HSRL2_UC12_20200227_RA.h5'

ncfile1 = 'RSP1-UC12_20200227_T185428-192748_wcld_v1_1.nc'
ncfile2 = 'RSP1-UC12_20200227_T193112-195824_wcld_v1_1.nc'
ncfile3 = 'RSP1-UC12_20200227_T202647-205054_wcld_v1_1.nc'

%Page 1
%Data
gps_time = h5read(hsrl,'/Nav_Data/gps_time')
cloud_top_height = h5read(hsrl,'/DataProducts/cloud_top_height')
Altitude = h5read(hsrl,'/DataProducts/Altitude')
Temperature = h5read(hsrl,'/State/Temperature')
ext = ncread(jdata,'cloud_ext_weighted')
jgps_time = ncread(jdata,'gps_time')
cloud_reff_nk1 = ncread(ncfile1,'cloud_reff_nk')
cloud_reff_nk2 = ncread(ncfile2,'cloud_reff_nk')
cloud_reff_nk3 = ncread(ncfile3,'cloud_reff_nk')
cloud_reff_2260_1 = cloud_reff_nk1(:,2)
cloud_reff_2260_2 = cloud_reff_nk2(:,2)
cloud_reff_2260_3 = cloud_reff_nk3(:,2)
cloud_reff_2260 = vertcat(cloud_reff_2260_1,cloud_reff_2260_2,cloud_reff_2260_3)

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
lId = cloud_reff_2260 == -999;
cloud_reff_2260(lId) = NaN
lId = cloud_ot_2260 == -999;
cloud_ot_2260(lId) = NaN
lId = cloud_reff_2260 <= 5
cloud_reff_2260(lId) = NaN

%Optical Thickness subplot
lId = cloud_ot_863nm >= 64;
cloud_ot_863nm(lId) = 64
subplot(6,1,1);
plot(time_utc, cloud_ot_863nm,'linewidth',2)
grid on
ylabel('Optical Thickness','Fontsize',14)
ylim([0 70])
%xlim([19.1 19.5])
%xlim([19.5 20])
xlim([19.59 19.68])
%xlim([19.74 19.8])
%xlim([19.85 19.91])
title(page1_title,'Fontsize',14)

%Effective Radius subplot
subplot(6,1,2);
%plot(time_utc, cloud_reff_nk_1588nm, 'linewidth',2)
hold on
grid on
plot(time_utc, cloud_reff_pol_863nm,'linewidth',2)
plot(time_utc, cloud_reff_2260,'linewidth',2)
ylabel('R_e_f_f (\mum)','Fontsize',14)
ylim([0 40])
%xlim([19.1 19.5])
%xlim([19.5 20])
xlim([19.59 19.68])
%xlim([19.74 19.8])
%xlim([19.85 19.91])
legend({'Polarized 863nm','NK 2260nm'},'Fontsize',10,'Location','northeast')

%Effective Variance subplot
subplot(6,1,3);
plot(time_utc, cloud_veff_pol_863nm,'linewidth',2)
grid on
ylabel('V_e_f_f','Fontsize',14)
ylim([0 .4])
%xlim([19.1 19.5])
%xlim([19.5 20])
xlim([19.59 19.68])
%xlim([19.74 19.8])
%xlim([19.85 19.91])

%Water Vapor subplot
subplot(6,1,4);
hold on
grid on
plot(time_utc, wv_column_nk, 'LineWidth',2)
plot(time_utc, wv_column_pol, 'LineWidth',2)
plot(time_utc, wv_column, 'LineWidth', 3)
ylabel('W.V. (cm atm^-^1)','Fontsize',14)
ylim([-1 4])
%xlim([19.1 19.5])
%xlim([19.5 20])
xlim([19.59 19.68])
%xlim([19.74 19.8])
%xlim([19.85 19.91])
legend({'Radiance Water Vapor Retrieval','Polarized Water Vapor Retrieval','Net Water Vapor Retrieval'},'FontSize',6,'Location','northeast')
%set(gca,'linewidth',1)

%Cloud Top Height Subplot
cloud_height_j = h5read(jdata,'/cloud_height')
jgps_time = ncread(jdata,'gps_time')
subplot(6,1,5)
grid on
hold on
plot(time_utc, alt_aggr, 'linewidth',2)
plot(gps_time, cloud_top_height,'linewidth',5)
plot(jgps_time, cloud_height_j,'linewidth',2)
ylabel('C.T.H. (m)','Fontsize',16)
legend({'RSP','HSRL','Johns Data'},'FontSize',6,'Location','northeast')
ylim([0 8000])
%xlim([19.1 19.5])
%xlim([19.5 20])
xlim([19.59 19.68])
%xlim([19.74 19.8])
%xlim([19.85 19.91])

%Cloud Top Temperature
cth = cloud_top_height
temp = Temperature
alt = Altitude
N = size(cloud_top_height)
N = N(2)

for i=1:N
    m = cloud_top_height(i)
    [val1,idx1] = min(abs(alt-m))
    minVal = alt(idx1)
    %idx1 gives index of height
    %minVal gives height
    
    %need time index (gps)
    idx2 = i
    
    ctt_i = Temperature(idx1,idx2)
    ctt(i) = ctt_i
end

subplot(6,1,6)
lId = ctt > 283;
ctt(lId) = NaN
lId = ctt < 203
ctt(lId) = NaN

plot(gps_time, ctt,'Linewidth',2)
grid on
xlabel('Time (UTC)','Fontsize',14)
ylabel('C.T.T. (K)','Fontsize',14)
%xlim([19.1 19.5])
%xlim([19.5 20])
xlim([19.59 19.68])
%xlim([19.74 19.8])
%xlim([19.85 19.91])

%saveas(figure(1),'20200227_ot_195_200_pg1.png')
%saveas(figure(1),'20200227_ot_191_195_pg1.png')
saveas(figure(1),'20200227_1959_1968_pg1.png')
saveas(figure(1),'20200227_1974_1980_pg1.png')
saveas(figure(1),'20200227_1985_1991_pg1.png')

clf

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Page 2

%Extinction subplot
subplot(5,1,1);
ext = ncread(jdata,'cloud_ext_weighted')
jgps_time = ncread(jdata,'gps_time')
grid on
ylabel('Extinction (km^-^1)','Fontsize',14)
title('2/27/2020 Page 2','Fontsize',20)
hold on
ext_smooth = movmean(ext,5)
%xlim([19.1 19.5])
%xlim([19.5 20])
xlim([19.59 19.68])
%xlim([19.74 19.8])
%xlim([19.85 19.91])

%Extinction Cross-Section subplot
ncfile = 'xsection_table.nc'

v = ncread(ncfile,'veff')
r = ncread(ncfile,'reff')
N = size(cloud_reff_pol_863nm)
N = N(1)
kext_ret = ncread(ncfile,'kext_ret')
kext_ret4 = kext_ret(:,:,4)

for i=1:N
    %m is index for reff
    m = cloud_reff_pol_863nm(i)
    [val1,idx1] = min(abs(r-m))
    minVal = r(idx1)
    
    %n is index for veff
    n = cloud_veff_pol_863nm(i)
    [val2,idx2] = min(abs(v-n))
    minVal = v(idx2)

    ext_cs_i = kext_ret4(idx1,idx2)
    ext_cs(i) = ext_cs_i
end

lId = ext_cs == 2.848020751953125e+03;
ext_cs(lId) = NaN

subplot(5,1,2);
plot(time_utc, ext_cs)
grid on
ylabel('Ext. XS (\mum^2)','Fontsize',14)
%xlim([19.1 19.5])
%xlim([19.5 20])
xlim([19.59 19.68])
%xlim([19.74 19.8])
%xlim([19.85 19.91])

%Droplet Concentration subplot
%Grosvenor Eq 11
RE1 = cloud_reff_pol_863nm*1e-6
RE2 = cloud_reff_nk_1588nm*1e-6
RE3 = cloud_reff_2260*1e-6
rho = 1000000
RSP_LWP1 = cloud_ot_863nm.*RE1*(5./9.)*rho
pi = 3.14159
cw = .000003
fad = 0.6
RSD_ND1 = (sqrt(5)/(2*pi*0.8))*sqrt((fad*cw.*cloud_ot_863nm)./(2.*1000.*RE1.^5))*1e-6
RSD_ND2 = (sqrt(5)/(2*pi*0.8))*sqrt((fad*cw.*cloud_ot_863nm)./(2.*1000.*RE2.^5))*1e-6
RSD_ND3 = (sqrt(5)/(2*pi*0.8))*sqrt((fad*cw.*cloud_ot_863nm)./(2.*1000.*RE3.^5))*1e-6

subplot(5,1,3)
scatter(time_utc, RSD_ND3)
hold on
%plot(time_utc, RSD_ND2)
%plot(time_utc, RSD_ND1)
scatter(time_utc, RSD_ND1)
grid on
ylabel('N_d (cm^-^3)','Fontsize',14)
legend({'MODIS w/ NK Reff 2260nm','MODIS w/ Pol Reff 863nm'},'FontSize',8,'Location','northeast')
%title('2/27/2020 Droplet Concentration','Fontsize',20)
%xlim([19.1 19.5])
%xlim([19.5 20])
xlim([19.59 19.68])
%xlim([19.74 19.8])
%xlim([19.85 19.91])

%Colocate ext and ext_cs variables 

N = size(ext_cs)
N = N(2)
ext_col = zeros(N,1)
time_dif = zeros(N,1)

%for i=1:N
%    [val1,idx1] = min(abs(jgps_time-time_utc(i)))
%    minVal = jgps_time(idx1)        
%    ext_col(i) = ext_smooth(idx1)
%end   

subplot(5,1,4)
nd_c = ext_col./ext_cs
nd_c = nd_c.*1000
scatter(time_utc, nd_c,'*')
grid on
ylabel('N_d (cm^-^3)','Fontsize',14)
legend({'RSP-HSRL Method'},'FontSize',8,'Location','northeast')
%xlim([19.1 19.5])
%xlim([19.5 20])
xlim([19.59 19.68])
%xlim([19.74 19.8])
%xlim([19.85 19.91])

subplot(5,1,5)
scatter(time_utc, nd_c,'*','Linewidth',2)
hold on
ax = gca
ax.FontSize = 18
scatter(time_utc, RSD_ND1,'Linewidth',2)
grid on
ylabel('N_d (cm^-^3)','Fontsize',24)
legend({'Combined RSP-HSRL Method','Radiometric "MODIS" Method w/ Pol Reff 863nm'},'FontSize',18,'Location','northeast')
%xlim([19.1 19.5])
%xlim([19.5 20])
xlabel('Time (UTC)','Fontsize',24)
title('Droplet Concentration Comparison 2/27/2020','Fontsize',30)
set(gca, 'YScale', 'log')
xlim([19.59 19.68])
%xlim([19.74 19.8])
%xlim([19.85 19.91])

%saveas(figure(1), '20200227_smooth_191_195_pg2.png')
%saveas(figure(1), '20200227_smooth_195_200_pg2.png')
saveas(figure(1),'20200227_1959_1968_pg2.png')
%saveas(figure(1),'20200227_1974_1980_pg2.png')
%saveas(figure(1),'20200227_1985_1991_pg2.png')



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Scatter
iValid = find(time_utc >= 19.5 & time_utc <= 20)
x = RSD_ND1(iValid)
y = nd_c(iValid)
corrcoef(x,y,'rows','complete')

scatter(x, y,'Linewidth',2)
grid on
ylabel('HSRL-RSP Combined N_d (cm^-^3)','Fontsize',24)
xlabel('MODIS (using NK Reff 2260nm data) N_d (cm^-^3)','Fontsize',24)
title('Droplet Retrieval 19.5-20.0 (UTC), 02/27/2020','Fontsize',30)
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')
yt = logspace(0,4,5)
set(gca, 'XTick', yt, 'XTick', yt, 'XLim', [1 10000], 'YLim', [1 10000])
hold on
line = [0:10000]
plot(line,line,'--','Linewidth',3,'color',[.7 .7 .7])
legend({'data','1:1 Line','Best Fit'},'FontSize',18,'Location','northwest')

p = polyfit(log(x), log(y),1)
y_hat = exp(p(1) * log(x) + p(2))
loglog(x, y_hat, 'Linewidth', 3)


saveas(figure(1),'20200227_scatterplot_Nd_log_195_200_2260.png')

