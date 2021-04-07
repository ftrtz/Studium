addpath('Q:/Toolboxes/eeglab');
eeglab

addpath('Q:/EEG-Modul_WS1819/AllgemeineSkripte/readamplitudes/')
% Zeitfenster [von bis], Kan�le, Bedingungen und Dateien definieren
cfg.win = [120 160];
cfg.channels = {'Fz'; 'Cz'; 'M1'; 'M2'};
cfg.conditionnames = {'aversive'; 'neutral'};
for cond = 1:length(cfg.conditionnames)
    cfg.gavrfilenames{cond,1} = ['gavr_DW_' cfg.conditionnames{cond} '_r100.set'];
end
cfg.gavrpath = 'Q:/EEG-Modul_WS1819/User/FabianTreitz/Gavr/';
cfg.outfile = 'Q:/EEG-Modul_WS1819/User/FabianTreitz/Gavr/MMNamplituden.txt';

res = readamplitudes(cfg);
