clf
clear all

delt = 0.1;
delx = 0.5;
D = 1.0;
N = 101;

alpha = D*delt/(delx*delx);

c = zeros(N,1);
c(1) = 1.0;

for j=1:N
	cold(j,1) = c(j,1);
endfor

plot(c,'r*;Initial Profile;');

ax = gca;

set(ax,'linewidth',2.0);
axis("square");

hold on

A = zeros(N,N);
A(1,1) = 1.0;

#Populate the diagonal elements
for j =2:N
	A(j,j) = 1+2*alpha;
endfor

#Populate the lower diagonal elements
for j = 2:N-1
	A(j,j-1) = -alpha;
endfor
A(N,N-1)=-2*alpha;

#Populate the lower diagonal elements

for j=3:N
	A(j-1,j) = -alpha;
endfor

for k=1:20
	for j=1:500
		c = A \ cold;
		for i=1:N
			cold(i) = c(i);
		endfor 
	endfor
	plot(c)
endfor

print -djpg implicit1DfickianDiffusion.jpg


	
