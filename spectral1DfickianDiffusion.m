clc
clear all

N = 128;
D =1.0;
delt = 1.0;

c = zeros(N,1);
M = 2;

for j=1:N
	c(j,1) = 0.5*(1+sin(2*pi*M*j/N));
endfor

plot(c,'rs;Initial Profile;');

hold on

halfN = N/2;

delk = 2*pi/N;

for k=1:20
	for m=1:2000
		ctilde = fft(c);
		for i=1:N
			if (i<halfN)
				k = i*delk;
			endif
			if(i>=halfN)
				k = (i-N)*delk;
			endif
			ctilde(i,1) = ctilde(i,1)/(1+D*k*k*delt);
		endfor
	endfor
	c = real(ifft(ctilde));
	plot(c)
endfor

print -djpg spectral1DfickianDiffusion.jpg

