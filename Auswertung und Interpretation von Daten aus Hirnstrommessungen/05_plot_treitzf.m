addpath('Q:/Toolboxes/eeglab');
eeglab

path_gavr = 'Q:/EEG-Modul_WS1819/User/FabianTreitz/Gavr/';

alltrigger = {{'1'}; {'2' '3' '4'}; {'12' '13' '14'}};
alltriggernames = {'standard'; 'aversive'; 'neutral'; 'aversive'; 'neutral'};

for cond = 1:3
    EEG = pop_loadset('filename',['gavr_' alltriggernames{cond} '_r100.set'],'filepath',path_gavr);
        alldata(cond,:,:,:) = EEG.data;
end

for cond = 4:5
    EEG = pop_loadset('filename',['gavr_DW_' alltriggernames{cond} '_r100.set'],'filepath',path_gavr);
    alldata(cond,:,:,:) = EEG.data;
end

%%  EKPs: Neutral, Standard und Neutral - Standard an Fz

figure;set(gcf,'color','w');
rectangle('Position',[120,-4.95,40,9.9], 'facecolor', [.9 .9 .9], 'LineStyle','none')
hold on;
plot(EEG.times, squeeze(mean(alldata(1,31,:,:),4)),'k','LineStyle','-','Linewidth',2);
hold on;
plot(EEG.times, squeeze(mean(alldata(3,31,:,:),4)),'r','LineStyle','-','Linewidth',2);
hold on;
plot(EEG.times, squeeze(mean(alldata(5,31,:,:),4)),'color',[.5 .5 .5],'LineStyle','--', 'Linewidth',2);
set(gca,'YDir', 'Reverse');
ylim([-5 5])
vv = get(gca,'YLim');  %Get Range of Ydata
vl = line([0 0],vv,'Color', 'k'); % plot a vertical line
hh = get(gca,'XLim');  %Get Range of Ydata
hl = line(hh,[0 0],'Color', 'k'); % plot a vertical line
text(-80,-4.5,'Fz')
title(['EKPs für Neutral, Standard und Neutral - Standard'])
xlabel('Zeit (ms)');
ylabel('Amplitude (ÂµV)');
set(gca,'FontName','Arial','FontSize',12);
legend('Standard', 'Neutral', 'Neutral - Standard')

%%   An Fz: DEVav vs. STA + DiffW  

figure;set(gcf,'color','w');
rectangle('Position',[120,-4.95,40,9.9], 'facecolor', [.9 .9 .9], 'LineStyle','none')
hold on;
plot(EEG.times, squeeze(mean(alldata(1,31,:,:),4)),'k','LineStyle','-','Linewidth',2);
hold on;
plot(EEG.times, squeeze(mean(alldata(2,31,:,:),4)),'r','LineStyle','-','Linewidth',2);
hold on;
plot(EEG.times, squeeze(mean(alldata(4,31,:,:),4)),'color',[.5 .5 .5],'LineStyle','--', 'Linewidth',2);
set(gca,'YDir', 'Reverse');
ylim([-5 5])
vv = get(gca,'YLim');  %Get Range of Ydata
vl = line([0 0],vv,'Color', 'k'); % plot a vertical line
hh = get(gca,'XLim');  %Get Range of Ydata
hl = line(hh,[0 0],'Color', 'k'); % plot a vertical line
text(-80,-4.5,'Fz')
title(['EKPs für Aversiv, Standard und Aversiv - Standard'])
xlabel('Zeit (ms)');
ylabel('Amplitude (ÂµV)');
set(gca,'FontName','Arial','FontSize',12);
legend('Standard', 'Aversiv', 'Aversiv - Standard')

%%   An M1: DEVneu vs. STA + DiffW  

