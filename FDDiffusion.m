dt = 0.001;
dx = 1.0;
D = 1.0;
kappa = 1.0;
beta = D*dt/(dx*dx);
beta2 = 2*kappa*dt/(dx*dx*dx*dx);
n = 32;
N = 80000;
clf 
hold on
m = 1.0;
for i=1:n
	oldc(i)=0.5*(1+sin(2*pi*m*i*dx/n));
	newc(i)=0.0;
	oldd(i)=oldc(i);
	newd(i)=0.0;
endfor
plot(oldc,'b');

A =1.0;
for i=1:n
	g(i)=2*A.*oldc(i).*(1.-oldc(i))*(1.-2.*oldc(i));
endfor


for j=1:N
	for i=1:n
		w = i-1;
		ww = i-2;
		ee = i+2;
		e = i+1;
		if(ww<1) ww=ww+n;
		endif
		if(ee>n) ee=ee-n;
		endif
		if(e>n) e=e-n;
		endif
		if(w<1) w=w+n;
		endif
		newc(i)=oldc(i)+beta*(oldc(w)+oldc(e)-2*oldc(i));
		newd(i)=oldd(i)+beta*(g(w)-2.*g(i)+g(e))-beta2*(oldd(ww)-4*oldd(w)+6*oldd(i)-4*oldd(e)+oldd(ee));
	endfor
	%%newd(2)=oldd(2)+beta*(g(1)-2*g(2)+g(3))-beta2*(oldd(n)-4*oldd(1)+6*oldd(2)+4*oldd(3)+oldd(4));
	%%newd(1)=oldd(1)+beta*(g(n)-2*g(1)+g(2))-beta2*(oldd(n-1)-4*oldd(n)+6*oldd(1)+4*oldd(2)+oldd(3));
	%%newd(n)=oldd(n)+beta*(g(n-1)-2*g(n)+g(1))-beta2*(oldd(n-2)-4*oldd(n-1)+6*oldd(n)+4*oldd(1)+oldd(2));
	%%newd(n-1)=oldd(n-1)+beta*(g(n-2)-2*g(n-1)+g(n))-beta2*(oldd(n-3)-4*oldd(n-2)+6*oldd(n-1)+4*oldd(n)+oldd(1));
	for i=1:n
		oldc(i)=newc(i);
		oldd(i)=newd(i);		
	endfor
endfor
plot(oldc,'r');
plot(oldd,'g');

print -djpg DiffusionVsCahn-Hilliard.jpg
	
