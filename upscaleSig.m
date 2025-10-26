% Upsampling function with interpolation
function [yZeroInserted, yInterpolated, tUpsampled] = upscaleSig(x, Fs, L, filterOrder)
% yZeroInserted : Zero-stuffed signal prior to interpolation
% yInterpolated : Interpolated signal with imaging suppressed
% tUpsampled    : Time vector for the upsampled signal

x = x(:).'; % Work with row vector for indexing
N = numel(x);

% Zero insertion (expansion stage)
yZeroInserted = zeros(1, N * L);
yZeroInserted(1:L:end) = x;

cutoff = 1 / L; % Normalized frequency (Nyquist = 1)
h = fir1(filterOrder, cutoff, hamming(filterOrder + 1));

% Apply filter with delay compensation and scaling by L
delay = filterOrder / 2;
paddedSignal = [yZeroInserted zeros(1, delay)];
filteredSignal = filter(h, 1, paddedSignal);
filteredSignal = filteredSignal(delay + 1:end);
yInterpolated = L * filteredSignal(1:numel(yZeroInserted));

% Time vector for the upsampled sequence
tUpsampled = (0:numel(yZeroInserted) - 1) / (Fs * L);
end
