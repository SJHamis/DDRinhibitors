close all;
clear all;

%%%% Robustnes Analysis %%%%
% %1: time
% %2:(sd+termina)[% of cycling], 3:(sd+terminal)[% of all]
% %4:g1+s+sd+g2m 5:(3)+g0 6:(4)+terminal 
% %7:g1, 8:s, 9:sd, 10:g2m, 11:g0, 12:dead

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CONTROL
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
v_cal = importdata('SensitivityAnalysisData/invitro_mu24000_sigma500_DSprob75_DStime3_EC100_gamma200_Tdeath100_Dose0');
v_cal=v_cal(1:100*73, :);
l=length(v_cal)/73;
no_timesteps = 73;
no_data_points=length(v_cal)/no_timesteps;
no_data_cols = 12;
col1 =2 ;
col2 =6 ;

%%% Vary mu %%%
%%% Explored mu values: 22:0.5:26 h:
v_22= importdata('SensitivityAnalysisData/invitro_mu22000_sigma500_DSprob75_DStime3_EC100_gamma200_Tdeath100_Dose0');
v_22p5= importdata('SensitivityAnalysisData/invitro_mu22500_sigma500_DSprob75_DStime3_EC100_gamma200_Tdeath100_Dose0');
v_23= importdata('SensitivityAnalysisData/invitro_mu23000_sigma500_DSprob75_DStime3_EC100_gamma200_Tdeath100_Dose0');
v_23p5= importdata('SensitivityAnalysisData/invitro_mu23500_sigma500_DSprob75_DStime3_EC100_gamma200_Tdeath100_Dose0');
v_24p5= importdata('SensitivityAnalysisData/invitro_mu24500_sigma500_DSprob75_DStime3_EC100_gamma200_Tdeath100_Dose0');
v_25= importdata('SensitivityAnalysisData/invitro_mu25000_sigma500_DSprob75_DStime3_EC100_gamma200_Tdeath100_Dose0');
v_25p5= importdata('SensitivityAnalysisData/invitro_mu25500_sigma500_DSprob75_DStime3_EC100_gamma200_Tdeath100_Dose0');
v_26= importdata('SensitivityAnalysisData/invitro_mu26000_sigma500_DSprob75_DStime3_EC100_gamma200_Tdeath100_Dose0');

no_variations=9; %9 variations of mu explored
cal_index=5; %calibrated has index 5


v1=zeros(no_variations,no_data_points);
v2=zeros(no_variations,no_data_points);
%Put all the end-time cellcount datapoints in vectors v1,v2
dp=0;


for i = 73:73:length(v_cal)
    dp=dp+1;
    v1(1,dp)=v_22(i,col1);
    v1(2,dp)=v_22p5(i,col1);
    v1(3,dp)=v_23(i,col1);
    v1(4,dp)=v_23p5(i,col1);
    v1(5,dp)=v_cal(i,col1);
    v1(6,dp)=v_24p5(i,col1);
    v1(7,dp)=v_25(i,col1); 
    v1(8,dp)=v_25p5(i,col1);
    v1(9,dp)=v_26(i,col1);
    %
    v2(1,dp)=v_22(i,col2);
    v2(2,dp)=v_22p5(i,col2);
    v2(3,dp)=v_23(i,col2);
    v2(4,dp)=v_23p5(i,col2);
    v2(5,dp)=v_cal(i,col2);
    v2(6,dp)=v_24p5(i,col2);
    v2(7,dp)=v_25(i,col2); 
    v2(8,dp)=v_25p5(i,col2);
    v2(9,dp)=v_26(i,col2);
end
% Now all the data is in one matrix
A=zeros(no_variations, 5); 
A(:,1)=[22:0.5:26]'; %first col is parmameter value
for i = 1:no_variations 
    [A(i,2), A(i,3)] = getA_measure( v1(i,:),v1(cal_index,:));%DAMAGE: 2nd col is Ameasur, 3rd is scaled A measure
    [A(i,4), A(i,5)] = getA_measure( v2(i,:),v2(cal_index,:));%CELLCOUNT: 4th col is Ameasur, 5th is scaled A measure
end



