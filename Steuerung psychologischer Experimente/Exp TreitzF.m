run("V:\Aufgaben\BioCog\Toolboxes\ptb_setup.m")

% VP-Nummer eintragen
vp = 99;

% Vorbereitung der Texte
Fixation = '+';
Welcome = ['Herzlich Willkommen!'];
Instruktion = ['Im Folgenden Experiment hören und lesen Sie gleichzeitig verschiedene Wörter.\n'...
    '\n'...
    'Drücken Sie jedes mal die linke Maustaste, wenn das Wort, das Sie sehen, oder hören (oder\n' ...
    '\n'...
    'beide Wörter) zur Kategorie "Tiere" gehört.'];
Beginnen = ['Drücken Sie nun eine beliebige Taste auf der Tastatur, um mit dem Experiment zu beginnen.'];
Fortfahren = ['Drücken Sie nun eine beliebige Taste auf der Tastatur, um fortzufahren.'];
Feedback = ['Feedback'];
Abschied = ['Vielen Dank für Ihre Teilnahme!'];
Ende = ['Drücken Sie nun eine beliebige Taste auf der Tastatur, um mit das Experiment zu beenden.'];

% Bildschirm definieren
bkgr_col = [255 255 255];
Screen('Preference','SkipSyncTests',1);
Screen('Preference','ConserveVRAM',64);

% Wortlisten einlesen
visTargets = {'Kuh' 'Schwein' 'Schaf' 'Huhn' 'Wolf' 'Hund' 'Hai' 'Wal' 'Frosch' 'Maus'};
visFillers = {'Mund' 'Hand' 'Arm' 'Schrank' 'Stuhl' 'Tisch' 'Schal' 'Rock' 'Kleid' 'Schuh' 'Kohl' 'Hut' 'Helm' 'Glas' 'Bier' 'Brot' 'Buch' 'Fass' 'Keks' 'Korb' 'Pfeil' 'Ring' 'Schlauch' 'Schwert' 'Speer' 'Wein' 'Burg' 'Dach' 'Tür' 'Blitz' 'Axt' 'Herd' 'Berg' 'Feld' 'Meer' 'Zug'};
allWords = [visTargets visFillers]; % Vektor mit allen visuellen Stimuluswörtern

