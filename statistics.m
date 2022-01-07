%Compare Mean and Median Values

%Randomish legs
leg1s = 19
leg1e = 20
leg2s = 19
leg2e = 19.5
leg3s = 19.5
leg3e = 20
leg4s = 19.7
leg4e = 19.85
leg5s = 19.7
leg5e = 20
leg6s = 19.2
leg6e = 19.26
leg7s = 19.59
leg7e = 19.68
leg8s = 19.74
leg8e = 19.8
leg9s = 19.85
leg9e = 19.91

iValid = find(time_fcdp >= leg1s & time_fcdp <= leg1e)
Nd_smooth_plot1 = Nd_smooth_plot(iValid)
iValid = find(time_utc >= leg1s & time_utc <= leg1e)
nd_c1 = nd_c(iValid)
modis_nd1 = RSD_ND1(iValid)

iValid = find(time_fcdp >= leg2s & time_fcdp <= leg2e)
Nd_smooth_plot2 = Nd_smooth_plot(iValid)
iValid = find(time_utc >= leg2s & time_utc <= leg2e)
nd_c2 = nd_c(iValid)
modis_nd2 = RSD_ND1(iValid)

iValid = find(time_fcdp >= leg3s & time_fcdp <= leg3e)
Nd_smooth_plot3 = Nd_smooth_plot(iValid)
iValid = find(time_utc >= leg3s & time_utc <= leg3e)
nd_c3 = nd_c(iValid)
modis_nd3 = RSD_ND1(iValid)

iValid = find(time_fcdp >= leg4s & time_fcdp <= leg4e)
Nd_smooth_plot4 = Nd_smooth_plot(iValid)
iValid = find(time_utc >= leg4s & time_utc <= leg4e)
nd_c4 = nd_c(iValid)
modis_nd4 = RSD_ND1(iValid)

iValid = find(time_fcdp >= leg5s & time_fcdp <= leg5e)
Nd_smooth_plot5 = Nd_smooth_plot(iValid)
iValid = find(time_utc >= leg5s & time_utc <= leg5e)
nd_c5 = nd_c(iValid)
modis_nd5 = RSD_ND1(iValid)

iValid = find(time_fcdp >= leg6s & time_fcdp <= leg6e)
Nd_smooth_plot6 = Nd_smooth_plot(iValid)
iValid = find(time_utc >= leg6s & time_utc <= leg6e)
nd_c6 = nd_c(iValid)
modis_nd6 = RSD_ND1(iValid)

iValid = find(time_fcdp >= leg7s & time_fcdp <= leg7e)
Nd_smooth_plot7 = Nd_smooth_plot(iValid)
iValid = find(time_utc >= leg7s & time_utc <= leg7e)
nd_c7 = nd_c(iValid)
modis_nd7 = RSD_ND1(iValid)

iValid = find(time_fcdp >= leg8s & time_fcdp <= leg8e)
Nd_smooth_plot8 = Nd_smooth_plot(iValid)
iValid = find(time_utc >= leg8s & time_utc <= leg8e)
nd_c8 = nd_c(iValid)
modis_nd8 = RSD_ND1(iValid)

iValid = find(time_fcdp >= leg9s & time_fcdp <= leg9e)
Nd_smooth_plot9 = Nd_smooth_plot(iValid)
iValid = find(time_utc >= leg9s & time_utc <= leg9e)
nd_c9 = nd_c(iValid)
modis_nd9 = RSD_ND1(iValid)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

iValid = find(nd_c1 >= 2)
nd_c_n2_1 = nd_c1(iValid)

iValid = find(nd_c2 >= 2)
nd_c_n2_2 = nd_c2(iValid)

iValid = find(nd_c3 >= 2)
nd_c_n2_3 = nd_c3(iValid)

iValid = find(nd_c4 >= 2)
nd_c_n2_4 = nd_c4(iValid)

iValid = find(nd_c5 >= 2)
nd_c_n2_5 = nd_c5(iValid)

iValid = find(nd_c6 >= 2)
nd_c_n2_6 = nd_c6(iValid)