%create_RA_plots(A,v1,v2);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Vary sigma %%%
%%% Explored sigma values: 0:0.25:2,5 h:
v_0= importdata('SensitivityAnalysisData/invitro_mu24000_sigma0_DSprob75_DStime3_EC100_gamma200_Tdeath100_Dose0');
v_0p25= importdata('SensitivityAnalysisData/invitro_mu24000_sigma250_DSprob75_DStime3_EC100_gamma200_Tdeath100_Dose0');
v_0p75= importdata('SensitivityAnalysisData/invitro_mu24000_sigma750_DSprob75_DStime3_EC100_gamma200_Tdeath100_Dose0');
v_1= importdata('SensitivityAnalysisData/invitro_mu24000_sigma1000_DSprob75_DStime3_EC100_gamma200_Tdeath100_Dose0');
v_1p25= importdata('SensitivityAnalysisData/invitro_mu24000_sigma1250_DSprob75_DStime3_EC100_gamma200_Tdeath100_Dose0');
v_1p5= importdata('SensitivityAnalysisData/invitro_mu24000_sigma1500_DSprob75_DStime3_EC100_gamma200_Tdeath100_Dose0');
v_1p75= importdata('SensitivityAnalysisData/invitro_mu24000_sigma1750_DSprob75_DStime3_EC100_gamma200_Tdeath100_Dose0');
v_2= importdata('SensitivityAnalysisData/invitro_mu24000_sigma2000_DSprob75_DStime3_EC100_gamma200_Tdeath100_Dose0');
v_2p25= importdata('SensitivityAnalysisData/invitro_mu24000_sigma2250_DSprob75_DStime3_EC100_gamma200_Tdeath100_Dose0');
v_2p5= importdata('SensitivityAnalysisData/invitro_mu24000_sigma2500_DSprob75_DStime3_EC100_gamma200_Tdeath100_Dose0');
v_0=v_0(1:7300,:);
v_1p5=v_1p5(1:7300,:);
v_2p5=v_2p5(1:7300,:);


no_variations=11;
cal_index=3;

v1=zeros(no_variations,no_data_points);
v2=zeros(no_variations,no_data_points);
dp=0;

for i = 73:73:length(v_cal)
    dp=dp+1;
    v1(1,dp)=v_0(i,col1);
    v1(2,dp)=v_0p25(i,col1);
    v1(3,dp)=v_cal(i,col1);
    v1(4,dp)=v_0p75(i,col1);
    v1(5,dp)=v_1(i,col1);
    v1(6,dp)=v_1p25(i,col1);
    v1(7,dp)=v_1p5(i,col1); 
    v1(8,dp)=v_1p75(i,col1);
    v1(9,dp)=v_2(i,col1);
    v1(10,dp)=v_2p25(i,col1);
    v1(11,dp)=v_2p5(i,col1);
    %
    v2(1,dp)=v_0(i,col2);
    v2(2,dp)=v_0p25(i,col2);
    v2(3,dp)=v_cal(i,col2);
    v2(4,dp)=v_0p75(i,col2);
    v2(5,dp)=v_1(i,col2);
    v2(6,dp)=v_1p25(i,col2);
    v2(7,dp)=v_1p5(i,col2); 
    v2(8,dp)=v_1p75(i,col2);
    v2(9,dp)=v_2(i,col2);
    v2(10,dp)=v_2p25(i,col2);
    v2(11,dp)=v_2p5(i,col2);
end
% Now all the data is in one matrix
A=zeros(no_variations, 5); 
A(:,1)=[0:0.25:2.5]'; %first col is parmameter value
for i = 1:no_variations 
    [A(i,2), A(i,3)] = getA_measure( v1(i,:),v1(cal_index,:));%DAMAGE: 2nd col is Ameasur, 3rd is scaled A measure
    [A(i,4), A(i,5)] = getA_measure( v2(i,:),v2(cal_index,:));%CELLCOUNT: 4th col is Ameasur, 5th is scaled A measure
end

%create_RA_plots(A(2:end, :), v1(2:end,:),v2(2:end,:));



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Dose 1 uM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
v_cal = importdata('SensitivityAnalysisData/invitro_mu24000_sigma500_DSprob75_DStime3_EC100_gamma200_Tdeath100_Dose100');
v_cal=v_cal(1:100*73, :);


