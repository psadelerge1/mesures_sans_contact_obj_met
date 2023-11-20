f = @(x,a)100*(x(2) - x(1)^2)^2 + (a-x(1))^2;
a = 3;
fun = @(x)f(x,a);
x0 = [-1,1.9];
x = fminsearch(fun,x0)