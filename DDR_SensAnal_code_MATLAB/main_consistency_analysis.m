% %1: time
% %2:(sd+termina)[% of cycling], 3:(sd+terminal)[% of all]
% %4:g1+s+sd+g2m 5:(3)+g0 6:(4)+terminal 
% %7:g1, 8:s, 9:sd, 10:g2m, 11:g0, 12:dead

close all;
clear all;

%%%%Consistency Analysis
data_in = importdata('SensitivityAnalysisData/invitro_mu24000_sigma500_DSprob75_DStime3_EC100_gamma200_Tdeath100_Dose100');
l=length(data_in)/73;%((1+5+50+100)*20)-(length(data_in)/73);
v_in=data_in(1:7400*73, :);%1320

no_timesteps = 73;
no_data_points=length(v_in)/no_timesteps;
no_data_cols = 12;
col1 = 2;
col2 = 6; %2,6
no_output_measurments = 2; %col1 2 and col6 from input matrix
v=zeros(no_output_measurments,no_data_points);

%Put all the end-time cellcount datapoints in vector v
dp=0; %"data point"
for i = 73:73:length(v_in)
    dp=dp+1;
    v(1,dp)=v_in(i,col1);
    v(2,dp)=v_in(i,col2);
end
% Now all the data is in one vector 
p=0;
no_A_tests=20;
[p, a200]  = create_A_plots(200, p, v, no_A_tests);
[p, a100]  = create_A_plots(100, p, v, no_A_tests);
[p, a50]  = create_A_plots(50, p, v, no_A_tests);
[p, a5]  = create_A_plots(5, p, v, no_A_tests);
[p, a1]  = create_A_plots(1, p+5, v, no_A_tests);
[p, a300]  = create_A_plots(300, 600, v, no_A_tests);
% 
a=[a1;a5;a50;a100;a300];
g=[1 5 50 100 300];
x=1:300;
small=0.56*ones(1,length(x));
medium=0.64*ones(1,length(x));
large=0.71*ones(1,length(x));
figure
set(gcf, 'Position',  [100, 100, 1200, 500])
box on
    ax = gca;               % get the current axis
ax.Clipping = 'off'; 
%plot(g,a(:,1),'kd-','LineWidth',1.2);
%hold on
%plot(g, a(:,1),'o-',g, a(:,2),'k*-','LineWidth',1.2);

legend('\gammaH2AX (%)', 'cell count')
set(gca, 'ColorOrder',[0.1 0.6 0.1; 0.9 0.5 0; 0.8 0 0; 0.1 0.1 0.7; 0 0 0],'NextPlot', 'replacechildren');
hold on
myplot=plot(x,small,'--',x,medium,'--',x,large,'--',g, a(:,1),'o-',g, a(:,2),'*-','LineWidth',1.2,'MarkerSize',11);
legend([myplot(4) myplot(5)],'\gammaH2AX','cell count','Location','NorthEast')   
% hold on
% plot(x,small,'--',x,medium,'--',x,large,'--',g, a(:,2),'*-','LineWidth',1.2);

xlim([0,300])
ylim([0.5,1])
title('Maximal scaled Â-values for various distribution sizes ','FontSize', 12 );
ylabel('max(scaled Â^n_{1,k''})','FontSize', 14);
xlabel('distribution size (n)','FontSize', 14);
   set(gca, 'XTick', [1, 5, 50, 100, 300])%,'Ycolor','black');
   set(gca, 'YTick', []);
    yyaxis right
    set(gca, 'YTick', [2*(small(1)-0.5),2*(medium(1)-0.5),2*(large(1)-0.5)],'Ycolor','black','YTickLabel',{'0.56','0.64','0.71'});
