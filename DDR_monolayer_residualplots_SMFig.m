close all
clear all
%%% in vitro, No Washout %%%
% time points
t_nw=[2,4,8,16,24,48,72];
% data points, dose = 0uM
y_nw_0=[2.1400001049,2.2000000477,2.8975000381,1.4400000572,1.2949999571,1.9325000048,1.7074999809];
y_nw_sd_0=[0.5633826408,0.4532843111,1.2179593589,0.333166625,0.3160696126,0.4375976082,0.2140677463];
c_nw_0=[996,850,1287.5,2742.75,1857.5,3605.25,3753];
c_nw_sd_0=[59.7159945073,62.2949971239,417.5919060518,439.6910847402,409.3934537825,167.376571439,311.173049394];
% data points, dose = 0.3uM
y_nw_0p3=[2.9349999428,6.1487498283,7.4087500572,15.6762504578,12.9149999619,11.0725002289,6.5675001144];
y_nw_sd_0p3=[0.5942342011,1.0025886138,1.9926754269,5.5567126394,3.4212570789,4.178395967,3.300293277];
c_nw_0p3=[1081.875,1040.75,1447.25,2479.5,1805.625,3497.625,3928.25];
c_nw_sd_0p3=[53.632179839,217.95920326,392.4453556138,414.0169078673,161.4106895911,385.1938055799,376.0842420826];
% data points, dose = 1uM
y_nw_1=[17.3500003815,29.1162490845,36.0525016785,38.5149993896,45.0087509155,39.4749984741,33.4737510681];
y_nw_sd_1=[3.3138066156,3.4714218474,4.3478853645,9.2464804115,6.0087613116,7.4726415295,5.4601882163];
c_nw_1=[1129.625,1153.625,1303.875,2420.25,1226.375,1600.375,1612.875];
c_nw_sd_1=[58.2603454945,331.309064815,199.7229777896,744.3842613674,185.5793534545,456.7990922871,540.547985844];
% data points, dose = 3uM
y_nw_3=[36.0099983215,46.4737510681,56.7212486267,58.4112510681,68.0737533569,65.9037475586,63.8162498474];
y_nw_sd_3=[2.4240226307,4.0851960523,2.6182460732,8.8073466695,2.053373096,4.4001069386,2.6708368806];
c_nw_3=[1171.1428222656,1291.375,1224.625,1784.375,765.75,638.75,392.625];
c_nw_sd_3=[97.7128933346,567.6306489007,113.3048195924,513.0633315126,70.7626818518,112.5391995199,67.6354461169];
% data points, dose = 10uM
y_nw_10=[39.3837509155,47.9824981689,59.3487510681,65.2137527466,71.0199966431,69.7549972534,67.2450027466];
y_nw_sd_10=[2.6215804257,2.3178422848,1.9925678874,10.4783653817,2.0979718097,4.4218709679,2.8722315864];
c_nw_10=[1191.125,1056.625,1113.625,1396,654.5,525.2857055664,326.625];
c_nw_sd_10=[110.1485198656,106.7211821256,144.4219388755,633.8638880481,100.2553881701,43.926887308,47.7312042289];
% data points, dose = 30uM
y_nw_30=[35.3650016785,45.6624984741,51.3699989319,50.3462486267,63.9174995422,64.9225006104,67.6337509155];
y_nw_sd_30=[2.2128391588,1.7466110042,1.1057770377,4.1929462451,2.1507855708,3.25155677,3.9560511968];
c_nw_30=[1055.125,1049.125,1228.75,1794.875,629,469.625,265.125];
c_nw_sd_30=[155.1593075335,147.9608418274,211.9580484099,435.4214501902,27.1187863192,61.2580898448,22.2610325778];
% 

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

%stdev for col 2 (gammah2ax)
w0_2=getMatrixStdDev(v0,no_runs,2);
w0p3_2=getMatrixStdDev(v0p3,no_runs,2);
w1_2=getMatrixStdDev(v1,no_runs,2);
w3_2=getMatrixStdDev(v3,no_runs,2);
w10_2=getMatrixStdDev(v10,no_runs,2);
w30_2=getMatrixStdDev(v30,no_runs,2);
%stdev for col 6 (cellcount)
w0_6=getMatrixStdDev(v0,no_runs,6);
w0p3_6=getMatrixStdDev(v0p3,no_runs,6);
w1_6=getMatrixStdDev(v1,no_runs,6);
w3_6=getMatrixStdDev(v3,no_runs,6);
w10_6=getMatrixStdDev(v10,no_runs,6);
w30_6=getMatrixStdDev(v30,no_runs,6);
%t_nw_insilico=[2,4,8,16,24,48,72]-1;
% data points, dose = 0uM

