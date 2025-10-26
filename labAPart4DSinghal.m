close all
clear
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PART 4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fs = 8000;  % sampling frequency (Hz)
d = 2;      % duration of each note (s)

studentID = '22327346';

note = 60;
midi = 'C';

noteV = [60 60 62 60 65 64, ...
          60 60 62 60 67 65, ...
          60 60 72 69 65 64 62, ...
          70 70 69 65 67 65];

dV = [0.5 0.25 0.75 0.75 0.75 1.0, ...
       0.5 0.25 0.75 0.75 0.75 1.0, ...
       0.5 0.25 0.5 0.5 0.75 0.75 1.0, ...
       0.5 0.25 0.5 0.5 0.75 1.0];

% Task 4
melody = createMelody(noteV, dV, fs);
tV = (0:numel(melody) - 1).' / fs;

audiowrite('melody.wav', melody, fs);
% sound(melody, fs)
% pause(20)

figure('Name', 'Original Melody');
stem(tV(1:min(200, numel(tV))), melody(1:min(200, numel(melody))), 'LineWidth', 1.1);
xlabel('Time (s)');
ylabel('Amplitude');
title('Original Melody (Happy Birthday)');
grid on;

%% Task 5
noteVectOctave = noteV + 12; % add 12 for octave up
speedFactor = 1.5; % play 50%% faster by decreasing durations
fastDurations = dV / speedFactor;

melodyFast = createMelody(noteVectOctave, fastDurations, fs);
audiowrite('melody_octaveUp_fast.wav', melodyFast, fs);
% sound(melodyFast, fs)
% pause(15)

tV = (0:numel(melodyFast) - 1).' / fs;
figure('Name', 'melody_octaveUp_fast');
stem(tV(1:min(200, numel(tV))), melodyFast(1:min(200, numel(melodyFast))), 'LineWidth', 1.1);
xlabel('Time (s)');
ylabel('Amplitude');
title('melody_octaveUp_fast (Happy Birthday)');
grid on;

%% Task 6
randomNotes = randi([24, 107], 1, randi([6, 14]));
randomDurations = 0.2 + 0.8 * rand(1, randi([6, 14])); % between 0.2s and 1.0s

melodyRandom = createMelody(randomNotes, randomDurations, fs);
audiowrite('melody_random.wav', melodyRandom, fs);
% sound(melodyRandom, fs)
% pause(10)