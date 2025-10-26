close all;
clear;
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This is the blank template for Lab A, 2025           %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Task 1
Fs = 8000;  % Sampling frequency of 8000 Hz
F0 = 900;   % Fundamental frequency of 900 Hz
d = 3;      % duration of 3 sec

Nfft = 4096; % FFT length 

%Task 2
N = Fs * d;
n = 0 : N-1;

%Task 3
t = n / Fs;

%Task 4
x = sin (2 * pi * F0 * t);

%Task 5
%sound(x,Fs);
%pause(3.5)

%Task 6
F0_x1 = 900;  % Assuming Fundamental frequency of x1 = x
F0_x2 = 7200; % Fundamental frequency of x2 = 7.2k
F0_x3 = 4000; % Fundamental frequency of x3 = 4000

x1 = sin (2 * pi * F0_x1 * t);
x2 = sin (2 * pi * F0_x2 * t);
x3 = sin (2 * pi * F0_x3 * t);

% Task 7 - stem short window of each waveform and listen
figure;
subplot(2,1,1);
stem(t(1:50), x1(1:50));  % stem 50 samples
title('x1 - 900 Hz');
xlabel('Time (s)');
ylabel('Amplitude');

%sound(x1,Fs);
%pause(3.5)

subplot(2,1,2);
stem(t(1:50), x2(1:50));
title('x2 - 7200 Hz');
xlabel('Time (s)');
ylabel('Amplitude');

%sound(x2,Fs);
%pause(3.5)

subplot(2,1,2);
stem(t(1:50), x3(1:50));
title('x3 - 4000 Hz');
xlabel('Time (s)');
ylabel('Amplitude');

%sound(x3,Fs);
%pause(3.5)

f_axis = (0:(Nfft/2))*(Fs/Nfft);

X1 = fft(x1, Nfft);
X2 = fft(x2, Nfft);
X3 = fft(x3, Nfft);

P1 = abs(X1)/Nfft;
P2 = abs(X2)/Nfft;
P3 = abs(X3)/Nfft;

P1s = P1(1:Nfft/2+1);
P2s = P2(1:Nfft/2+1);
P3s = P3(1:Nfft/2+1);
P1s(2:end-1) = 2*P1s(2:end-1);
P2s(2:end-1) = 2*P2s(2:end-1);
P3s(2:end-1) = 2*P3s(2:end-1);


% Plot FFT magnitudes (linear)
figure('Name','Single-sided FFT magnitude');
subplot(3,1,1)
plot(f_axis, P1s);
xlim([0 Fs/2]);
grid on;
title(sprintf('FFT magnitude of x1 (%.0f Hz) — Fs=%.0f Hz', F0_x1, Fs));
xlabel('Frequency (Hz)'); ylabel('|X1(f)|');

subplot(3,1,2)
plot(f_axis, P2s);
xlim([0 Fs/2]);
grid on;
title(sprintf('FFT magnitude of x2 (%.0f Hz) — Fs=%.0f Hz', F0_x2, Fs));
xlabel('Frequency (Hz)'); ylabel('|X2(f)|');

subplot(3,1,3)
plot(f_axis, P3s);
xlim([0 Fs/2]);
grid on;
title(sprintf('FFT magnitude of x3 (%.0f Hz) — Fs=%.0f Hz', F0_x3, Fs));
xlabel('Frequency (Hz)'); ylabel('|X3(f)|');

% Task 8 - nyquist
Fs_values = 500 : 500 : 3000;
f0 = 900;
d = 3;

for i = 1:length(Fs_values)
    fs = Fs_values(i);
    N = fs * d;
    n = 0:N-1;
    t = n/fs;

    % Generate signal
    x = sin(2*pi*f0*t);

    % Compute FFT
    X = fft(x, Nfft);
    P = abs(X)/Nfft;
    Ps = P(1:Nfft/2+1);
    Ps(2:end-1) = 2*Ps(2:end-1);

    % Create a new figure for each fs
    figure('Name', sprintf('Signal and FFT (Fs = %d Hz)', fs));

    % --- Subplot 1: Time domain ---
    subplot(2,1,1);
    stem(t(1:min(100, numel(t))), x(1:min(100, numel(x))));
    title(sprintf('Time-domain signal — Fs = %d Hz', fs));
    xlabel('Time (s)');
    ylabel('Amplitude');
    grid on;

    % --- Subplot 2: Frequency domain ---
    subplot(2,1,2);
    plot(f_axis, Ps);
    xlim([0 Fs/2]);
    grid on;
    title(sprintf('FFT magnitude of x (%.0f Hz) — Fs = %.0f Hz', f0, fs));
    xlabel('Frequency (Hz)');
    ylabel('|X(f)|');

    % Play tone
    % sound(x, fs);
    fprintf('Playing tone at fs = %d Hz\n', fs);
    % pause(3.5);
end

%% Put Section Break for ease

% Task 10 - aliasing with Handel audio
%original audio load and listen
load handel.mat;

filename = 'handel.wav';
audiowrite(filename,y,Fs);
clear y Fs

[y,Fs] = audioread('handel.wav');

% sound(y,Fs);
% pause(10);

% Try undersampling
fs_test = [round(Fs/2), round(Fs/3), round(Fs/4)];

figure;
subplot(2,1,1);
stem(y);
title(['Original signal at ', num2str(Fs), ' Hz']);
xlabel('Sample Index'); ylabel('Amplitude');

for k = 1:length(fs_test)
    newFs = fs_test(k);
    y_resampled = resample(y, newFs, Fs);

    subplot(2,1,2);
    stem(y_resampled);
    title(['Resampled at ', num2str(newFs), ' Hz']);
    xlabel('Sample Index'); ylabel('Amplitude');

    sound(y_resampled, newFs);
    %pause(10);
end