iValid = find(nd_c7 >= 2)
nd_c_n2_7 = nd_c7(iValid)

iValid = find(nd_c8 >= 2)
nd_c_n2_8 = nd_c8(iValid)

iValid = find(nd_c9 >= 2)
nd_c_n2_9 = nd_c9(iValid)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

iValid = find(modis_nd1 >= 2)
modis_nd1 = modis_nd1(iValid)

iValid = find(modis_nd2 >= 2)
modis_nd2 = modis_nd2(iValid)

iValid = find(modis_nd3 >= 2)
modis_nd3 = modis_nd3(iValid)

iValid = find(modis_nd4 >= 2)
modis_nd4 = modis_nd4(iValid)

iValid = find(modis_nd5 >= 2)
modis_nd5 = modis_nd5(iValid)

iValid = find(modis_nd6 >= 2)
modis_nd6 = modis_nd6(iValid)

iValid = find(modis_nd7 >= 2)
modis_nd7 = modis_nd7(iValid)

iValid = find(modis_nd8 >= 2)
modis_nd8 = modis_nd8(iValid)

iValid = find(modis_nd9 >= 2)
modis_nd9 = modis_nd9(iValid)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

iValid = find(time_utc >= leg1s & time_utc <= leg1e & nd_c>=2)
nd_c_n2_1 = nd_c(iValid)
nd_c_n2_1 = nd_c_n2(iValid)

iValid = find(time_utc >= leg2s & time_utc <= leg2e)
nd_c_n2_2 = nd_c_n2(iValid)

iValid = find(time_utc >= leg3s & time_utc <= leg3e)
nd_c_n2_3 = nd_c_n2(iValid)

iValid = find(time_utc >= leg4s & time_utc <= leg4e)
nd_c_n2_4 = nd_c_n2(iValid)

iValid = find(time_utc >= leg5s & time_utc <= leg5e)
nd_c_n2_5 = nd_c_n2(iValid)

iValid = find(time_utc >= leg6s & time_utc <= leg6e)
nd_c_n2_6 = nd_c_n2(iValid)

iValid = find(time_utc >= leg7s & time_utc <= leg7e)
nd_c_n2_7 = nd_c_n2(iValid)

iValid = find(time_utc >= leg8s & time_utc <= leg8e)
nd_c_n2_8 = nd_c_n2(iValid)

iValid = find(time_utc >= leg9s & time_utc <= leg9e)
nd_c_n2_9 = nd_c_n2(iValid)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Falcon Profiles
leg1s = 18.65
leg1e = 18.67
leg2s = 18.82
leg2e = 18.88
leg3s = 18.96
leg3e = 19.02
leg4s = 19.17
leg4e = 19.2
leg5s = 19.31
leg5e = 19.42
leg6s = 19.5
leg6e = 19.61
leg7s = 19.67
leg7e = 19.75
leg8s = 19.93
leg8e = 19.94
leg9s = 20.03
leg9e = 20.12
leg10s = 20.19
leg10e = 20.25
leg11s = 20.34
leg11e = 20.41
leg12s = 20.56
leg12e = 20.57
leg13s = 20.64
leg13e = 20.68


iValid = find(time_fcdp >= leg1s & time_fcdp <= leg1e &)
Nd_smooth_plot1 = Nd_smooth_plot(iValid)

iValid = find(time_fcdp >= leg2s & time_fcdp <= leg2e)
Nd_smooth_plot2 = Nd_smooth_plot(iValid)

iValid = find(time_fcdp >= leg3s & time_fcdp <= leg3e)
Nd_smooth_plot3 = Nd_smooth_plot(iValid)

iValid = find(time_fcdp >= leg4s & time_fcdp <= leg4e)
Nd_smooth_plot4 = Nd_smooth_plot(iValid)

iValid = find(time_fcdp >= leg5s & time_fcdp <= leg5e)
Nd_smooth_plot5 = Nd_smooth_plot(iValid)

iValid = find(time_fcdp >= leg6s & time_fcdp <= leg6e)
Nd_smooth_plot6 = Nd_smooth_plot(iValid)

