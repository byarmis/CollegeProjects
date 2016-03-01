clc
clear all
close all

for k = 1:16
	plot(fft(eye(k+16)))
	axis equal
	M(k) = getframe;
end

movie(M,2)