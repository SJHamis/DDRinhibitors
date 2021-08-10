close all
clear all

% simulated data
% import ful data files (multiple runs)
v0 = importdata('SensitivityAnalysisData/invitro_mu24000_sigma500_DSprob75_DStime3_EC100_gamma200_Tdeath100_Dose0');
v0p3 =  importdata('SensitivityAnalysisData/invitro_mu24000_sigma500_DSprob75_DStime3_EC100_gamma200_Tdeath100_Dose30');
v1 =  importdata('SensitivityAnalysisData/invitro_mu24000_sigma500_DSprob75_DStime3_EC100_gamma200_Tdeath100_Dose100');
v3 =  importdata('SensitivityAnalysisData/invitro_mu24000_sigma500_DSprob75_DStime3_EC100_gamma200_Tdeath100_Dose300');
v10 =  importdata('SensitivityAnalysisData/invitro_mu24000_sigma500_DSprob75_DStime3_EC100_gamma200_Tdeath100_Dose1000');
v30 =  importdata('SensitivityAnalysisData/invitro_mu24000_sigma500_DSprob75_DStime3_EC100_gamma200_Tdeath100_Dose3000');
no_runs=100;

%take the no_runs first simuation runs
v0=v0(1:73*no_runs,:);
v0p3=v0p3(1:73*no_runs,:);
v1=v1(1:73*no_runs,:);
v3=v3(1:73*no_runs,:);
v10=v10(1:73*no_runs,:);
v30=v30(1:73*no_runs,:);


%stdev for col 6 (cellcount)
w0_6=getMatrixStdDev(v0,no_runs,6);
w0p3_6=getMatrixStdDev(v0p3,no_runs,6);
w1_6=getMatrixStdDev(v1,no_runs,6);
w3_6=getMatrixStdDev(v3,no_runs,6);
w10_6=getMatrixStdDev(v10,no_runs,6);
w30_6=getMatrixStdDev(v30,no_runs,6);

%stdev for col 7 (g1 cellcount)
w0_g1=getMatrixStdDev(v0,no_runs,7);
w0p3_g1=getMatrixStdDev(v0p3,no_runs,7);
w1_g1=getMatrixStdDev(v1,no_runs,7);
w3_g1=getMatrixStdDev(v3,no_runs,7);
w10_g1=getMatrixStdDev(v10,no_runs,7);
w30_g1=getMatrixStdDev(v30,no_runs,7);

%stdev for col 8 (s cellcount)
w0_s=getMatrixStdDev(v0,no_runs,8);
w0p3_s=getMatrixStdDev(v0p3,no_runs,8);
w1_s=getMatrixStdDev(v1,no_runs,8);
w3_s=getMatrixStdDev(v3,no_runs,8);
w10_s=getMatrixStdDev(v10,no_runs,8);
w30_s=getMatrixStdDev(v30,no_runs,8);

%stdev for col 9 (s2 cellcount)
w0_ds=getMatrixStdDev(v0,no_runs,9);
w0p3_ds=getMatrixStdDev(v0p3,no_runs,9);
w1_ds=getMatrixStdDev(v1,no_runs,9);
w3_ds=getMatrixStdDev(v3,no_runs,9);
w10_ds=getMatrixStdDev(v10,no_runs,9);
w30_ds=getMatrixStdDev(v30,no_runs,9);

%stdev for col 10 (g2/m cellcount)
w0_g2m=getMatrixStdDev(v0,no_runs,10);
w0p3_g2m=getMatrixStdDev(v0p3,no_runs,10);
w1_g2m=getMatrixStdDev(v1,no_runs,10);
w3_g2m=getMatrixStdDev(v3,no_runs,10);
w10_g2m=getMatrixStdDev(v10,no_runs,10);
w30_g2m=getMatrixStdDev(v30,no_runs,6);

%averages
v0=getMatrixAverage(v0, no_runs);
v0p3=getMatrixAverage(v0p3, no_runs);
v1=getMatrixAverage(v1, no_runs);
v3=getMatrixAverage(v3, no_runs);
v10=getMatrixAverage(v10, no_runs);
v30=getMatrixAverage(v30, no_runs);