figure;set(gcf,'color','w');
rectangle('Position',[120,-4.95,40,9.9], 'facecolor', [.9 .9 .9], 'LineStyle','none')
hold on;
plot(EEG.times, squeeze(mean(alldata(1,35,:,:),4)),'k','LineStyle','-','Linewidth',2);
hold on;
plot(EEG.times, squeeze(mean(alldata(3,35,:,:),4)),'r','LineStyle','-','Linewidth',2);
hold on;
plot(EEG.times, squeeze(mean(alldata(5,35,:,:),4)),'color',[.5 .5 .5],'LineStyle','--', 'Linewidth',2);
set(gca,'YDir', 'Reverse');
ylim([-5 5])
vv = get(gca,'YLim');  %Get Range of Ydata
vl = line([0 0],vv,'Color', 'k'); % plot a vertical line
hh = get(gca,'XLim');  %Get Range of Ydata
hl = line(hh,[0 0],'Color', 'k'); % plot a vertical line
text(-80,-4.5,'M1')
title(['EKPs für Neutral, Standard und Neutral - Standard'])
xlabel('Zeit (ms)');
ylabel('Amplitude (ÂµV)');
set(gca,'FontName','Arial','FontSize',12);
legend('Standard', 'Neutral', 'Neutral - Standard')

%%   An M1: DEVav vs. STA + DiffW  

figure;set(gcf,'color','w');
rectangle('Position',[120,-4.95,40,9.9], 'facecolor', [.9 .9 .9], 'LineStyle','none')
hold on;
plot(EEG.times, squeeze(mean(alldata(1,35,:,:),4)),'k','LineStyle','-','Linewidth',2);
hold on;
plot(EEG.times, squeeze(mean(alldata(2,35,:,:),4)),'r','LineStyle','-','Linewidth',2);
hold on;
plot(EEG.times, squeeze(mean(alldata(4,35,:,:),4)),'color',[.5 .5 .5],'LineStyle','--', 'Linewidth',2);
set(gca,'YDir', 'Reverse');
ylim([-5 5])
vv = get(gca,'YLim');  %Get Range of Ydata
vl = line([0 0],vv,'Color', 'k'); % plot a vertical line
hh = get(gca,'XLim');  %Get Range of Ydata
hl = line(hh,[0 0],'Color', 'k'); % plot a vertical line
text(-80,-4.5,'M1')
title(['EKPs für Aversiv, Standard und Aversiv - Standard'])
xlabel('Zeit (ms)');
ylabel('Amplitude (ÂµV)');
set(gca,'FontName','Arial','FontSize',12);
legend('Standard', 'Aversiv', 'Aversiv - Standard')

%% Gavr-Differenzkuven für die 2 Bedingungen (an Fz)

figure;set(gcf,'color','w');
rectangle('Position',[120,-4.95,40,9.9], 'facecolor', [.9 .9 .9], 'LineStyle','none')
hold on;
plot(EEG.times, squeeze(mean(alldata(4,31,:,:),4)),'r','Linewidth',2);
hold on;
plot(EEG.times, squeeze(mean(alldata(5,31,:,:),4)),'color', [0 .5 0],'Linewidth',2);
set(gca,'YDir', 'Reverse');
ylim([-5 5])
vv = get(gca,'YLim');  %Get Range of Ydata
vl = line([0 0],vv,'Color', 'black'); % plot a vertical line
hh = get(gca,'XLim');  %Get Range of Ydata
hl = line(hh,[0 0],'Color', 'black'); % plot a vertical line
text(-80,-4.5,'Fz')
title(['Differenzkurven für Aversiv und Neutral'])
xlabel('Zeit (ms)');
ylabel('Amplitude (ÂµV)');
set(gca,'FontName','Arial','FontSize',12);
legend('Aversiv', 'Neutral')

%% Gavr-Differenzkuven für die 2 Bedingungen (an M1)

figure;set(gcf,'color','w');
rectangle('Position',[120,-4.95,40,9.9], 'facecolor', [.9 .9 .9], 'LineStyle','none')
hold on;
plot(EEG.times, squeeze(mean(alldata(4,35,:,:),4)),'r','Linewidth',2);
hold on;
plot(EEG.times, squeeze(mean(alldata(5,35,:,:),4)),'color', [0 .5 0],'Linewidth',2);
set(gca,'YDir', 'Reverse');
ylim([-5 5])
vv = get(gca,'YLim');  %Get Range of Ydata
vl = line([0 0],vv,'Color', 'black'); % plot a vertical line
hh = get(gca,'XLim');  %Get Range of Ydata
hl = line(hh,[0 0],'Color', 'black'); % plot a vertical line
text(-80,-4.5,'M1')
title(['Differenzkurven für Aversiv und Neutral'])
xlabel('Zeit (ms)');
ylabel('Amplitude (ÂµV)');
set(gca,'FontName','Arial','FontSize',12);
legend('Aversiv', 'Neutral')


