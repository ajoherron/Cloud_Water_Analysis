%Compare Falcon and Combined data

%First looking at Combined stretches

scatter(time_utc, nd_c,30,'*','Linewidth',2)
hold on
scatter(time_fcdp, Nd_smooth_plot,20,'Linewidth',2)
grid on
ylabel('N_d (cm^-^3)','Fontsize',24)
legend({'Combined RSP-HSRL Method','Falcon Cloud Droplet Probe'},'FontSize',18,'Location','southeast')
set(gca, 'YScale', 'log')
xlabel('Time (UTC)','Fontsize',24)
title('FCDP vs. Combined Method Retrievals 2/27/2020','Fontsize',30)
set(gca, 'YScale', 'log')
ylim([1 1000])
yt = logspace(0,3,4)
set(gca,'YTick',yt)
ax = gca
ax.FontSize = 18
xlim([19.65 19.8])
txt7 = 'Falcon Profile 7'
text(19.694,600,txt7,'Fontsize',18)

iValid = find(time_utc >= 19.69 & time_utc <= 19.8)
dist_time1 = dist_time(iValid)
mean(dist_time1)
nd_c1 = nd_c(iValid)
nanmean(nd_c1)
nanstd(nd_c1)
mod1 = RSD_ND1(iValid)
nanmean(mod1)
nanstd(mod1)


iValid = find(time_fcdp >= 19.69 & time_fcdp <= 19.8)
speed = V2.True_Air_Speed(iValid)
mean(speed)
Nfal = Nd_smooth_plot(iValid)
nanmean(Nfal)
nanstd(Nfal)

saveas(figure(1),'20200227_fcdp_comb_1969_1980.png')