%averages
v0=getMatrixAverage(v0, no_runs);
v0p3=getMatrixAverage(v0p3, no_runs);
v1=getMatrixAverage(v1, no_runs);
v3=getMatrixAverage(v3, no_runs);
v10=getMatrixAverage(v10, no_runs);
v30=getMatrixAverage(v30, no_runs);

t=1:length(v0);


%%%%%%%%%%%%%
%COMPARISON PLOTS
%%%%%%%%%%%%%

%%% Load Data

%%AMB
centerline = 0*ones(1,length(t));
i=2;

y_shift_0 = [v0(2,i) v0(4,i) v0(8,i) v0(16,i) v0(24,i) v0(48,i) v0(72,i)];
y_shift_0p3 = [v0p3(2,i) v0p3(4,i) v0p3(8,i) v0p3(16,i) v0p3(24,i) v0p3(48,i) v0p3(72,i)];
y_shift_1 = [v1(2,i) v1(4,i) v1(8,i) v1(16,i) v1(24,i) v1(48,i) v1(72,i)];
y_shift_3 = [v3(2,i) v3(4,i) v3(8,i) v3(16,i) v3(24,i) v3(48,i) v3(72,i)];
y_shift_10 = [v10(2,i) v10(4,i) v10(8,i) v10(16,i) v10(24,i) v10(48,i) v10(72,i)];
y_shift_30 = [v30(2,i) v30(4,i) v30(8,i) v30(16,i) v30(24,i) v30(48,i) v30(72,i)];

y_resid_0 = y_nw_0 - y_shift_0; %data midpoints - simulated midpoints
y_resid_0p3 = y_nw_0p3 - y_shift_0p3; 
y_resid_1 = y_nw_1 - y_shift_1; 
y_resid_3 = y_nw_3 - y_shift_3; 
y_resid_10 = y_nw_10 - y_shift_10; 
y_resid_30 = y_nw_30 - y_shift_30; 

ABM_sumsqr_y = sumsqr([y_resid_0 y_resid_0p3 y_resid_1 y_resid_3 y_resid_10 y_resid_30]);
ABM_mean_sumsqr_y = ABM_sumsqr_y/(length(t_nw)*6);
RMSE_ABM_y = sqrt(ABM_mean_sumsqr_y);

%%ODE


[t_check,y_check,yH2AXtotal_check_0,totalcells_check_0]=ATR_simulation_from_checkley_etal2015(0);
[t_check,y_check,yH2AXtotal_check_0p3,totalcells_check_0p3]=ATR_simulation_from_checkley_etal2015(0.3);
[t_check,y_check,yH2AXtotal_check_1,totalcells_check_1]=ATR_simulation_from_checkley_etal2015(1);
[t_check,y_check,yH2AXtotal_check_3,totalcells_check_3]=ATR_simulation_from_checkley_etal2015(3);
[t_check,y_check,yH2AXtotal_check_10,totalcells_check_10]=ATR_simulation_from_checkley_etal2015(10);
[t_check,y_check,yH2AXtotal_check_30,totalcells_check_30]=ATR_simulation_from_checkley_etal2015(30);

v0_chg=yH2AXtotal_check_0;
v0p3_chg=yH2AXtotal_check_0p3;
v1_chg=yH2AXtotal_check_1;
v3_chg=yH2AXtotal_check_3;
v10_chg=yH2AXtotal_check_10;
v30_chg=yH2AXtotal_check_30;

y_shift_0_check = [v0_chg(2) v0_chg(4) v0_chg(8) v0_chg(16) v0_chg(24) v0_chg(48) v0_chg(72)];
y_shift_0p3_check = [v0p3_chg(2) v0p3_chg(4) v0p3_chg(8) v0p3_chg(16) v0p3_chg(24) v0p3_chg(48) v0p3_chg(72)];
y_shift_1_check = [v1_chg(2) v1_chg(4) v1_chg(8) v1_chg(16) v1_chg(24) v1_chg(48) v1_chg(72)];
y_shift_3_check = [v3_chg(2) v3_chg(4) v3_chg(8) v3_chg(16) v3_chg(24) v3_chg(48) v3_chg(72)];
y_shift_10_check = [v10_chg(2) v10_chg(4) v10_chg(8) v10_chg(16) v10_chg(24) v10_chg(48) v10_chg(72)];
y_shift_30_check = [v30_chg(2) v30_chg(4) v30_chg(8) v30_chg(16) v30_chg(24) v30_chg(48) v30_chg(72)];


