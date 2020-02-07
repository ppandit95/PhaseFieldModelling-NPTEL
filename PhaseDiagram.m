clc
clear all
function y = G(a,x)
y = a.*x.*(1.-x) .+ x.*log(x) .+ (1.-x).*log(1.-x);
endfunction
x=0.001:0.001:0.999;
a(1)=2.0;
for i=1:400
c(i) = fminbnd(@(x) G(a(i),x),0.001,0.499,optimset('TolX',1.e-12));
d(i) = fminbnd(@(x) G(a(i),x),0.501,0.999,optimset('TolX',1.e-12));
a(i+1)=a(i)+0.01;
endfor
for i=1:400
b(i)=a(i);
endfor
plot(c,1./b)
hold on
plot(d,1./b)