t=1:length(v0);

figure
%%%%

subplot(3,2,1)
%Simulation means
set(gca, 'ColorOrder', [0 0 0; 0.2 0.7 0.4; 0.9 .9 0.4; 0.7 0 0; 0.5 0 0.9],...
    'NextPlot', 'replacechildren');   
hold on
plot(t,v0(:,6),t,v0(:,7),t,v0(:,8),t,v0(:,9),t,v0(:,10),'LineWidth',2);
hold on
%f=get(gca,'Children'); 
h=fill([t';flipud(t')],[v0(:,6)-w0_6';flipud(v0(:,6)+w0_6')],[0 0 0],'linestyle','none');
set(h,'facealpha',.3)
h=fill([t';flipud(t')],[v0(:,7)-w0_g1';flipud(v0(:,7)+w0_g1')],[0.2 0.7 0.4],'linestyle','none');
set(h,'facealpha',.3)
h=fill([t';flipud(t')],[v0(:,8)-w0_s';flipud(v0(:,8)+w0_s')],[0.9 .9 0.4],'linestyle','none');
set(h,'facealpha',.3)
h=fill([t';flipud(t')],[v0(:,9)-w0_ds';flipud(v0(:,9)+w0_ds')],[0.7 0 0],'linestyle','none');
set(h,'facealpha',.3)
h=fill([t';flipud(t')],[v0(:,10)-w0_g2m';flipud(v0(:,10)+w0_g2m')],[0.5 0 0.9],'linestyle','none');
set(h,'facealpha',.3)

%Plot settings
ylim([0 6500]);
xlim([0 72]);
%set(gca,'YTick',[0, 35, 70]);
set(gca,'XTick',[0, 24, 48, 72]);
set(gca,'FontSize',12);
%legend([],'Total','G_1','S','D-S','G_2/M','Location','northeastoutside','FontSize',12);
title({'Monolayer simulation. Dose: 0 \muM.'},'FontSize', 16);
ylabel('Cell count','FontSize', 16);
xlabel('Time (hours)','FontSize', 16);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


subplot(3,2,2)
%Simulation means
set(gca, 'ColorOrder', [0 0 0; 0.2 0.7 0.4; 0.9 .9 0.4; 0.7 0 0; 0.5 0 0.9],...
    'NextPlot', 'replacechildren');   
hold on
plot(t,v0p3(:,6),t,v0p3(:,7),t,v0p3(:,8),t,v0p3(:,9),t,v0p3(:,10),'LineWidth',2);
hold on
%f=get(gca,'Children'); 
h=fill([t';flipud(t')],[v0p3(:,6)-w0_6';flipud(v0p3(:,6)+w0_6')],[0 0 0],'linestyle','none');
set(h,'facealpha',.3)
h=fill([t';flipud(t')],[v0p3(:,7)-w0_g1';flipud(v0p3(:,7)+w0_g1')],[0.2 0.7 0.4],'linestyle','none');
set(h,'facealpha',.3)
h=fill([t';flipud(t')],[v0p3(:,8)-w0_s';flipud(v0p3(:,8)+w0_s')],[0.9 .9 0.4],'linestyle','none');
set(h,'facealpha',.3)
h=fill([t';flipud(t')],[v0p3(:,9)-w0_ds';flipud(v0p3(:,9)+w0_ds')],[0.7 0 0],'linestyle','none');
set(h,'facealpha',.3)
h=fill([t';flipud(t')],[v0p3(:,10)-w0_g2m';flipud(v0p3(:,10)+w0_g2m')],[0.5 0 0.9],'linestyle','none');
set(h,'facealpha',.3)

%Plot settings
ylim([0 6500]);
xlim([0 72]);
%set(gca,'YTick',[0, 35, 70]);
set(gca,'XTick',[0, 24, 48, 72]);
set(gca,'FontSize',12);
%legend([],'Total','G_1','S','D-S','G_2/M','Location','northeastoutside','FontSize',12);
title({'Monolayer simulation. Dose: 0.3 \muM.'},'FontSize', 16);
ylabel('Cell count','FontSize', 16);
xlabel('Time (hours)','FontSize', 16);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


