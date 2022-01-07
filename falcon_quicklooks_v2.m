%Falcon Quicklooks

%Quicklooks
subplot(4,1,1)
plot(time_iwg, GPS_Altitude,'Linewidth',2)
ax = gca
ax.FontSize = 18
grid on
ylabel('Altitude (m)','Fontsize',24)
title('2/27/2020 Falcon Data Quicklooks','Fontsize',30)%xlim([18.5 20.75])
xlim([18.5 20.75])
%xlim([19.5 20])
%xlim([19.1 20])
%xlim([19.1 19.45])
%xlim([19.45 20])

%Plot 2
subplot(4,1,2)
%legend('Original N_d Data','Smoothed N_d Data')
scatter(time_fcdp, Nd_smooth_plot)
ax = gca
ax.FontSize = 18
set(gca, 'YScale', 'log')
grid on
ylabel('N_d (cm^-^3)','Fontsize',24)
xlim([18.5 20.75])
%xlim([19.5 20])
%xlim([19.1 20])
%xlim([19.1 19.45])
%xlim([19.45 20])

%Text for profiles
txt1 = 'P1'
txt2 = 'P2'
txt3 = 'P3'
txt4 = 'P4'
txt5 = 'P5'
txt6 = 'P6'
txt7 = 'P7'
txt8 = 'P8'
txt9 = 'P9'
txt10 = 'P10'
txt11 = 'P11'
txt12 = 'P12'
txt13 = 'P13'

text(18.55,200,txt1,'Fontsize',14)
text(18.73,1230,txt2,'Fontsize',14)
text(19,1050,txt3,'Fontsize',14)
text(19.2,1000,txt4,'Fontsize',14)
text(19.35,1000,txt5,'Fontsize',14)
text(19.5,1000,txt6,'Fontsize',14)
text(19.67,1000,txt7,'Fontsize',14)
text(19.89,1000,txt8,'Fontsize',14)
%text(20.03,1000,txt9,'Fontsize',14)
text(20.2,1000,txt10,'Fontsize',14)
text(20.4,750,txt11,'Fontsize',14)
text(20.5,450,txt12,'Fontsize',14)
text(20.65,1000,txt13,'Fontsize',14)

%Plot 3
subplot(4,1,3)
%plot(time_fcdp,LWC_plot,'-o',time_fcdp,LWC_smooth_plot,'-x')
%legend('Original LWC Data','Smoothed LWC Data')
scatter(time_fcdp, LWC_smooth_plot)
ax = gca
ax.FontSize = 18
grid on
ylabel('LWC (g/m^3)','Fontsize',24)
xlim([18.5 20.75])
%xlim([19.5 20])
%xlim([19.1 20])
%xlim([19.1 19.45])
%xlim([19.45 20])

%Plot 4
subplot(4,1,4)
scatter(time_nd2, reff_nd2)
ax = gca
ax.FontSize = 18
grid on
xlabel('UTC Time (hours)','Fontsize',24)
ylabel('R_e_f_f (\mum)','Fontsize',24)
xlim([18.5 20.75])
%xlim([19.5 20])
%xlim([19.1 20])
%xlim([19.1 19.45])
%xlim([19.45 20])

%saveas(figure(1),'falcon_preliminary_quicklooks.png')
%saveas(figure(1),'falcon_preliminary_quicklooks_labeled.png')
saveas(figure(1),'falcon_quicklooks.png')
%saveas(figure(1),'falcon_quicklooks_195_20.png')
%saveas(figure(1),'falcon_quicklooks_191_20.png')
%saveas(figure(1),'falcon_quicklooks_191_1945.png')
%saveas(figure(1),'falcon_quicklooks_1945_20.png')