%%% Vary mu %%%
%%% Explored mu values: 22:0.5:26 h:
v_22= importdata('SensitivityAnalysisData/invitro_mu22000_sigma500_DSprob75_DStime3_EC100_gamma200_Tdeath100_Dose100');
v_22p5= importdata('SensitivityAnalysisData/invitro_mu22500_sigma500_DSprob75_DStime3_EC100_gamma200_Tdeath100_Dose100');
v_23= importdata('SensitivityAnalysisData/invitro_mu23000_sigma500_DSprob75_DStime3_EC100_gamma200_Tdeath100_Dose100');
v_23p5= importdata('SensitivityAnalysisData/invitro_mu23500_sigma500_DSprob75_DStime3_EC100_gamma200_Tdeath100_Dose100');
v_24p5= importdata('SensitivityAnalysisData/invitro_mu24500_sigma500_DSprob75_DStime3_EC100_gamma200_Tdeath100_Dose100');
v_25= importdata('SensitivityAnalysisData/invitro_mu25000_sigma500_DSprob75_DStime3_EC100_gamma200_Tdeath100_Dose100');
v_25p5= importdata('SensitivityAnalysisData/invitro_mu25500_sigma500_DSprob75_DStime3_EC100_gamma200_Tdeath100_Dose100');
v_26= importdata('SensitivityAnalysisData/invitro_mu26000_sigma500_DSprob75_DStime3_EC100_gamma200_Tdeath100_Dose100');
no_variations=9; %9 variations of mu explored
cal_index=5; %calibrated has index 5
v1=zeros(no_variations,no_data_points);
v2=zeros(no_variations,no_data_points);
%Put all the end-time cellcount datapoints in vectors v1,v2
dp=0;
for i = 73:73:length(v_cal)
    dp=dp+1;
    v1(1,dp)=v_22(i,col1);
    v1(2,dp)=v_22p5(i,col1);
    v1(3,dp)=v_23(i,col1);
    v1(4,dp)=v_23p5(i,col1);
    v1(5,dp)=v_cal(i,col1);
    v1(6,dp)=v_24p5(i,col1);
    v1(7,dp)=v_25(i,col1); 
    v1(8,dp)=v_25p5(i,col1);
    v1(9,dp)=v_26(i,col1);
    %
    v2(1,dp)=v_22(i,col2);
    v2(2,dp)=v_22p5(i,col2);
    v2(3,dp)=v_23(i,col2);
    v2(4,dp)=v_23p5(i,col2);
    v2(5,dp)=v_cal(i,col2);
    v2(6,dp)=v_24p5(i,col2);
    v2(7,dp)=v_25(i,col2); 
    v2(8,dp)=v_25p5(i,col2);
    v2(9,dp)=v_26(i,col2);
end
% Now all the data is in one matrix
A=zeros(no_variations, 5); 
A(:,1)=[22:0.5:26]'; %first col is parmameter value
for i = 1:no_variations 
    [A(i,2), A(i,3)] = getA_measure( v1(i,:),v1(cal_index,:));%DAMAGE: 2nd col is Ameasur, 3rd is scaled A measure
    [A(i,4), A(i,5)] = getA_measure( v2(i,:),v2(cal_index,:));%CELLCOUNT: 4th col is Ameasur, 5th is scaled A measure
end



%create_RA_plots(A,v1,v2);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Vary sigma %%%
%%% Explored sigma values: 0:0.25:2,5 h:
v_0= importdata('SensitivityAnalysisData/invitro_mu24000_sigma0_DSprob75_DStime3_EC100_gamma200_Tdeath100_Dose100');
v_0p25= importdata('SensitivityAnalysisData/invitro_mu24000_sigma250_DSprob75_DStime3_EC100_gamma200_Tdeath100_Dose100');
v_0p75= importdata('SensitivityAnalysisData/invitro_mu24000_sigma750_DSprob75_DStime3_EC100_gamma200_Tdeath100_Dose100');
v_1= importdata('SensitivityAnalysisData/invitro_mu24000_sigma1000_DSprob75_DStime3_EC100_gamma200_Tdeath100_Dose100');
v_1p25= importdata('SensitivityAnalysisData/invitro_mu24000_sigma1250_DSprob75_DStime3_EC100_gamma200_Tdeath100_Dose100');
v_1p5= importdata('SensitivityAnalysisData/invitro_mu24000_sigma1500_DSprob75_DStime3_EC100_gamma200_Tdeath100_Dose100');
v_1p75= importdata('SensitivityAnalysisData/invitro_mu24000_sigma1750_DSprob75_DStime3_EC100_gamma200_Tdeath100_Dose100');
v_2= importdata('SensitivityAnalysisData/invitro_mu24000_sigma2000_DSprob75_DStime3_EC100_gamma200_Tdeath100_Dose100');
v_2p25= importdata('SensitivityAnalysisData/invitro_mu24000_sigma2250_DSprob75_DStime3_EC100_gamma200_Tdeath100_Dose100');
v_2p5= importdata('SensitivityAnalysisData/invitro_mu24000_sigma2500_DSprob75_DStime3_EC100_gamma200_Tdeath100_Dose100');
v_0=v_0(1:7300,:);
v_1p25=v_1p25(1:7300,:);
v_1p5=v_1p5(1:7300,:);
v_2p5=v_2p5(1:7300,:);


