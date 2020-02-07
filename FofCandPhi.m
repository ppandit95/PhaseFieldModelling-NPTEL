N = 141;
c = linspace(-0.2,1.2,N)';
phi = linspace(-0.2,1.2,N)';


function y = W(phi)
	y = phi.*phi.*phi.*(10.-15.*phi+6.*phi.*phi);
endfunction



[C,Phi] = meshgrid(c,phi);
A = 1.0;
B = 1.0;
P = 1.0;

WangFn = W(Phi);

for i=1:N*N
	if(WangFn(i)<0)
		WangFn(i) = 0;
	elseif(WangFn(i)>1)
		WangFn(i) = 1.0;
	endif
endfor

F = A.*C.*C.*(1.-WangFn) + B.*(1.-C).*(1.-C).*WangFn + P.*Phi.*Phi.*(1.-Phi).*(1.-Phi);

mesh(c,phi,F)

print -dpng FofCandPhi.png
		

