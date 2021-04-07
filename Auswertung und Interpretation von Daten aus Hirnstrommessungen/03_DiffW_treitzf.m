addpath('Q:/Toolboxes/eeglab');
eeglab
% Funktion zum Pfad zuf�gen
addpath('Q:/EEG-Modul_WS1819/AllgemeineSkripte/diffwave/')

% Ordner mit Grand-Average-Dateien definieren
path_gavr = 'Q:/EEG-Modul_WS1819/User/FabianTreitz/Gavr/';

alltrigger = {{'1'}; {'2' '3' '4'}; {'12' '13' '14'}};
alltriggernames = {'standard'; 'aversive'; 'neutral'};

allVP = [1 2 3 4 5 6 7 8];


for cond = 1:2
    sta = ['gavr_' alltriggernames{1} '_r100.set'];
    dev = ['gavr_' alltriggernames{cond+1} '_r100.set'];
    % Datensaetze, die zu subtrahieren sind einladen und subtrahieren
    EEG = pop_diffwave({dev, sta},'pathname', path_gavr);
    % neuen Datensatz benennen
    EEG = pop_editset(EEG,'setname', ['DW ' alltriggernames{cond+1} ]);
    % Datensatz mit Differenzkurve abspeichern
    EEG = pop_saveset( EEG, 'filename',['gavr_DW_' alltriggernames{cond+1} '_r100.set'],'filepath',path_gavr);
end

