addpath('Q:/Toolboxes/eeglab');
eeglab
% Funktion in den Pfad einbinden
addpath('Q:/EEG-Modul_WS1819/AllgemeineSkripte/grandaverage1.1/')
% Ordner mit Epochen definieren
path_epochs = 'Q:/EEG-Modul_WS1819/User/FabianTreitz/Epochen/';
path_gavr = 'Q:/EEG-Modul_WS1819/User/FabianTreitz/Gavr/';

alltrigger = {{'1'}; {'2' '3' '4'}; {'12' '13' '14'}};
alltriggernames = {'standard'; 'aversive'; 'neutral'};

allVP = [1 2 3 4 5 6 7 8];

for cond = 1:length(alltrigger)
    for currentVP = allVP
        vpName = ['vp' num2str(currentVP, '%0.2d')];
        epochnames{1,currentVP} =  [ vpName alltriggernames{cond} 'r100.set'];
    end


    EEG = pop_grandaverage( epochnames, 'pathname', path_epochs);
    EEG = pop_editset(EEG,'setname', ['GAVR ' alltriggernames{cond}]); %Datensatz benennen
    % Grand-Average abspeichern
    EEG = pop_saveset( EEG, 'filename',['gavr_' alltriggernames{cond} '_r100.set'],'filepath',path_gavr);

end
