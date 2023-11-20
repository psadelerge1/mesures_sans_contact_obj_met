r1  = 10.23;        %rayon interieur bobine d = 20.46
r2  = 21.315;       %rayon exterieur bobine d = 42.63 mm
l3      = 2.45;   %hauteur bobine 
turn    = 20;     %nombre de spires
coil = [r1 r2 l3 turn];

sigma     = 0;     %conductivite du couvercle
mu_r      = 1000;     %permeabilite du couvercle
epaisseur = 2.21;     %epaisseur du couvercle
l4        = 0;     %distance bobine au couvercle
cup =[sigma,mu_r,epaisseur,l4];

c1=20.1e6; %Conductivites m1
c2 = 0 ; %Conductivites m2
sig = [c1 c2];

mu_1=1; %Permeabilites relatives dans les milieux 1 et 2
mu_2=1;
mu =[mu_1 mu_2];

Freq = 33; %en kHz
t1 = 25;  %Epaisseur de la plaque conductrice en mm
l0 = 0.1;  %Distance capteur-cible en mm



s = serial('COM1','BaudRate',19200,'Terminator','CR/LF'); %Create a serial port  
fopen(s);
fprintf(s,'*TRG');
fprintf(s,'OUTPUT,ON');
fprintf(s,'FREQUE,33e3');
m =3;
for n = 1:m
    fprintf(s,'BEEP');
    pause(0.5);
end
fprintf(s,'LCR?');
val = fscanf(s);

fclose(s);

valnum = str2num(val);
%{
valnum(x) =

1 : freq   ||  2 : magnitude ch1  ||  3 : magnitude ch2  ||  5 : phase  ||
6 : resistance  ||  7 : Inductance  ||  9 : resistance parallel  ||  
10 : inductance parallel || 13 : Q factor
%}

Freq = valnum(1);
omeg = 2*pi*Freq;
Res  = valnum(6);
Ind  = valnum(7);
Z_mes = Res+Ind*omeg*j;
Z_sim = Z_integral(coil,Freq,t1,l0,sig,mu,cup);
%E_Z=abs(Z_mes-Z_sim)^2;

c1_0= [5.1];

sig =[c1,0]; 
f=@(c1,Z_mes)abs(Z_mes-Z_integral(coil,Freq,t1,l0,sig,mu,cup))^2;
fun = @(c1)f(c1,Z_mes);

options = optimset('PlotFcns',@optimplotfval);

Res= fminsearch(fun,c1_0,options)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%{
f = @(x,a)100*(x(2) - x(1)^2)^2 + (a-x(1))^2;
a = 3;
fun = @(x)f(x,a);
x0 = [-1,1.9];
x = fminsearch(fun,x0)
%}

