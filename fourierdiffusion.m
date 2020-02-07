clear all;
clc;
clf;
kappa = 1.0;
A = 1.0;
N = 128;
dx = 1.0;
c = zeros(N,1);
d = zeros(N,1);
for i=(N/4)+1:3*N/4
	c(i)=1.0;
	d(i)=c(i);
endfor
plot(c,'r;Initial Profile;');
hold on
halfN = N/2;
delk = 2*pi/N;
dt = 0.5;
for m=1:100
	g = 2.*d.*(1.-d).*(1.-2.*d);
	ghat = fft(g);
	chat=fft(c);
	dhat=fft(d);
	for i=1:N
		if((i-1)<=halfN)
			k = (i-1)*delk;
		endif
		if((i-1)>halfN)
			k = (i-1-N)*delk;
		endif
		k2 = k*k;
		k4 = k2*k2;
		chat(i) = chat(i)/(1+k2*dt);
		dhat(i) = (dhat(i) - k2*dt*ghat(i))/(1+2*k4*dt);
	endfor
	c = real(ifft(chat));
	d = real(ifft(dhat));
	
endfor


plot(c)
plot(d,'-')
print -djpg fourierDiffusionVsCahn-hilliard.jpg
