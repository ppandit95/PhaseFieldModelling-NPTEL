clear all;
clc;
clf;
more off
kappa =1;
A =1 ;
L =1 ;
Nx = 128;
Ny = 64;
for i=1:Nx
	for j=1:Ny
		phi(i,j)=0.5+0.1*(0.5-rand());
	endfor
endfor
mesh(phi);
view(2);
pause(1)
dt = 0.5;
halfNx = Nx/2;
halfNy = Ny/2;
delkx = 2*pi/Nx;
delky = 2*pi/Ny;
for m=1:800	
	for n=1:15
		g = 2.*A.*phi.*(1.-phi).*(1.-2.*phi);
		ghat = fft2(g);
		phihat = fft2(phi);
		for i=1:Nx
			if((i-1)<=halfNx)
				kx = (i-1)*delkx;
			endif
			if((i-1)>halfNx)
				kx = (i-1-Nx)*delkx;
			endif
			for j=1:Ny
				if((j-1)<=halfNy)
					ky = (j-1)*delky;
				endif
				if((j-1)>halfNy)
					ky = (j-1-Ny)*delky;
				endif
				k2=kx*kx + ky*ky;
				phihat(i,j)=(phihat(i,j) - L*dt*ghat(i,j))/(1.+2*kappa*L*dt*k2);
			endfor
		endfor
		phi=real(ifft2(phihat));
	endfor
	mesh(phi);
	view(2);
	pause(0)
endfor
	

				
	