y_resid_0_check = y_nw_0 - y_shift_0_check; %data midpoints - simulated midpoints
y_resid_0p3_check = y_nw_0p3 - y_shift_0p3_check; 
y_resid_1_check = y_nw_1 - y_shift_1_check; 
y_resid_3_check = y_nw_3 - y_shift_3_check; 
y_resid_10_check = y_nw_10 - y_shift_10_check; 
y_resid_30_check = y_nw_30 - y_shift_30_check; 

ODE_sumsqr_y = sumsqr([y_resid_0_check y_resid_0p3_check y_resid_1_check y_resid_3_check y_resid_10_check y_resid_30_check]);
ODE_mean_sumsqr_y = ODE_sumsqr_y/(length(t_nw)*6);
RMSE_ODE_y = sqrt(ODE_mean_sumsqr_y);



%%Plots

fig=figure
left_color = [0 .0 0];
right_color = [0 0 0];
set(fig,'defaultAxesColorOrder',[left_color; right_color]);


subplot(6,2,1)
plot(t,centerline,'Color',[0.1 0.0 1.0])
hold on
h=fill([t';flipud(t')],[centerline'-w0_2';flipud(centerline'+w0_2')],[0.1 0.0 1.0],'linestyle','none');
set(h,'facealpha',.7)
hold on
e=errorbar(t_nw,y_resid_0,y_nw_sd_0,'+','color',[0.1 0.0 1.0]);
hold on
plot(t, v0_chg-v0(:,i),':','color',[0.1 0.0 1.0])
ylim([-10 10]);
%
set(gca,'YTick',[-10, -5, 0, 5, 10]);
xlim([0 72]);
set(gca,'XTick',[0, 24, 48, 72]);
set(gca,'FontSize',12);
ylabel({'residual','units of percent'},'FontSize', 10);
title({'Monolayer DNA damage ABM results compared to{\it in vitro} data and Comp-ODE results'},'FontSize', 10);
%
yyaxis right
ylabel('Dose: 0 \muM','Color',[0.1 0.0 1.0])
set(gca,'YTick',[]);


subplot(6,2,3)
plot(t,centerline,'Color',[0.1 0.6 0.1])
hold on
h=fill([t';flipud(t')],[centerline'-w0p3_2';flipud(centerline'+w0p3_2')],[0.1 0.6 0.1],'linestyle','none');
set(h,'facealpha',.7)
hold on
e=errorbar(t_nw,y_resid_0p3,y_nw_sd_0p3,'+','color',[0.1 0.6 0.1]);
hold on
plot(t, v0p3_chg-v0p3(:,i),':','color',[0.1 0.6 0.1])
ylim([-25 25]);
%
set(gca,'YTick',[-20, -10, 0, 10, 20]);
xlim([0 72]);
set(gca,'XTick',[0, 24, 48, 72]);
set(gca,'FontSize',12);
ylabel({'residual','units of percent'},'FontSize', 10);
%
yyaxis right
ylabel('Dose: 0.3 \muM','Color',[0.1 0.6 0.1])
set(gca,'YTick',[]);

subplot(6,2,5)
plot(t,centerline,'Color',[0.8 0 0])
hold on
h=fill([t';flipud(t')],[centerline'-w1_2';flipud(centerline'+w1_2')],[0.8 0 0],'linestyle','none');
set(h,'facealpha',.7)
hold on
e=errorbar(t_nw,y_resid_1,y_nw_sd_1,'+','color',[0.8 0 0]);
hold on
plot(t, v1_chg-v1(:,i),':','color',[0.8 0 0]);
ylim([-40 40]);
%
set(gca,'YTick',[-40 -20 0 20 40]);
xlim([0 72]);
set(gca,'XTick',[0, 24, 48, 72]);
set(gca,'FontSize',12);
ylabel({'residual','units of percent'},'FontSize', 10);
%
yyaxis right
ylabel('Dose: 1 \muM','Color',[0.8 0 0])
set(gca,'YTick',[]);