no_variations=11;
cal_index=3;

v1=zeros(no_variations,no_data_points);
v2=zeros(no_variations,no_data_points);
dp=0;

for i = 73:73:length(v_cal)
    dp=dp+1;
    v1(1,dp)=v_0(i,col1);
    v1(2,dp)=v_0p25(i,col1);
    v1(3,dp)=v_cal(i,col1);
    v1(4,dp)=v_0p75(i,col1);
    v1(5,dp)=v_1(i,col1);
    v1(6,dp)=v_1p25(i,col1);
    v1(7,dp)=v_1p5(i,col1); 
    v1(8,dp)=v_1p75(i,col1);
    v1(9,dp)=v_2(i,col1);
    v1(10,dp)=v_2p25(i,col1);
    v1(11,dp)=v_2p5(i,col1);
    %
    v2(1,dp)=v_0(i,col2);
    v2(2,dp)=v_0p25(i,col2);
    v2(3,dp)=v_cal(i,col2);
    v2(4,dp)=v_0p75(i,col2);
    v2(5,dp)=v_1(i,col2);
    v2(6,dp)=v_1p25(i,col2);
    v2(7,dp)=v_1p5(i,col2); 
    v2(8,dp)=v_1p75(i,col2);
    v2(9,dp)=v_2(i,col2);
    v2(10,dp)=v_2p25(i,col2);
    v2(11,dp)=v_2p5(i,col2);
end
% Now all the data is in one matrix
A=zeros(no_variations, 5); 
A(:,1)=[0:0.25:2.5]'; %first col is parmameter value
for i = 1:no_variations 
    [A(i,2), A(i,3)] = getA_measure( v1(i,:),v1(cal_index,:));%DAMAGE: 2nd col is Ameasur, 3rd is scaled A measure
    [A(i,4), A(i,5)] = getA_measure( v2(i,:),v2(cal_index,:));%CELLCOUNT: 4th col is Ameasur, 5th is scaled A measure
end

%create_RA_plots(A,v1,v2);



%%%%%%%%%%%%%%%%%%%%%
%%% Vary P-DS %%%
%%% Explored sigma values: 0:0.25:2,5 h:
v_65= importdata('SensitivityAnalysisData/invitro_mu24000_sigma500_DSprob65_DStime3_EC100_gamma200_Tdeath100_Dose100');
v_67p5= importdata('SensitivityAnalysisData/invitro_mu24000_sigma500_DSprob67_DStime3_EC100_gamma200_Tdeath100_Dose100');
v_70= importdata('SensitivityAnalysisData/invitro_mu24000_sigma500_DSprob70_DStime3_EC100_gamma200_Tdeath100_Dose100');
v_72p5= importdata('SensitivityAnalysisData/invitro_mu24000_sigma500_DSprob72_DStime3_EC100_gamma200_Tdeath100_Dose100');
v_77p5= importdata('SensitivityAnalysisData/invitro_mu24000_sigma500_DSprob77_DStime3_EC100_gamma200_Tdeath100_Dose100');
v_80= importdata('SensitivityAnalysisData/invitro_mu24000_sigma500_DSprob80_DStime3_EC100_gamma200_Tdeath100_Dose100');
v_82p5= importdata('SensitivityAnalysisData/invitro_mu24000_sigma500_DSprob82_DStime3_EC100_gamma200_Tdeath100_Dose100');
v_85= importdata('SensitivityAnalysisData/invitro_mu24000_sigma500_DSprob85_DStime3_EC100_gamma200_Tdeath100_Dose100');

no_variations=9;
cal_index=5;

v1=zeros(no_variations,no_data_points);
v2=zeros(no_variations,no_data_points);
dp=0;

