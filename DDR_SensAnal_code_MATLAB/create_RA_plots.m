function create_RA_plots(A,v1,v2)

    %A(:,1)=0.01* A(:,1);
    %A(:,3)=0.01* A(:,3);
    % A measure fig (damage and cell count)
    %x=[65 85];
    %x=[0.25 1.75];
    x=[22 26];
    small=0.56*ones(1,length(x));
    medium=0.64*ones(1,length(x));
    large=0.71*ones(1,length(x));
    figure
    box on
    ax = gca;               % get the current axis
    ax.Clipping = 'off'; 
    %plot(A(:,1), A(:,2),'kd-', A(:,1), A(:,4),'k*-','LineWidth',1.2);
%     legend('\gammaH2AX (%)', 'cell count');
%     hold on
    set(gca, 'ColorOrder',[0.1 0.6 0.1; 0.9 0.5 0; 0.8 0 0; 0.1 0.6 0.1; 0.9 0.5 0; 0.8 0 0; 0.1 0.1 0.7; 0 0 0; 0.3 0.4 0.5],'NextPlot', 'replacechildren');
    hold on
    p=plot(x,small,'--',x,medium,'--',x,large,'--',x,ones(1,2)-small,'--',x,ones(1,2)-medium,'--',x,ones(1,2)-large,'--',...
        A(:,1), A(:,2),'o-',A(:,1), A(:,4),'*-','LineWidth',1.2,'MarkerSize',11);
   %plot(x,small,'--',x,medium,'--',x,large,'--',x,ones(1,100)-small,'--',x,ones(1,100)-medium,'--',x,ones(1,100)-large,'--',A(:,1), A(:,4),'*-','LineWidth',1.2);   
    hold on
    rect = [0.72, 0.2, .15, .1];
%set(h, 'Position', rect)
    legend([p(7) p(8)],'\gammaH2AX','cell count','Location',rect)
    xlim([A(1,1), A(end,1)])
    ylim([0,1])
    ylabel('Â-value','FontSize', 14);
    set(gca, 'YTick', []);
    yyaxis right
    set(gca, 'YTick', [0.29, 0.36, 0.44 ,0.56,0.64,0.71]);
    %xlabel('\Pi_{D-S} (%)','FontSize', 14);
    %xlabel('\gamma','FontSize', 14);
    %xlabel('EC_{50} (\muM)','FontSize', 14);
    %xlabel('\Theta_{D-S}','FontSize', 14);
    %xticks([0.25 0.75 1 1.25 1.75]);
    %xticks([22:1:26]);
    %set(gca, 'XTickLabels', {'.01','.02','.03','.04','.05'});
    xlabel('T_{D \rightarrow L} (doubling times)','FontSize', 14);
    
    % Boxplot figs  (damage and cell count)
    figure
    subplot(1,2,1);
    %boxplot(v1', 'Labels',{'22','','23','','24','','25','','26'});
    %boxplot(v1', 'Labels',{'0','','0.5','','1','','1.5','','2', '', '2.5'});
    %boxplot(v1', 'Labels',{'65','','70','','75','','80','','85'});%pids
    %boxplot(v1', 'Labels',{'.01','.02','.03','.04','.05'});
    %boxplot(v1', 'Labels',{'1','','1.5', '','2','','2.5','','3'});%gamma
    %boxplot(v1', 'Labels',{'0.25','','0.75','', '1.25','','1.75'});%ec50
    boxplot(v1', 'Labels',{'0','','0.5','','1', '', '1.5','','2'});
    
    %title('Output (Damaged) as a result of alterations of \gamma','FontSize', 14 );
    ylabel('\gammaH2AX (%)','FontSize', 14);
    %xlabel('\Pi_{D-S} (%)','FontSize', 14);
    %xlabel('\gamma','FontSize', 14);
    %xlabel('EC_{50} (\muM)','FontSize', 14);
     xlabel('T_{D \rightarrow L} (doubling times)','FontSize', 14);
     %xlabel('\Theta_{D-S}','FontSize', 14);
    
    subplot(1,2,2);
    %boxplot(v2', 'Labels',{'22','','23','','24','','25','','26'});    
    %boxplot(v2', 'Labels',{'0','','0.5','','1','','1.5','','2', '', '2.5'});
    %boxplot(v2', 'Labels',{'65',' ','70','','75','','80','','85'});%pids
   % boxplot(v2', 'Labels',{'.01','.02','.03','.04','.05'});
    %boxplot(v2', 'Labels',{'1','','1.5', '','2','','2.5','','3'});%gamma
   % boxplot(v2', 'Labels',{'0.25','','0.75','', '1.25','','1.75'});%ec50
    boxplot(v2', 'Labels',{'0','','0.5','','1', '', '1.5','','2'});
    
    %title('Output (Cell count) as a result of alterations of \gamma','FontSize', 14 );
    ylabel('cell count','FontSize', 14);
%     xlabel('\Pi_{D-S} (%)','FontSize', 14);
   % xlabel('\gamma','FontSize', 14);
    %xlabel('EC_{50} (\muM)','FontSize', 14);
    xlabel('T_{D \rightarrow L} (doubling times)','FontSize', 14);
    %xlabel('\Theta_{D-S}','FontSize', 14);
    
    %suptitle('Output responses to perturbations of \Pi_{D-S}}')'%T_{D \rightarrow L}' );
end
