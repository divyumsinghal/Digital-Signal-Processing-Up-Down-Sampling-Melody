function [x, t] = createNote(note, d, fs, f0)
%CREATENOTE Generate a sinusoidal musical note or a rest.
%   [x, t] = createNote(note, d, fs) returns the waveform x and time vector t
%   for the MIDI note number "note" with duration d (seconds) sampled at fs
%   (Hz). When note == -1, the function returns a silent rest of length d.

numSamples = max(1, round(d * fs));
t = (0:numSamples - 1).' / fs;

% special case for task 6
if note == -1
    x = zeros(numSamples, 1);
else
    x = sin(2 * pi * f0 * t);
end
end