for i = 73:73:length(v_cal)
    dp=dp+1;
    v1(1,dp)=v_65(i,col1);
    v1(2,dp)=v_67p5(i,col1);
    v1(3,dp)=v_70(i,col1);
    v1(4,dp)=v_72p5(i,col1);
    v1(5,dp)=v_cal(i,col1);
    v1(6,dp)=v_77p5(i,col1);
    v1(7,dp)=v_80(i,col1); 
    v1(8,dp)=v_82p5(i,col1);
    v1(9,dp)=v_85(i,col1);
    %
    v2(1,dp)=v_65(i,col2);
    v2(2,dp)=v_67p5(i,col2);
    v2(3,dp)=v_70(i,col2);
    v2(4,dp)=v_72p5(i,col2);
    v2(5,dp)=v_cal(i,col2);
    v2(6,dp)=v_77p5(i,col2);
    v2(7,dp)=v_80(i,col2); 
    v2(8,dp)=v_82p5(i,col2);
    v2(9,dp)=v_85(i,col2);
end
% Now all the data is in one matrix
A=zeros(no_variations, 5); 
A(:,1)=[65:2.5:85]'; %first col is parmameter value
for i = 1:no_variations 
    [A(i,2), A(i,3)] = getA_measure( v1(i,:),v1(cal_index,:));%DAMAGE: 2nd col is Ameasur, 3rd is scaled A measure
    [A(i,4), A(i,5)] = getA_measure( v2(i,:),v2(cal_index,:));%CELLCOUNT: 4th col is Ameasur, 5th is scaled A measure
end

%create_RA_plots(A,v1,v2);

%


%%%%%%%%%%%%%%%%%%%%%
%%% Vary Time-DS %%%
%%% Explored sigma values: 0:0.25:2,5 h:
v_1= importdata('SensitivityAnalysisData/invitro_mu24000_sigma500_DSprob75_DStime1_EC100_gamma200_Tdeath100_Dose100');
v_2= importdata('SensitivityAnalysisData/invitro_mu24000_sigma500_DSprob75_DStime2_EC100_gamma200_Tdeath100_Dose100');
v_4= importdata('SensitivityAnalysisData/invitro_mu24000_sigma500_DSprob75_DStime4_EC100_gamma200_Tdeath100_Dose100');
v_5= importdata('SensitivityAnalysisData/invitro_mu24000_sigma500_DSprob75_DStime5_EC100_gamma200_Tdeath100_Dose100');

no_variations=5;
cal_index=3;

v1=zeros(no_variations,no_data_points);
v2=zeros(no_variations,no_data_points);
dp=0;

for i = 73:73:length(v_cal)
    dp=dp+1;
    v1(1,dp)=v_1(i,col1);
    v1(2,dp)=v_2(i,col1);
    v1(3,dp)=v_cal(i,col1);
    v1(4,dp)=v_4(i,col1);
    v1(5,dp)=v_5(i,col1);
    %
    v2(1,dp)=v_1(i,col2);
    v2(2,dp)=v_2(i,col2);
    v2(3,dp)=v_cal(i,col2);
    v2(4,dp)=v_4(i,col2);
    v2(5,dp)=v_5(i,col2);
end
% Now all the data is in one matrix
A=zeros(no_variations, 5); 
A(:,1)=[1:1:5]'; %first col is parmameter value
for i = 1:no_variations 
    [A(i,2), A(i,3)] = getA_measure( v1(i,:),v1(cal_index,:));%DAMAGE: 2nd col is Ameasur, 3rd is scaled A measure
    [A(i,4), A(i,5)] = getA_measure( v2(i,:),v2(cal_index,:));%CELLCOUNT: 4th col is Ameasur, 5th is scaled A measure
end


%create_RA_plots(A,v1,v2);


