function [p_out, a_max]  = create_A_plots(distribution_size, p, data_vectors, no_A_tests)

Data_Point_Matrix1=zeros(no_A_tests, distribution_size);
Data_Point_Matrix2=zeros(no_A_tests, distribution_size);

for row = 1 : no_A_tests
    for col = 1 : distribution_size
        p=p+1;
        Data_Point_Matrix1(row,col) = data_vectors(1,p);
        Data_Point_Matrix2(row,col) = data_vectors(2,p);
    end
end

 
am = zeros(2,no_A_tests);
am_scaled = zeros(2,no_A_tests);
 
for row = 2:no_A_tests
     [A_measure, scaled_A_measure] = getA_measure(Data_Point_Matrix1(1,:), Data_Point_Matrix1(row,:));
     am(1,row)=A_measure;
     am_scaled(1,row)= scaled_A_measure;
     %
     [A_measure, scaled_A_measure] = getA_measure(Data_Point_Matrix2(1,:), Data_Point_Matrix2(row,:));
     am(2,row)=A_measure;
     am_scaled(2,row)= scaled_A_measure;
end



x=1:20;
small=0.56*ones(1,length(x));
medium=0.64*ones(1,length(x));
large=0.71*ones(1,length(x));

figure
set(gcf, 'Position',  [100, 100, 1000, 500])
subplot(2,1,1)
box on
    ax = gca;               % get the current axis
ax.Clipping = 'off'; 
%plot(2:no_A_tests, am(1,2:no_A_tests),'kd-', 2:no_A_tests, am(2,2:no_A_tests),'k*-','LineWidth',1.2);
%legend('\gammaH2AX (%)', 'cell count')
set(gca, 'ColorOrder',[0.1 0.6 0.1; 0.9 0.5 0; 0.8 0 0; 0.1 0.6 0.1; 0.9 0.5 0; 0.8 0 0; 0.1 0.1 0.7; 0 0 0; ...
    0.1 0.6 0.1; 0.9 0.5 0; 0.8 0 0; 0.1 0.1 0.7; 0.0 0.0 0.0],'NextPlot', 'replacechildren');
hold on
myplot=plot(x,small,'--',x,medium,'--',x,large,'--',x,ones(1,length(x))-small,'--',x,ones(1,length(x))-medium,'--',x,ones(1,length(x))-large,'--',...
    2:no_A_tests, am(1,2:no_A_tests),'o-', 2:no_A_tests, am(2,2:no_A_tests),'*-','LineWidth',1.2,'MarkerSize',11);
rect = [0.9, 0.75, .15, .1];
legend([myplot(7) myplot(8)],'\gammaH2AX','cell count','Location','NorthEastOutside')   
ylim([0 1]);
xlim([1 no_A_tests]);
set(gca,'YTick',[0, 1-0.71, 1-0.64, 1-0.56, 0.56, 0.64, 0.71, 1]);
title({'Â-values for distribution size n=',distribution_size});
ylabel('Â^{n}_{1,k''}','FontSize', 14);
xlabel('k'' ','FontSize', 14);
set(gca, 'YTick', []);
    yyaxis right
    set(gca, 'YTick', [0.29, 0.36, 0.44 ,0.56,0.64,0.71],'Ycolor','black');

subplot(2,1,2)
box on
    ax = gca;               % get the current axis
ax.Clipping = 'off'; 
%myplot2=plot(2:no_A_tests, am_scaled(1,2:no_A_tests),'kd-', 2:no_A_tests, am_scaled(2,2:no_A_tests),'k*-','LineWidth',1.2);
%legend('\gamma H2AX (%)', 'cell count')
set(gca, 'ColorOrder',[0.1 0.6 0.1; 0.9 0.5 0; 0.8 0 0; 0.1 0.1 0.7; 0.0 0.0 0.0],'NextPlot', 'replacechildren');
hold on
myplot2=plot(x,small,'--',x,medium,'--',x,large,'--',2:no_A_tests, am_scaled(1,2:no_A_tests),'o-', 2:no_A_tests, am_scaled(2,2:no_A_tests),'*-','LineWidth',1.2,'MarkerSize',11);
rect = [0.9, 0.4, .15, .1];
legend([myplot2(4) myplot2(5)],'\gammaH2AX','cell count','Location','NorthEastOutside')   
ylim([0.5 1]);
ylabel('Scaled Â^{n}_{1,k'' }','FontSize', 14);
set(gca, 'YTick', []);
    yyaxis right
    set(gca, 'YTick', [2*(small(1)-0.5),2*(medium(1)-0.5),2*(large(1)-0.5)],'Ycolor','black','YTickLabel',{'0.56','0.64','0.71'});
xlim([1 no_A_tests]);
title({'Scaled Â-values for distribution size n=',distribution_size});

xlabel('k'' ','FontSize', 14);

%title('Size 'distribution_size);

% 
% figure
% subplot(2,1,1)
% plot(2:no_A_tests, am(2,2:no_A_tests),'k*-','LineWidth',1.2);
% legend('\gammaH2AX (%)', 'cell count')
% set(gca, 'ColorOrder',[0.1 0.6 0.1; 0.9 0.5 0; 0.8 0 0; 0.1 0.6 0.1; 0.9 0.5 0; 0.8 0 0],'NextPlot', 'replacechildren');
% hold on
% plot(x,small,'--',x,medium,'--',x,large,'--',x,ones(1,100)-small,'--',x,ones(1,100)-medium,'--',x,ones(1,100)-large,'--','LineWidth',1.2);
% ylim([0 1]);
% xlim([1 no_A_tests]);
% set(gca,'YTick',[0, 1-0.71, 1-0.64, 1-0.56, 0.56, 0.64, 0.71, 1]);
% title({'A-values for Distribution Size ',distribution_size});
% ylabel('A^{n}_{1,k''}(X)','FontSize', 14);
% xlabel('k'' ','FontSize', 14);
% subplot(2,1,2)
% plot(2:no_A_tests, am_scaled(2,2:no_A_tests),'k*-','LineWidth',1.2);
% %legend('')
% set(gca, 'ColorOrder',[0.1 0.6 0.1; 0.9 0.5 0; 0.8 0 0; 0.0 0.0 0.0;  0.0 0.0 0.0],'NextPlot', 'replacechildren');
% hold on
% plot(x,small,'--',x,medium,'--',x,large,'--','LineWidth',1.2);
% ylim([0.5 1]);
% xlim([1 no_A_tests]);
% title({'Scaled A-values for Distribution Size ',distribution_size});
% ylabel('A^{n}_{1,k'' }(X)','FontSize', 14);
% xlabel('k'' ','FontSize', 14);
% %title('Size 'distribution_size);

p_out=p;
a_max=[max(am_scaled(1,:)), max(am_scaled(2,:))]; %A_measure_temp;

end