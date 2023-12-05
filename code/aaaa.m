%{
f = @(x)(3+x)^2;
fun = @(x)f(x);
x0 = 1;
options = optimset('PlotFcns',@optimplotfval);

x = fminsearch(fun,x0,options)
%}
%Ind*j-imag(Z_integral(coil,Freq,t1,l0,[c1,0],mu,cup))

x1 = 500;
x2 = 750;
x3 = 700;
x4 = 1000;
x5 = 2700;
x6 = 11000;
X=[x1 x2 x3 x4 x5 x6]
y1 = 52.25e6;
y2 = 42.312e6;
y3 = 18.26e6;
y4 = 12.86e6;
y5 = 1.148e6;
y6 = 0.5215e6;
Y=[y1 y2 y3 y4 y5 y6];
Y2=[52.2e6 42.2e6 20.1e6 14.8e6 1.4e6 0.61e6];
%semilogy(X,Y)
%plot(X,log10(Y))
%grid on
W=X.*Y2
%plot(X,W)
S=(2.61e10+3.165e10+1.407e10+1.48e10+1.4e10+1.342e10)/6