subplot(6,2,7)
plot(t,centerline,'Color',[0.7 0.2 1])
hold on
h=fill([t';flipud(t')],[centerline'-w3_2';flipud(centerline'+w3_2')],[0.7 0.2 1],'linestyle','none');
set(h,'facealpha',.7)
hold on
e=errorbar(t_nw,y_resid_3,y_nw_sd_3,'+','color',[0.7 0.2 1]);
hold on
plot(t, v3_chg-v3(:,i),':','color',[0.7 0.2 1])
ylim([-40 40]);
%
set(gca,'YTick',[-40 -20 0 20 40]);
xlim([0 72]);
set(gca,'XTick',[0, 24, 48, 72]);
set(gca,'FontSize',12);
ylabel({'residual','units of percent'},'FontSize', 10);
%
yyaxis right
ylabel('Dose: 3 \muM','Color',[0.7 0.2 1])
set(gca,'YTick',[]);

subplot(6,2,9)
plot(t,centerline,'Color',[0.1 1 0.9])
hold on
h=fill([t';flipud(t')],[centerline'-w10_2';flipud(centerline'+w10_2')],[0.1 1 0.9],'linestyle','none');
set(h,'facealpha',.7)
hold on
e=errorbar(t_nw,y_resid_10,y_nw_sd_10,'+','color',[0.1 1 0.9]);
hold on
plot(t, v10_chg-v10(:,i),':','color',[0.1 1 0.9])
ylim([-50 50]);
%
set(gca,'YTick',[-50 -25 0 25 50]);
xlim([0 72]);
set(gca,'XTick',[0, 24, 48, 72]);
set(gca,'FontSize',12);
ylabel({'residual','units of percent'},'FontSize', 10);
%
yyaxis right
ylabel('Dose: 10 \muM','Color',[0.1 1 0.9])
set(gca,'YTick',[]);

subplot(6,2,11)
plot(t,centerline,'Color',[0.9 0.5 0])
hold on
h=fill([t';flipud(t')],[centerline'-w30_2';flipud(centerline'+w30_2')],[0.9 0.5 0],'linestyle','none');
set(h,'facealpha',.7)
hold on
e=errorbar(t_nw,y_resid_30,y_nw_sd_30,'+','color',[0.9 0.5 0]);
hold on
plot(t, v30_chg-v30(:,i),':','color',[0.9 0.5 0])
ylim([-40 40]);
%
set(gca,'YTick',[-40 -20 0 20 40]);
xlim([0 72]);
set(gca,'XTick',[0, 24, 48, 72]);
set(gca,'FontSize',12);
ylabel({'residual','units of percent'},'FontSize', 10);
xlabel('Time (hours)','FontSize', 10);
%
yyaxis right
ylabel('Dose: 30 \muM','Color',[0.9 0.5 0])
set(gca,'YTick',[]);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%55

%figure
i=6;

%%%%%%%%%%%%%
%Load data

%ABM data
centerline = 0*ones(1,length(t));

c_shift_0 = [v0(2,i) v0(4,i) v0(8,i) v0(16,i) v0(24,i) v0(48,i) v0(72,i)];
c_shift_0p3 = [v0p3(2,i) v0p3(4,i) v0p3(8,i) v0p3(16,i) v0p3(24,i) v0p3(48,i) v0p3(72,i)];
c_shift_1 = [v1(2,i) v1(4,i) v1(8,i) v1(16,i) v1(24,i) v1(48,i) v1(72,i)];
c_shift_3 = [v3(2,i) v3(4,i) v3(8,i) v3(16,i) v3(24,i) v3(48,i) v3(72,i)];
c_shift_10 = [v10(2,i) v10(4,i) v10(8,i) v10(16,i) v10(24,i) v10(48,i) v10(72,i)];
c_shift_30 = [v30(2,i) v30(4,i) v30(8,i) v30(16,i) v30(24,i) v30(48,i) v30(72,i)];

c_resid_0 = c_nw_0 - c_shift_0; %data midpoints - simulated midpoints
c_resid_0p3 = c_nw_0p3 - c_shift_0p3; 
c_resid_1 = c_nw_1 - c_shift_1; 
c_resid_3 = c_nw_3 - c_shift_3; 
c_resid_10 = c_nw_10 - c_shift_10; 
c_resid_30 = c_nw_30 - c_shift_30; 

ABM_sumsqr_c = sumsqr([c_resid_0 c_resid_0p3 c_resid_1 c_resid_3 c_resid_10 c_resid_30]);
ABM_mean_sumsqr_c = ABM_sumsqr_c/(length(t_nw)*6);
RMSE_ABM_c = sqrt(ABM_mean_sumsqr_c);