%%%%%%%%%%%%%%%%%%%%
%%% Vary hill coefficient %%%
%%% Explored sigma values: 0:0.25:2,5 h:
v_1= importdata('SensitivityAnalysisData/invitro_mu24000_sigma500_DSprob75_DStime3_EC100_gamma100_Tdeath100_Dose100');
v_1p25= importdata('SensitivityAnalysisData/invitro_mu24000_sigma500_DSprob75_DStime3_EC100_gamma125_Tdeath100_Dose100');
v_1p5= importdata('SensitivityAnalysisData/invitro_mu24000_sigma500_DSprob75_DStime3_EC100_gamma150_Tdeath100_Dose100');
v_1p75= importdata('SensitivityAnalysisData/invitro_mu24000_sigma500_DSprob75_DStime3_EC100_gamma175_Tdeath100_Dose100');
v_2p25= importdata('SensitivityAnalysisData/invitro_mu24000_sigma500_DSprob75_DStime3_EC100_gamma225_Tdeath100_Dose100');
v_2p5= importdata('SensitivityAnalysisData/invitro_mu24000_sigma500_DSprob75_DStime3_EC100_gamma250_Tdeath100_Dose100');
v_2p75= importdata('SensitivityAnalysisData/invitro_mu24000_sigma500_DSprob75_DStime3_EC100_gamma275_Tdeath100_Dose100');
v_3= importdata('SensitivityAnalysisData/invitro_mu24000_sigma500_DSprob75_DStime3_EC100_gamma300_Tdeath100_Dose100');

no_variations=9;
cal_index=5;

no_data_points=100;
v1=zeros(no_variations,no_data_points);
v2=zeros(no_variations,no_data_points);
dp=0;

for i = 73:73:73*100%length(v_cal)
    dp=dp+1;
    v1(1,dp)=v_1(i,col1);
    v1(2,dp)=v_1p25(i,col1);
    v1(3,dp)=v_1p5(i,col1);
    v1(4,dp)=v_1p75(i,col1);
    v1(5,dp)=v_cal(i,col1);
    v1(6,dp)=v_2p25(i,col1);
    v1(7,dp)=v_2p5(i,col1);
    v1(8,dp)=v_2p75(i,col1);
    v1(9,dp)=v_3(i,col1);  
    %
    v2(1,dp)=v_1(i,col2);
    v2(2,dp)=v_1p25(i,col2);
    v2(3,dp)=v_1p5(i,col2);
    v2(4,dp)=v_1p75(i,col2);
    v2(5,dp)=v_cal(i,col2);
    v2(6,dp)=v_2p25(i,col2);
    v2(7,dp)=v_2p5(i,col2);
    v2(8,dp)=v_2p75(i,col2);
    v2(9,dp)=v_3(i,col2); 
end
% Now all the data is in one matrix
A=zeros(no_variations, 5); 
A(:,1)=[1:0.25:3]'; %first col is parmameter value
for i = 1:no_variations 
    [A(i,2), A(i,3)] = getA_measure( v1(i,:),v1(cal_index,:));%DAMAGE: 2nd col is Ameasur, 3rd is scaled A measure
    [A(i,4), A(i,5)] = getA_measure( v2(i,:),v2(cal_index,:));%CELLCOUNT: 4th col is Ameasur, 5th is scaled A measure
end

%create_RA_plots(A,v1,v2);


%%%%%%%%%%%%%%%%%%%%
%%% Vary EC_50 %%%
%%% Explored ec50: 0.25:0.25:1.75 uM:
v_0p25= importdata('SensitivityAnalysisData/invitro_mu24000_sigma500_DSprob75_DStime3_EC25_gamma200_Tdeath100_Dose100');
v_0p5= importdata('SensitivityAnalysisData/invitro_mu24000_sigma500_DSprob75_DStime3_EC50_gamma200_Tdeath100_Dose100');
v_0p75= importdata('SensitivityAnalysisData/invitro_mu24000_sigma500_DSprob75_DStime3_EC75_gamma200_Tdeath100_Dose100');
v_1p25= importdata('SensitivityAnalysisData/invitro_mu24000_sigma500_DSprob75_DStime3_EC125_gamma200_Tdeath100_Dose100');
v_1p5= importdata('SensitivityAnalysisData/invitro_mu24000_sigma500_DSprob75_DStime3_EC150_gamma200_Tdeath100_Dose100');
v_1p75= importdata('SensitivityAnalysisData/invitro_mu24000_sigma500_DSprob75_DStime3_EC175_gamma200_Tdeath100_Dose100');

no_variations=7;
cal_index=4;

no_data_points=100;
v1=zeros(no_variations,no_data_points);
v2=zeros(no_variations,no_data_points);
dp=0;

