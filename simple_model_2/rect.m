function rect_r = rect(t)
  Tb = 1; % us
  N0 = length(t(t < 0));
  N1 = length(t(t >= 0 & t < Tb / 2));
  N2 = length(t(t >= Tb / 2));
  rect_r = [zeros(1, N0) ones(1, N1) zeros(1, N2)];
end

