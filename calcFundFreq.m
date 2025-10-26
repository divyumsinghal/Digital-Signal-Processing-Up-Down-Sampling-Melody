% calculate fundamental frequency
function [f0] = calcFundFreq (note)
% f = 440 * 2.^((note - 69) / 12);
f0 = 440 * 2.^((note - 69) / 12);
end