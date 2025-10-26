close all
clear

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PART 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fs = 8000; % sampling frequency (Hz)
d = 2; % duration of each note (s)

studentID = '22327346';

noteA = 24;
noteB = 64;

midiA = 'C1';
midiB = 'D4';

freqA = calcFundFreq(noteA);
freqB = calcFundFreq(noteB);

[xA, tA] = createNote(noteA, d, fs, freqA);
[xB, tB] = createNote(noteB, d, fs, freqB);

% Listen to the generated notes
fprintf('Playing note %d (%s) at %.2f Hz\n', noteA, midiA, freqA);
%sound(xA, fs);
%pause(d + 0.25);

fprintf('Playing note %d (%s) at %.2f Hz\n', noteB, midiB, freqB);
%sound(xB, fs);
%pause(d + 0.25);

% Plot the notes for comparison
figure('Name', 'Musical Notes Part 2');
subplot(2, 1, 1);
stem(tA(1:min(200, numel(tA))), xA(1:min(200, numel(xA))));
grid on;
title(sprintf('Note %d (%s)', noteA, midiA));
ylabel('Amplitude');

subplot(2, 1, 2);
stem(tB(1:min(200, numel(tB))), xB(1:min(200, numel(xB))));
grid on;
title(sprintf('Note %d (%s)', noteB, midiB));
xlabel('Time (s)');
ylabel('Amplitude');

sgtitle(sprintf('Comparison of Notes %s vs %s - Student ID: %s', ...
    midiA, midiB, studentID));

%% rand test
noteTest_1 = -1;
freqTest_1 = calcFundFreq(noteTest_1);
[xTest_1, tTest_1] = createNote(noteTest_1, d, fs, freqTest_1);
fprintf('Playing rest (note %d) at %.2f Hz\n', noteTest_1, freqTest_1);
sound(xTest_1, fs);
pause(d + 0.25);
xlim ([0 15/fs])

% Plot the notes for comparison
figure('Name', 'Musical Notes Part 2');
subplot(2, 1, 2);
stem(tTest_1, xTest_1);
grid on;
title(sprintf('Note %d (%s)', noteTest_1));
xlabel('Time (s)');
ylabel('Amplitude');
xlim ([0 15/fs])
