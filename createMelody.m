function x = createMelody(note_v, d_v, fs)
%CREATEMELODY Assemble a sequence of notes into a single waveform
x = [];

for i = 1:numel(note_v)
    note = note_v(i);
    d = d_v(i);

    f0 = calcFundFreq(note);

    tmp = createNote(note, d, fs, f0);
    tmp = tmp(:);

    x = [x; tmp];
end

x = x(:);
end
