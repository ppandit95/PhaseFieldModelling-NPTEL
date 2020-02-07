clc
clear all

N = 101;

delt = 0.1;
delx = 0.5;
D = 1.0;

alpha = D*delt/(delx*delx);

c = zeros(N,1);
c(1) = 1.0;
c(N) = 0;

plot(c,'m*;Initial Profile;');

ax = gca;

set(ax,'linewidth',2.0);
axis("square");

hold on

for i=1:N
	cold(i,1) = c(i,1);
endfor

A = zeros(N,N);

#Boundary Conditions
A(1,1) = 1;
A(N,N) = 1;
#Diagonal Terms
for i=2:N-1
	A(i,i) = 1+2*alpha;
endfor
#Lower Diagonal terms
for j=2:N-1
	A(j,j-1) = -alpha;
endfor
#Upper Diagonal terms
for i=3:N
	A(i-1,i) = -alpha;
endfor

for k=1:20
	for j=1:500
		c = inv(A)*cold;
		for i=1:N
			cold(i,1)=c(i,1);
		endfor
	endfor
	plot(c);
endfor


print -djpg implicit1DfickianDiffusionDirichlet.jpg