for i = 73:73:73*no_data_points
    dp=dp+1;
    v1(1,dp)=v_0p25(i,col1);
    v1(2,dp)=v_0p5(i,col1);
    v1(3,dp)=v_0p75(i,col1);
    v1(4,dp)=v_cal(i,col1);
    v1(5,dp)=v_1p25(i,col1);
    v1(6,dp)=v_1p5(i,col1);
    v1(7,dp)=v_1p75(i,col1);
    %
    v2(1,dp)=v_0p25(i,col2);
    v2(2,dp)=v_0p5(i,col2);
    v2(3,dp)=v_0p75(i,col2);
    v2(4,dp)=v_cal(i,col2);
    v2(5,dp)=v_1p25(i,col2);
    v2(6,dp)=v_1p5(i,col2);
    v2(7,dp)=v_1p75(i,col2);
end
% Now all the data is in one matrix
A=zeros(no_variations, 5); 
A(:,1)=[0.25:0.25:1.75]'; %first col is parmameter value
for i = 1:no_variations 
    [A(i,2), A(i,3)] = getA_measure( v1(i,:),v1(cal_index,:));%DAMAGE: 2nd col is Ameasur, 3rd is scaled A measure
    [A(i,4), A(i,5)] = getA_measure( v2(i,:),v2(cal_index,:));%CELLCOUNT: 4th col is Ameasur, 5th is scaled A measure
end
%create_RA_plots(A,v1,v2);



%%%%%%%%%%%%%%%%%%%%
%%% Vary t_{lethal-death} %%%
%%% Explored sigma values: 0.25:0.25:1.75 h:
v_0 = importdata('SensitivityAnalysisData/invitro_mu24000_sigma500_DSprob75_DStime3_EC100_gamma200_Tdeath0_Dose100');
v_0p25 = importdata('SensitivityAnalysisData/invitro_mu24000_sigma500_DSprob75_DStime3_EC100_gamma200_Tdeath25_Dose100');
v_0p5 = importdata('SensitivityAnalysisData/invitro_mu24000_sigma500_DSprob75_DStime3_EC100_gamma200_Tdeath50_Dose100');
v_0p75 = importdata('SensitivityAnalysisData/invitro_mu24000_sigma500_DSprob75_DStime3_EC100_gamma200_Tdeath75_Dose100');
v_1p25 = importdata('SensitivityAnalysisData/invitro_mu24000_sigma500_DSprob75_DStime3_EC100_gamma200_Tdeath125_Dose100');
v_1p5 = importdata('SensitivityAnalysisData/invitro_mu24000_sigma500_DSprob75_DStime3_EC100_gamma200_Tdeath150_Dose100');
v_1p75 = importdata('SensitivityAnalysisData/invitro_mu24000_sigma500_DSprob75_DStime3_EC100_gamma200_Tdeath175_Dose100');
v_2 = importdata('SensitivityAnalysisData/invitro_mu24000_sigma500_DSprob75_DStime3_EC100_gamma200_Tdeath200_Dose100');

no_variations=9;
cal_index=5;

no_data_points=25;%100;
v1=zeros(no_variations,no_data_points);
v2=zeros(no_variations,no_data_points);
dp=0;

for i = 73:73:73*no_data_points
    dp=dp+1;
    v1(1,dp)=v_0(i,col1);
    v1(2,dp)=v_0p25(i,col1);
    v1(3,dp)=v_0p5(i,col1);
    v1(4,dp)=v_0p75(i,col1);
    v1(5,dp)=v_cal(i,col1);
    v1(6,dp)=v_1p25(i,col1);
    v1(7,dp)=v_1p5(i,col1);
    v1(8,dp)=v_1p75(i,col1);
    v1(9,dp)=v_2(i,col1);
    %
    v2(1,dp)=v_0(i,col2);
    v2(2,dp)=v_0p25(i,col2);
    v2(3,dp)=v_0p5(i,col2);
    v2(4,dp)=v_0p75(i,col2);
    v2(5,dp)=v_cal(i,col2);
    v2(6,dp)=v_1p25(i,col2);
    v2(7,dp)=v_1p5(i,col2);
    v2(8,dp)=v_1p75(i,col2);
    v2(9,dp)=v_2(i,col2);
end
% Now all the data is in one matrix
A=zeros(no_variations, 5); 
A(:,1)=[0:0.25:2]'; %first col is parmameter value
for i = 1:no_variations 
    [A(i,2), A(i,3)] = getA_measure( v1(i,:),v1(cal_index,:));%DAMAGE: 2nd col is Ameasur, 3rd is scaled A measure
    [A(i,4), A(i,5)] = getA_measure( v2(i,:),v2(cal_index,:));%CELLCOUNT: 4th col is Ameasur, 5th is scaled A measure
end
create_RA_plots(A,v1,v2);