%ODE data
[t_check,y_check,yH2AXtotal_check_0,totalcells_check_0]=ATR_simulation_from_checkley_etal2015(0);
[t_check,y_check,yH2AXtotal_check_0p3,totalcells_check_0p3]=ATR_simulation_from_checkley_etal2015(0.3);
[t_check,y_check,yH2AXtotal_check_1,totalcells_check_1]=ATR_simulation_from_checkley_etal2015(1);
[t_check,y_check,yH2AXtotal_check_3,totalcells_check_3]=ATR_simulation_from_checkley_etal2015(3);
[t_check,y_check,yH2AXtotal_check_10,totalcells_check_10]=ATR_simulation_from_checkley_etal2015(10);
[t_check,y_check,yH2AXtotal_check_30,totalcells_check_30]=ATR_simulation_from_checkley_etal2015(30);

v0_chc=totalcells_check_0;
v0p3_chc=totalcells_check_0p3;
v1_chc=totalcells_check_1;
v3_chc=totalcells_check_3;
v10_chc=totalcells_check_10;
v30_chc=totalcells_check_30;

c_shift_0_check = [v0_chc(2) v0_chc(4) v0_chc(8) v0_chc(16) v0_chc(24) v0_chc(48) v0_chc(72)];
c_shift_0p3_check = [v0p3_chc(2) v0p3_chc(4) v0p3_chc(8) v0p3_chc(16) v0p3_chc(24) v0p3_chc(48) v0p3_chc(72)];
c_shift_1_check = [v1_chc(2) v1_chc(4) v1_chc(8) v1_chc(16) v1_chc(24) v1_chc(48) v1_chc(72)];
c_shift_3_check = [v3_chc(2) v3_chc(4) v3_chc(8) v3_chc(16) v3_chc(24) v3_chc(48) v3_chc(72)];
c_shift_10_check = [v10_chc(2) v10_chc(4) v10_chc(8) v10_chc(16) v10_chc(24) v10_chc(48) v10_chc(72)];
c_shift_30_check = [v30_chc(2) v30_chc(4) v30_chc(8) v30_chc(16) v30_chc(24) v30_chc(48) v30_chc(72)];


c_resid_0_check = c_nw_0 - c_shift_0_check; %data midpoints - simulated midpoints
c_resid_0p3_check = c_nw_0p3 - c_shift_0p3_check; 
c_resid_1_check = c_nw_1 - c_shift_1_check; 
c_resid_3_check = c_nw_3 - c_shift_3_check; 
c_resid_10_check = c_nw_10 - c_shift_10_check; 
c_resid_30_check = c_nw_30 - c_shift_30_check; 

ODE_sumsqr_c = sumsqr([c_resid_0_check c_resid_0p3_check c_resid_1_check c_resid_3_check c_resid_10_check c_resid_30_check]);
ODE_mean_sumsqr_c = ODE_sumsqr_c/(length(t_nw)*6);
RMSE_ODE_c = sqrt(ODE_mean_sumsqr_c);

%%%PLot!
%fig=figure 
% left_color = [0 .0 0];
% right_color = [0 0 0];
% set(fig,'defaultAxesColorOrder',[left_color; right_color]);


subplot(6,2,2)
plot(t,centerline,'Color',[0.1 0.0 1.0])
hold on
h=fill([t';flipud(t')],[centerline'-w0_6';flipud(centerline'+w0_6')],[0.1 0.0 1.0],'linestyle','none');
set(h,'facealpha',.7)
hold on
e=errorbar(t_nw,c_resid_0,c_nw_sd_0,'+','color',[0.1 0.0 1.0]);
hold on
plot(t, v0_chc-v0(:,i),':','color',[0.1 0.0 1.0])
ylim([-3000 3000]);
%
set(gca,'YTick',[-3000, -1500, 0, 1500, 3000]);
xlim([0 72]);
set(gca,'XTick',[0, 24, 48, 72]);
set(gca,'FontSize',12);
ylabel({'residual cell count'},'FontSize', 10);
title({'Monolayer cell count ABM results compared to{\it in vitro} data and Comp-ODE results'},'FontSize', 10);
%
yyaxis right
ylabel('Dose: 0 \muM','Color',[0.1 0.0 1.0])
set(gca,'YTick',[]);


