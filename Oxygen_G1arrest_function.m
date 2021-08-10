close all

xvec=[1.0000    2.5000    5.0000   9.0000  25.000   50.00   100.00]';
yvec=[2.0000    1.2775    1.1108    1.0000  1.000 1.0   1.0]';
x=1:0.1:10.6;
x2=[10.6 100];
y2=[1 1];

%f1=@(oxy)1+1./((1*oxy).^2);
%f105=@(oxy)1.1+1./((1.05*oxy).^2);


%x,f1(x),x,f105(x));
hyprb = @(b,xvec) b(1) + b(2)./(xvec + b(3)); % Generalised Hyperbola
NRCF = @(b) norm(yvec - hyprb(b,xvec)); % Residual Norm Cost Function
B0 = [1; 1; 1];
B = fminsearch(NRCF, B0); % Estimate Parameters
%plot(xvec, yvec, 'pg')
%hold on
%plot(xvec, hyprb(B,xvec), '-r')
%hold off
%grid
%text(0.7, 0.52, sprintf('yvec = %.4f %+.4f/(xvec %+.4f)', B));

%figure
bestfitrecthyp=@(x) 0.9209+0.8200./(x-0.2398);
figure
f=plot(x,bestfitrecthyp(x) );
%f=fplot(@(x) OMF(x) ,[0 100], 'r')
f.LineWidth = 2;
f.Color=[0.4 0.3 0.3];
hold on
f=plot(x2,y2);
f.LineWidth = 2;
f.Color=[0.4 0.3 0.3];
title('G1 Delay Factor (G1DF)')
ylabel('G1DF','FontSize', 24);
xlabel('pO_2 (mmHg)','FontSize', 24);
xlim([0,100]);
ylim([0,3]);
set(gca,'XTick',[0:10:100]);
set(gca,'YTick',[0:0.5:2]);
set(gca,'fontsize',14);
hold on
plot(xvec,yvec,'xr','LineWidth',2);
