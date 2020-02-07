#Clear the screen and workspace
clc
clear all
#Define the parameters
delt = 0.1;
delx = 0.5;
D = 1.0;

alpha = D*delt/(delx*delx);

#Set the initial profile

C = zeros(101,1);
C(1) = 1.0;

#Plot the initial profile

plot(C,'r-;Initial Profile;');

#Get Handle

ax=gca;

set(ax,"linewidth",2.0);
axis("square");

# Hold the plot in future
 hold on

#Evolve the composition and plot
for k=1:20
	for j=1:500
		for i=2:100
			C(i)=C(i)*(1 - 2*alpha) + alpha*(C(i-1)+C(i+1));
		endfor
		C(101)=C(i)*(1 - 2*alpha) + 2*alpha*C(i-1);
	endfor
	plot(C)
endfor

#Save figure
print -djpeg ExplicitNoFlux.jpeg

