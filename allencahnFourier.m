clear all
clc
clf
kappa = 1;
L = 1;
A = 1;

N = 128;
dx = 1;
phi = zeros(N,1);

for i=(N/4)+1:3*N/4
	phi(i) = 1;
endfor

plot(phi,'r;Initial Profile;')
hold on

halfN = N/2;
delk = 2*pi/N;
dt = 0.5;

for m=1:800
	g=2*A.*phi.*(1.-phi).*(1.-2.*phi);
	ghat=fft(g);
	phihat=fft(phi);
	for i=1:N
		if((i-1) <= halfN)
			k = (i-1)*delk;
		endif
		if((i-1) > halfN)
			k = (i-1-N)*delk;
		endif
		k2 = k*k;
		phihat(i) = (phihat(i) - L*dt*ghat(i))/(1+2*kappa*L*dt*k2);
	endfor
	phi=real(ifft(phihat));
endfor
plot(phi)
print -djpg SpectralAllenCahn.jpg

