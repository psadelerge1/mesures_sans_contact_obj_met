f = @(x)(3+x)^2;
fun = @(x)f(x);
x0 = 1;
options = optimset('PlotFcns',@optimplotfval);

x = fminsearch(fun,x0,options)


%Ind*j-imag(Z_integral(coil,Freq,t1,l0,[c1,0],mu,cup))