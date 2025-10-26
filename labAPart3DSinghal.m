close all
clear
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PART 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fs = 8000;  % sampling frequency (Hz)
d = 2;      % duration of each note (s)

studentID = '22327346';

note = 24;
midi = 'C1';

f0 = calcFundFreq(note);
[x,t] = createNote(note, d, fs, f0);

% Listen to the generated notes
fprintf('Playing note %d (%s) at %.2f Hz\n', note, midi, f0);
% sound(x, fs);
% pause(d + 0.25);

% Task 1

upsampleFactors = [2 4];   % Explore multiple upsampling factors
interpOrder = 64;          % FIR interpolation filter order for Task 1

% stem original sine wave
figure('Name', 'Task 1: Original and Upsampled Sine Wave');
tiledlayout(numel(upsampleFactors) + 1, 1);
nexttile;
stem(t(1:min(200, numel(t))), x(1:min(200, numel(x))), 'LineWidth', 1.2);
xlabel('Time (s)');
ylabel('Amplitude');
title(sprintf('Original %s Sine Wave at %.0f Hz (Fs = %.0f Hz)', note, f0, fs));
legend('Original');

% Upsample and stem for each factor
for i = 1:numel(upsampleFactors)
    L = upsampleFactors(i);
    [outputZeroInserted, outputInterpolated, tUp] = upscaleSig(x, fs, L, interpOrder);

    nexttile;
    hold on;
    stem(tUp(1:min(200, numel(tUp))), outputZeroInserted(1:min(200, numel(outputZeroInserted))), ':', 'LineWidth', 0.8, 'DisplayName', sprintf('Zero-Inserted (L = %d)', L));
    stem(tUp(1:min(200, numel(tUp))), outputInterpolated(1:min(200, numel(outputInterpolated))), 'LineWidth', 1.2, 'DisplayName', sprintf('Interpolated (L = %d)', L));
    hold off;
    xlabel('Time (s)');
    ylabel('Amplitude');
    title(sprintf('Upsampled %s Sine Wave (Factor %d, Fs = %.0f Hz)', note, L, fs * L));
    legend('Location', 'best');

end

% Task 2

%original audio load and listen
load handel.mat;

filename = 'handel.wav';
audiowrite(filename,y,Fs);
clear y Fs

[y,Fs] = audioread('handel.wav');

% sound(y,Fs);
% pause(10);

upsampleFactors = [2 4 8 16];
interpOrder = 128;
t = (0:numel(y) - 1) / (Fs);

% stem original sine wave
figure('Name', 'Task 1: Original and Upsampled Sine Wave');
tiledlayout(numel(upsampleFactors) + 1, 1);
nexttile;
stem(t(1:min(200, numel(t))), y(1:min(200, numel(y))), 'LineWidth', 1.2);
xlabel('Time (s)');
ylabel('Amplitude');
title(sprintf('Original %s Sine Wave at %.0f Hz (Fs = %.0f Hz)', note, f0, fs));
legend('Original');



% Upsample and stem for each factor
for i = 1:numel(upsampleFactors)
    L = upsampleFactors(i);
    [outputZeroInserted, outputInterpolated, tUp] = upscaleSig(y, Fs, L, interpOrder);

    nexttile;
    hold on;
    stem(tUp(1:min(200, numel(tUp))), outputZeroInserted(1:min(200, numel(outputZeroInserted))), ':', 'LineWidth', 0.8, 'DisplayName', sprintf('Zero-Inserted (L = %d)', L));
    stem(tUp(1:min(200, numel(tUp))), outputInterpolated(1:min(200, numel(outputInterpolated))), 'LineWidth', 1.2, 'DisplayName', sprintf('Interpolated (L = %d)', L));
    hold off;
    xlabel('Time (s)');
    ylabel('Amplitude');
    title(sprintf('Upsampled %s Sine Wave (Factor %d, Fs = %.0f Hz)', note, L, Fs * L));
    legend('Location', 'best');
    xlim([0 15/fs])

    % sound(outputInterpolated, Fs * L); %% it is effectively ike Fs * L due to the upsampling
    % pause(10);

    outputFile = sprintf('handel_interpolated_upsampled_x%d.wav', L);
    audiowrite(outputFile, outputInterpolated, Fs * L);

    outputFile = sprintf('handel_zero_upsampled_x%d.wav', L);
    audiowrite(outputFile, outputZeroInserted, Fs * L);
end