subplot(3,2,3)
%Simulation means
set(gca, 'ColorOrder', [0 0 0; 0.2 0.7 0.4; 0.9 .9 0.4; 0.7 0 0; 0.5 0 0.9],...
    'NextPlot', 'replacechildren');   
hold on
plot(t,v1(:,6),t,v1(:,7),t,v1(:,8),t,v1(:,9),t,v1(:,10),'LineWidth',2);
hold on
%f=get(gca,'Children'); 
h=fill([t';flipud(t')],[v1(:,6)-w0_6';flipud(v1(:,6)+w0_6')],[0 0 0],'linestyle','none');
set(h,'facealpha',.3)
h=fill([t';flipud(t')],[v1(:,7)-w0_g1';flipud(v1(:,7)+w0_g1')],[0.2 0.7 0.4],'linestyle','none');
set(h,'facealpha',.3)
h=fill([t';flipud(t')],[v1(:,8)-w0_s';flipud(v1(:,8)+w0_s')],[0.9 .9 0.4],'linestyle','none');
set(h,'facealpha',.3)
h=fill([t';flipud(t')],[v1(:,9)-w0_ds';flipud(v1(:,9)+w0_ds')],[0.7 0 0],'linestyle','none');
set(h,'facealpha',.3)
h=fill([t';flipud(t')],[v1(:,10)-w0_g2m';flipud(v1(:,10)+w0_g2m')],[0.5 0 0.9],'linestyle','none');
set(h,'facealpha',.3)

%Plot settings
ylim([0 6500]);
xlim([0 72]);
%set(gca,'YTick',[0, 35, 70]);
set(gca,'XTick',[0, 24, 48, 72]);
set(gca,'FontSize',12);
%legend([],'Total','G_1','S','D-S','G_2/M','Location','northeastoutside','FontSize',12);
title({'Monolayer simulation. Dose: 1 \muM.'},'FontSize', 16);
ylabel('Cell count','FontSize', 16);
xlabel('Time (hours)','FontSize', 16);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


subplot(3,2,4)
%Simulation means
set(gca, 'ColorOrder', [0 0 0; 0.2 0.7 0.4; 0.9 .9 0.4; 0.7 0 0; 0.5 0 0.9],...
    'NextPlot', 'replacechildren');   
hold on
plot(t,v3(:,6),t,v3(:,7),t,v3(:,8),t,v3(:,9),t,v3(:,10),'LineWidth',2);
hold on
%f=get(gca,'Children'); 
h=fill([t';flipud(t')],[v3(:,6)-w0_6';flipud(v3(:,6)+w0_6')],[0 0 0],'linestyle','none');
set(h,'facealpha',.3)
h=fill([t';flipud(t')],[v3(:,7)-w0_g1';flipud(v3(:,7)+w0_g1')],[0.2 0.7 0.4],'linestyle','none');
set(h,'facealpha',.3)
h=fill([t';flipud(t')],[v3(:,8)-w0_s';flipud(v3(:,8)+w0_s')],[0.9 .9 0.4],'linestyle','none');
set(h,'facealpha',.3)
h=fill([t';flipud(t')],[v3(:,9)-w0_ds';flipud(v3(:,9)+w0_ds')],[0.7 0 0],'linestyle','none');
set(h,'facealpha',.3)
h=fill([t';flipud(t')],[v3(:,10)-w0_g2m';flipud(v3(:,10)+w0_g2m')],[0.5 0 0.9],'linestyle','none');
set(h,'facealpha',.3)

%Plot settings
ylim([0 6500]);
xlim([0 72]);
%set(gca,'YTick',[0, 35, 70]);
set(gca,'XTick',[0, 24, 48, 72]);
set(gca,'FontSize',12);
%legend([],'Total','G_1','S','D-S','G_2/M','Location','northeastoutside','FontSize',12);
title({'Monolayer simulation. Dose: 3 \muM.'},'FontSize', 16);
ylabel('Cell count','FontSize', 16);
xlabel('Time (hours)','FontSize', 16);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


