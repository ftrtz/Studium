addpath('Q:/Toolboxes/eeglab');
eeglab
%% Parameter definieren
path_rawdata = 'Q:/EEG-Modul_WS1819/Daten/';
path_epochs = 'Q:/EEG-Modul_WS1819/User/FabianTreitz/Epochen/';
ref_channel = 39;
excl_channels = {'EXG8' 'GSR1' 'GSR2' 'Erg1' 'Erg2' 'Resp' 'Plet' 'Temp'};
hp_crit = 0.5;
lp_crit = 30;
epoch_length = [-0.1 0.6];
bsl_length = [-99.6094 0];
sta_trigger = { '1' };
dev_trigger = { '2' '3' '4' '12' '13' '14' };

alltrigger = {{'1'}; {'2' '3' '4'}; {'12' '13' '14'}};
alltriggernames = {'standard'; 'aversive'; 'neutral'};

rej_crit = 100;
allVP = [1 2 3 4 5 6 7 8];
for currentVP = allVP
    
    vpName = ['vp' num2str(currentVP, '%0.2d')];
    
    % Einladen der Daten für VP08 
    EEG = pop_biosig([path_rawdata vpName '.bdf'], 'ref',ref_channel);
    EEG = eeg_checkset( EEG );
    
    if currentVP == 5
        EEGa = pop_biosig([path_rawdata vpName '.bdf'], 'ref',ref_channel);
        EEGa = eeg_checkset( EEGa );
        EEGb = pop_biosig([path_rawdata vpName 'b.bdf'], 'ref',ref_channel);
        EEGb = eeg_checkset( EEGb );
        EEG = pop_mergeset(EEGa, EEGb);
        clear EEGa EEGb
    end
    
    % Entfernen der leeren Kanäle 
    EEG = pop_select( EEG,'nochannel', excl_channels);
    EEG = eeg_checkset( EEG );
    % Bipolarisieren des VEOG-Kanals (SO2 - IO2)
    EEG = pop_reref( EEG, 35,'exclude',[1:34 37 38:39] );
    EEG = eeg_checkset( EEG );
    % Bipolarisieren des HEOG-Kanals (LO2 - L01)
    EEG = pop_reref( EEG, 33,'exclude',[1:32 35 36:38] );
    % Einladen der Elektrodenpositionen und Umbenennen der Kanäle
    EEG = pop_chanedit(EEG, 'lookup','Q:/Toolboxes/eeglab/plugins/dipfit2.3/standard_BESA/standard-10-5-cap385.elp','changefield',{34 'labels' 'VEOG'},'changefield',{33 'labels' 'HEOG'});
    % Hochpassfiltern der Daten 
    EEG = pop_firws(EEG, 'fcutoff', hp_crit, 'ftype', 'highpass', 'wtype', 'blackman', 'forder', 2816, 'minphase', 0);
    % Tiefpassfiltern der Daten 
    EEG = pop_firws(EEG, 'fcutoff', lp_crit, 'ftype', 'lowpass', 'wtype', 'blackman', 'forder', 564, 'minphase', 0);
    EEG = eeg_checkset( EEG );
    
    for cond = 1:length(alltrigger)
        EEGepoch = pop_epoch( EEG, alltrigger{cond}, epoch_length, 'newname', [ vpName 'f ' alltriggernames{cond}], 'epochinfo', 'yes');
        EEGepoch = eeg_checkset( EEGepoch );
        % Baseline-Korrektur der Epochen
        EEGepoch = pop_rmbase( EEGepoch, bsl_length);
        EEGepoch = eeg_checkset( EEGepoch );
        nTrials(currentVP, cond) = size(EEGepoch.data,3);
        % Artefaktzurückweisung für die Epochen
        EEGepoch = pop_eegthresh(EEGepoch,1,[1:37] ,-rej_crit,rej_crit,EEGepoch.xmin,EEGepoch.xmax,0,1);
        EEGepoch = eeg_checkset( EEGepoch );
        nTrials2(currentVP, cond) = size(EEGepoch.data,3);
        EEGepoch = pop_editset(EEGepoch, 'setname', [ vpName 'f' alltriggernames{cond} ' bsl_rej100']);
        % Speichern des Datensatzes mit den Epochen
        EEGepoch = pop_saveset( EEGepoch, 'filename',[ vpName alltriggernames{cond} 'r100.set'],'filepath',path_epochs);
    end
   
end

save ntrials.mat nTrials nTrials2