iValid = find(time_fcdp >= leg7s & time_fcdp <= leg7e)
Nd_smooth_plot7 = Nd_smooth_plot(iValid)

iValid = find(time_fcdp >= leg8s & time_fcdp <= leg8e)
Nd_smooth_plot8 = Nd_smooth_plot(iValid)

iValid = find(time_fcdp >= leg9s & time_fcdp <= leg9e)
Nd_smooth_plot9 = Nd_smooth_plot(iValid)

iValid = find(time_fcdp >= leg10s & time_fcdp <= leg10e)
Nd_smooth_plot10 = Nd_smooth_plot(iValid)

iValid = find(time_fcdp >= leg11s & time_fcdp <= leg11e)
Nd_smooth_plot11 = Nd_smooth_plot(iValid)

iValid = find(time_fcdp >= leg12s & time_fcdp <= leg12e)
Nd_smooth_plot12 = Nd_smooth_plot(iValid)

iValid = find(time_fcdp >= leg13s & time_fcdp <= leg13e)
Nd_smooth_plot13 = Nd_smooth_plot(iValid)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

iValid = find(time_fcdp >= leg1s & time_fcdp <= leg1e & LWC_smooth_plot >= .025)
Nd_smooth_plot_25_1 = Nd_smooth_plot(iValid)

iValid = find(time_fcdp >= leg2s & time_fcdp <= leg2e & LWC_smooth_plot >= .025)
Nd_smooth_plot_25_2 = Nd_smooth_plot(iValid)

iValid = find(time_fcdp >= leg3s & time_fcdp <= leg3e & LWC_smooth_plot >= .025)
Nd_smooth_plot_25_3 = Nd_smooth_plot(iValid)

iValid = find(time_fcdp >= leg4s & time_fcdp <= leg4e & LWC_smooth_plot >= .025)
Nd_smooth_plot_25_4 = Nd_smooth_plot(iValid)

iValid = find(time_fcdp >= leg5s & time_fcdp <= leg5e & LWC_smooth_plot >= .025)
Nd_smooth_plot_25_5 = Nd_smooth_plot(iValid)

iValid = find(time_fcdp >= leg6s & time_fcdp <= leg6e & LWC_smooth_plot >= .025)
Nd_smooth_plot_25_6 = Nd_smooth_plot(iValid)

iValid = find(time_fcdp >= leg7s & time_fcdp <= leg7e & LWC_smooth_plot >= .025)
Nd_smooth_plot_25_7 = Nd_smooth_plot(iValid)

iValid = find(time_fcdp >= leg8s & time_fcdp <= leg8e & LWC_smooth_plot >= .025)
Nd_smooth_plot_25_8 = Nd_smooth_plot(iValid)

iValid = find(time_fcdp >= leg9s & time_fcdp <= leg9e & LWC_smooth_plot >= .025)
Nd_smooth_plot_25_9 = Nd_smooth_plot(iValid)

iValid = find(time_fcdp >= leg10s & time_fcdp <= leg10e & LWC_smooth_plot >= .025)
Nd_smooth_plot_25_10 = Nd_smooth_plot(iValid)

iValid = find(time_fcdp >= leg11s & time_fcdp <= leg11e & LWC_smooth_plot >= .025)
Nd_smooth_plot_25_11 = Nd_smooth_plot(iValid)

iValid = find(time_fcdp >= leg12s & time_fcdp <= leg12e & LWC_smooth_plot >= .025)
Nd_smooth_plot_25_12 = Nd_smooth_plot(iValid)

iValid = find(time_fcdp >= leg13s & time_fcdp <= leg13e & LWC_smooth_plot >= .025)
Nd_smooth_plot_25_13 = Nd_smooth_plot(iValid)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

iValid = find(time_fcdp >= 0 & time_fcdp <= 24 & LWC_smooth_plot >= .025 & Nd_smooth_plot >= 2)
Nd_smooth_plot_25_n2_all = Nd_smooth_plot(iValid)
nanmean(Nd_smooth_plot_25_n2_all)