% Sounddateien einlesen
audTargets = cell(length(visTargets),1);
audFillers = cell(length(visFillers),1);
for iTarget = 1:length(visTargets)  % for-Schleife, die zu jedem Wort aus der (Target-) Wortliste die zugehörige Audiodatei einliest
    iFilename = ['Q:\StPsychExp_SoSe18\Users\FabianTreitz\Exp\Audio2\',visTargets{iTarget},'.wav'];
    [y, sr] = audioread(iFilename);
    audTargets{iTarget} = y;
end
for iFiller = 1:length(visFillers)
    iFilename = ['Q:\StPsychExp_SoSe18\Users\FabianTreitz\Exp\Audio2\',visFillers{iFiller},'.wav'];
    [y, sr] = audioread(iFilename);
    audFillers{iFiller} = y;
end
allSounds = [audTargets; audFillers];    % Vektor mit allen auditiven Stimuluswörtern

% Randomisierung der Bedingungen
    % Es gibt 5 Bedingungen:
    % 1 = ohne Target (25% der Trials)
    % 2 = nur visuelles Target (25% der Trials)
    % 3 = nur auditives Target (25% der Trials)
    % 4 = bimodales Target mit unterschiedlichen Wörtern (12,5% der Trials)
    % 5 = bimodales Target mit gleichen Wörtern (12,5% der Trials)
nTrials = 80; % Anzahl Trials (Mindestanzahl 8 -> ca. 30 Sek für Experiment; 80 Trials -> 5min)
Conditions = [1,1,2,2,3,3,4,5];
allConditions = repmat(Conditions, [1 nTrials/8]); % Vektor, der alle Bedingungen in der gewünschten Häufigkeit enthält
randConditions = allConditions(randperm(nTrials)); % innerhalb des davor definierten Vektors werden die Bedingungen randomisiert
    % for-Schleife, mit der der jeweiligen Bedingung aus randConditions die Position des jeweiligen
    % passenden visuellen und auditiven Stimulus in den Wortlisten zugewiesen wird
for iTrial = 1:nTrials;
    if randConditions(1,iTrial) == 1;
        randConditions(2,iTrial) = randi(length(visFillers)) +10;
        randConditions(3,iTrial) = randi(length(audFillers)) +10;
    elseif randConditions(1,iTrial) == 2;
        randConditions(2,iTrial) = randi(length(visTargets));
        randConditions(3,iTrial) = randi(length(audFillers)) +10;
    elseif randConditions(1,iTrial) == 3;
        randConditions(2,iTrial) = randi(length(visFillers)) + 10;
        randConditions(3,iTrial) = randi(length(audTargets));
    elseif randConditions(1,iTrial) == 4;
        randConditions(2,iTrial) = randi(length(visTargets));
        randConditions(3,iTrial) = randConditions(2,iTrial);
    elseif randConditions(1,iTrial) == 5;
        same = 1;
        while same == 1;
            randConditions(2,iTrial) = randi(length(visTargets));
            randConditions(3,iTrial) = randi(length(audTargets));
            if randConditions(2,iTrial) ~= randConditions(3,iTrial);
                same = 0;
            end
        end
    end
end

% Soundkarte aktivieren
InitializePsychSound(1);


% START DES EXPERIMENTS
[window windowSize] = Screen('OpenWindow',0, bkgr_col);

% Willkommensbildschirm & Instruktion
sy = 200;
Screen('TextSize', window, 60 );
DrawFormattedText(window, Welcome, 'center', sy, 0);
Screen('TextSize', window, 30 );
DrawFormattedText(window, Instruktion, 'center', 'center', 0);
sy = 800;
Screen('TextSize', window, 20 );
DrawFormattedText(window, Beginnen, 'center', sy, 0);
Screen('Flip',window);
KbStrokeWait;
Screen('TextSize', window, 50 );

% Durchlauf der Trials
for iTrials = 1:nTrials;
% Parameter für auditiven Input
    nrchannels = size(allSounds{randConditions(3,iTrials)},2);
    sounddur = size(allSounds{randConditions(3,iTrials)},1)/sr;
    pahandle = PsychPortAudio('Open', [], [], 2, sr, nrchannels, [], 0.1);
% Fixationskreuz
    DrawFormattedText(window, Fixation, 'center', 'center', 0);
    FixOnset = Screen('Flip',window); % Von Backpuffer in Frontpuffer, FixOnset ist Zeitpunkt des Starts der Darbietung
    Screen('Flip',window, [FixOnset + 1]); % Darbietungszeit 1 sec
% Auditiver Input
    PsychPortAudio('FillBuffer', pahandle, allSounds{randConditions(3,iTrials)}');
    audiostart = PsychPortAudio('Start', pahandle, 1, 0, 1);
% Visueller Input
    DrawFormattedText(window, allWords{randConditions(2,iTrials)}, 'center', 'center', 0);
    StimOnset = Screen('Flip',window);
% Tastendruck erfassen
    [x,y,buttons] = GetMouse;
% wenn momentan noch eine Taste gehalten wird, warte bis sie wieder losgelassen wird
    while sum(buttons) > 0 & GetSecs < StimOnset + 2;
        [x,y,buttons] = GetMouse;
    end
% warte nun auf einen neuen Tastendruck
    while sum(buttons) == 0 & GetSecs < StimOnset + 2;
        [x,y,buttons] = GetMouse;
        t2 = GetSecs;
    end
    Screen('Flip',window, StimOnset + 2); % Darbietungszeit 2 sec
% Reaktionszeit und Tastendruckabfrage
    RT(iTrials) = t2-StimOnset;
    Antwort(iTrials) = buttons(1);
    PsychPortAudio('Close', pahandle);
end

% Ergebnismatrix
RT = RT';
Taste = Antwort';
Bedingungen = randConditions(1,:)';
Resultate = table(RT, Taste, Bedingungen);
filename = ['data_vp' num2str(vp) '.csv'];
writetable(Resultate,filename);
    % 1. Spalte: Reaktionszeit in sec,
    % 2. Spalte: Tastendruckabfrage 0 = keine Maustaste gedrückt
    %                               1 = Masutaste gedrückt
    % 3. Spalte: Jeweilige Bedingung  1 = ohne Target (25% der Trials)
    %                                 2 = nur visuelles Target (25% der Trials)
    %                                 3 = nur auditives Target (25% der Trials)
    %                                 4 = bimodales Target mit unterschiedlichen Wörtern (12,5% der Trials)
    %                                 5 = bimodales Target mit gleichen Wörtern (12,5% der Trials)
    
% Durchschnittliche Reaktionszeiten & Anzahl falscher Antworten
RTcond2 = find(Resultate.Bedingungen == 2);
RTcond2 = Resultate.RT(RTcond2);
meanRTcond2 = mean(RTcond2);
RTcond3 = find(Resultate.Bedingungen == 3);
RTcond3 = Resultate.RT(RTcond3);
meanRTcond3 = mean(RTcond3);
RTcond4 = find(Resultate.Bedingungen == 4);
RTcond4 = Resultate.RT(RTcond4);
meanRTcond4 = mean(RTcond4);
RTcond5 = find(Resultate.Bedingungen == 5);
RTcond5 = Resultate.RT(RTcond5);
meanRTcond5 = mean(RTcond5);
FA = length(find((Resultate.Bedingungen == 1 & Resultate.Taste == 1) | (Resultate.Bedingungen ~= 1 & Resultate.Taste == 0)));
RTFeedback = ['Durchschnittliche Reaktionszeiten:\n'...
    '\n'...
    'Nur visuelles Target: ' num2str(meanRTcond2) '\n'...
    '\n'...
    'Nur auditives Target: ' num2str(meanRTcond3) '\n'...
    '\n'...
    'Bimodales Target (unterschiedliche Wörter): ' num2str(meanRTcond4) '\n'...
    '\n'...
    'Bimodales Target (gleiche Wörter): ' num2str(meanRTcond5) '\n'...
    '\n'...
    '\n'...
    'Anzahl falscher Antworten: ' num2str(FA)];

% Feedbackbildschirm
sy = 100;
Screen('TextSize', window, 80 );
DrawFormattedText(window, Feedback, 'center', sy, 0);
Screen('TextSize', window, 30 );
DrawFormattedText(window, RTFeedback, 'center', 'center', 0);
sy = 800;
Screen('TextSize', window, 20 );
DrawFormattedText(window, Fortfahren, 'center', sy, 0);
Screen('Flip',window);
KbStrokeWait;

% Abschiedsbildschirm
Screen('TextSize', window, 80 );
DrawFormattedText(window, Abschied, 'center', 'center', 0);
sy = 800;
Screen('TextSize', window, 20 );
DrawFormattedText(window, Ende, 'center', sy, 0);
Screen('Flip',window);
KbStrokeWait;


Screen('CloseAll');