subplot(6,2,4)
plot(t,centerline,'Color',[0.1 0.6 0.1])
hold on
h=fill([t';flipud(t')],[centerline'-w0p3_6';flipud(centerline'+w0p3_6')],[0.1 0.6 0.1],'linestyle','none');
set(h,'facealpha',.7)
hold on
e=errorbar(t_nw,c_resid_0p3,c_nw_sd_0p3,'+','color',[0.1 0.6 0.1]);
hold on
plot(t, v0p3_chc-v0p3(:,i),':','color',[0.1 0.6 0.1])
ylim([-3000 3000]);
%
set(gca,'YTick',[-3000, -1500, 0, 1500, 3000]);
xlim([0 72]);
set(gca,'XTick',[0, 24, 48, 72]);
set(gca,'FontSize',12);
ylabel({'residual cell count'},'FontSize', 10)
%
yyaxis right
ylabel('Dose: 0.3 \muM','Color',[0.1 0.6 0.1])
set(gca,'YTick',[]);


subplot(6,2,6)
plot(t,centerline,'Color',[0.8 0 0])
hold on
h=fill([t';flipud(t')],[centerline'-w1_6';flipud(centerline'+w1_6')],[0.8 0 0],'linestyle','none');
set(h,'facealpha',.7)
hold on
e=errorbar(t_nw,c_resid_1,c_nw_sd_1,'+','color',[0.8 0 0]);
hold on
plot(t, v1_chc-v1(:,i),':','color',[0.8 0 0]);
ylim([-2000 2000]);
set(gca,'YTick',[-2000 -1000 0 1000 2000]);
xlim([0 72]);
set(gca,'XTick',[0, 24, 48, 72]);
set(gca,'FontSize',12);
ylabel({'residual cell count'},'FontSize', 10)
%
yyaxis right
ylabel('Dose: 1 \muM','Color',[0.8 0 0])
set(gca,'YTick',[]);


subplot(6,2,8)
plot(t,centerline,'Color',[0.7 0.2 1])
hold on
h=fill([t';flipud(t')],[centerline'-w3_6';flipud(centerline'+w3_6')],[0.7 0.2 1],'linestyle','none');
set(h,'facealpha',.7)
hold on
e=errorbar(t_nw,c_resid_3,c_nw_sd_3,'+','color',[0.7 0.2 1]);
hold on
plot(t, v3_chc-v3(:,i),':','color',[0.7 0.2 1])
ylim([-1200 1200]);
%
set(gca,'YTick',[-1200 -600 0 600 1200]);
xlim([0 72]);
set(gca,'XTick',[0, 24, 48, 72]);
set(gca,'FontSize',12);
ylabel({'residual cell count'},'FontSize', 10)
%
yyaxis right
ylabel('Dose: 3 \muM','Color',[0.7 0.2 1])
set(gca,'YTick',[]);



subplot(6,2,10)
plot(t,centerline,'Color',[0.1 1 0.9])
hold on
h=fill([t';flipud(t')],[centerline'-w10_6';flipud(centerline'+w10_6')],[0.1 1 0.9],'linestyle','none');
set(h,'facealpha',.7)
hold on
e=errorbar(t_nw,c_resid_10,c_nw_sd_10,'+','color',[0.1 1 0.9]);
hold on
plot(t, v10_chc-v10(:,i),':','color',[0.1 1 0.9])
ylim([-1000 1000]);
%
set(gca,'YTick',[-1000 -500 0 500 1000]);
xlim([0 72]);
set(gca,'XTick',[0, 24, 48, 72]);
set(gca,'FontSize',12);
ylabel({'residual cell count'},'FontSize', 10)
%
yyaxis right
ylabel('Dose: 10 \muM','Color',[0.1 1 0.9])
set(gca,'YTick',[]);

subplot(6,2,12)
plot(t,centerline,'Color',[0.9 0.5 0])
hold on
h=fill([t';flipud(t')],[centerline'-w30_6';flipud(centerline'+w30_6')],[0.9 0.5 0],'linestyle','none');
set(h,'facealpha',.7)
hold on
e=errorbar(t_nw,c_resid_30,c_nw_sd_30,'+','color',[0.9 0.5 0]);
hold on
plot(t, v30_chc-v30(:,i),':','color',[0.9 0.5 0])
ylim([-1200 1200]);
%
set(gca,'YTick',[-1200 -600 0 600 1200]);
xlim([0 72]);
set(gca,'XTick',[0, 24, 48, 72]);
set(gca,'FontSize',12);
ylabel({'residual cell count'},'FontSize', 10)
xlabel('Time (hours)','FontSize', 10);
%
yyaxis right
ylabel('Dose: 30 \muM','Color',[0.9 0.5 0])
set(gca,'YTick',[]);