iValid = find(time_fcdp >= 0 & time_fcdp <= 24 & LWC_smooth_plot >= .01 & Nd_smooth_plot >= 2)
Nd_smooth_plot_01_n2_all = Nd_smooth_plot(iValid)
nanmean(Nd_smooth_plot_01_n2_all)



iValid = find(time_fcdp >= leg1s & time_fcdp <= leg1e & LWC_smooth_plot >= .025 & Nd_smooth_plot >= 2)
Nd_smooth_plot_25_n2_1 = Nd_smooth_plot(iValid)

iValid = find(time_fcdp >= leg2s & time_fcdp <= leg2e & LWC_smooth_plot >= .025 & Nd_smooth_plot >= 2)
Nd_smooth_plot_25_n2_2 = Nd_smooth_plot(iValid)

iValid = find(time_fcdp >= leg3s & time_fcdp <= leg3e & LWC_smooth_plot >= .025 & Nd_smooth_plot >= 2)
Nd_smooth_plot_25_n2_3 = Nd_smooth_plot(iValid)

iValid = find(time_fcdp >= leg4s & time_fcdp <= leg4e & LWC_smooth_plot >= .025 & Nd_smooth_plot >= 2)
Nd_smooth_plot_25_n2_4 = Nd_smooth_plot(iValid)

iValid = find(time_fcdp >= leg5s & time_fcdp <= leg5e & LWC_smooth_plot >= .025 & Nd_smooth_plot >= 2)
Nd_smooth_plot_25_n2_5 = Nd_smooth_plot(iValid)

iValid = find(time_fcdp >= leg6s & time_fcdp <= leg6e & LWC_smooth_plot >= .025 & Nd_smooth_plot >= 2)
Nd_smooth_plot_25_n2_6 = Nd_smooth_plot(iValid)

iValid = find(time_fcdp >= leg7s & time_fcdp <= leg7e & LWC_smooth_plot >= .025 & Nd_smooth_plot >= 2)
Nd_smooth_plot_25_n2_7 = Nd_smooth_plot(iValid)

iValid = find(time_fcdp >= leg8s & time_fcdp <= leg8e & LWC_smooth_plot >= .025 & Nd_smooth_plot >= 2)
Nd_smooth_plot_25_n2_8 = Nd_smooth_plot(iValid)

iValid = find(time_fcdp >= leg9s & time_fcdp <= leg9e & LWC_smooth_plot >= .025 & Nd_smooth_plot >= 2)
Nd_smooth_plot_25_n2_9 = Nd_smooth_plot(iValid)

iValid = find(time_fcdp >= leg10s & time_fcdp <= leg10e & LWC_smooth_plot >= .025 & Nd_smooth_plot >= 2)
Nd_smooth_plot_25_n2_10 = Nd_smooth_plot(iValid)

iValid = find(time_fcdp >= leg11s & time_fcdp <= leg11e & LWC_smooth_plot >= .025 & Nd_smooth_plot >= 2)
Nd_smooth_plot_25_n2_11 = Nd_smooth_plot(iValid)

iValid = find(time_fcdp >= leg12s & time_fcdp <= leg12e & LWC_smooth_plot >= .025 & Nd_smooth_plot >= 2)
Nd_smooth_plot_25_n2_12 = Nd_smooth_plot(iValid)

iValid = find(time_fcdp >= leg13s & time_fcdp <= leg13e & LWC_smooth_plot >= .025 & Nd_smooth_plot >= 2)
Nd_smooth_plot_25_n2_13 = Nd_smooth_plot(iValid)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

iValid = find(time_utc >= leg1s & time_utc <= leg1e & Nd_smooth_plot >= 2)

Nd_smooth_plot_25_n2_1 = Nd_smooth_plot(iValid)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

iValid = find(time_utc >= 19.3 & time_utc <= 19.5)
nd_c1 = nd_c(iValid)
modis_1 = RSD_ND1(iValid)
corrcoef(nd_c1,modis_1,'rows','complete')