subplot(3,2,5)
%Simulation means
set(gca, 'ColorOrder', [0 0 0; 0.2 0.7 0.4; 0.9 .9 0.4; 0.7 0 0; 0.5 0 0.9],...
    'NextPlot', 'replacechildren');   
hold on
plot(t,v10(:,6),t,v10(:,7),t,v10(:,8),t,v10(:,9),t,v10(:,10),'LineWidth',2);
hold on
%f=get(gca,'Children'); 
h=fill([t';flipud(t')],[v10(:,6)-w0_6';flipud(v10(:,6)+w0_6')],[0 0 0],'linestyle','none');
set(h,'facealpha',.3)
h=fill([t';flipud(t')],[v10(:,7)-w0_g1';flipud(v10(:,7)+w0_g1')],[0.2 0.7 0.4],'linestyle','none');
set(h,'facealpha',.3)
h=fill([t';flipud(t')],[v10(:,8)-w0_s';flipud(v10(:,8)+w0_s')],[0.9 .9 0.4],'linestyle','none');
set(h,'facealpha',.3)
h=fill([t';flipud(t')],[v10(:,9)-w0_ds';flipud(v10(:,9)+w0_ds')],[0.7 0 0],'linestyle','none');
set(h,'facealpha',.3)
h=fill([t';flipud(t')],[v10(:,10)-w0_g2m';flipud(v10(:,10)+w0_g2m')],[0.5 0 0.9],'linestyle','none');
set(h,'facealpha',.3)

%Plot settings
ylim([0 6500]);
xlim([0 72]);
%set(gca,'YTick',[0, 35, 70]);
set(gca,'XTick',[0, 24, 48, 72]);
set(gca,'FontSize',12);
%legend([],'Total','G_1','S','D-S','G_2/M','Location','northeastoutside','FontSize',12);
title({'Monolayer simulation. Dose: 10 \muM.'},'FontSize', 16);
ylabel('Cell count','FontSize', 16);
xlabel('Time (hours)','FontSize', 16);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


subplot(3,2,6)
%Simulation means
set(gca, 'ColorOrder', [0 0 0; 0.2 0.7 0.4; 0.9 .9 0.4; 0.7 0 0; 0.5 0 0.9],...
    'NextPlot', 'replacechildren');   
hold on
plot(t,v30(:,6),t,v30(:,7),t,v30(:,8),t,v30(:,9),t,v30(:,10),'LineWidth',2);
hold on
%f=get(gca,'Children'); 
h=fill([t';flipud(t')],[v30(:,6)-w0_6';flipud(v30(:,6)+w0_6')],[0 0 0],'linestyle','none');
set(h,'facealpha',.3)
h=fill([t';flipud(t')],[v30(:,7)-w0_g1';flipud(v30(:,7)+w0_g1')],[0.2 0.7 0.4],'linestyle','none');
set(h,'facealpha',.3)
h=fill([t';flipud(t')],[v30(:,8)-w0_s';flipud(v30(:,8)+w0_s')],[0.9 .9 0.4],'linestyle','none');
set(h,'facealpha',.3)
h=fill([t';flipud(t')],[v30(:,9)-w0_ds';flipud(v30(:,9)+w0_ds')],[0.7 0 0],'linestyle','none');
set(h,'facealpha',.3)
h=fill([t';flipud(t')],[v30(:,10)-w0_g2m';flipud(v30(:,10)+w0_g2m')],[0.5 0 0.9],'linestyle','none');
set(h,'facealpha',.3)

%Plot settings
ylim([0 6500]);
xlim([0 72]);
%set(gca,'YTick',[0, 35, 70]);
set(gca,'XTick',[0, 24, 48, 72]);
set(gca,'FontSize',12);
legend([],'Total','G_1','S','D-S','G_2/M','Location','southoutside','Orientation','horizontal','FontSize',16);
title({'Monolayer simulation. Dose: 30 \muM.'},'FontSize', 16);
ylabel('Cell count','FontSize', 16);
xlabel('Time (hours)','FontSize', 16);
