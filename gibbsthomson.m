clear all;
clc;
clf;

Nx = 64;
Ny = 64;
halfNx = Nx/2;
halfNy =Ny/2;
R = 10;
for i=1:Nx
	for j=1:Ny
		if(((i-halfNx)*(i-halfNx)+(j-halfNy)*(j-halfNy)) < (R*R))
			c(i,j) = 1.0;
		elseif 	c(i,j) = 0.02;
		endif
	endfor
endfor
Cprofile = c(:,halfNx);
plot(Cprofile,'r;Initial Profile;');
hold on
dt = 0.5;

delkx = 2*pi/Nx;
delky = 2*pi/Ny;
A = 1;
M = 1;
kappa = 1;
for m=1:80
	for n=1:8
		g = 2.*A.*c.*(1.-c).*(1.-2.*c);
		ghat = fft2(g);
		chat = fft2(c);
		for i=1:Nx
			if((i-1)<=halfNx)
				kx = (i-1)*delkx;
			endif
			if((i-1)> halfNx)
				kx = (i-1-Nx)*delkx;
			endif
			for j=1:Ny
				if((j-1)<=halfNy)
					ky = (j-1)*delky;
				endif
				if((j-1)> halfNy)
					ky = (j-1-Ny)*delky;
				endif
				k2 =kx*kx + ky*ky;
				k4 = k2*k2;
					
				chat(i,j) = (chat(i,j) - M*dt*k2*ghat(i,j))/(1.+2*M*kappa*k4*dt);
			endfor
		endfor
		c = real(ifft2(chat));
	endfor
	
endfor
Cprofile = c(:,halfNx);
plot(Cprofile,'b;Final Profile;');
print -djpg GibbsThomsonEffect.jpg

				

