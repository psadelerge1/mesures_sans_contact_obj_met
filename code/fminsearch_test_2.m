s = serial('COM1','BaudRate',19200,'Terminator','CR/LF'); %Create a serial port  
fopen(s);
fprintf(s,'*TRG');
fprintf(s,'OUTPUT,ON');
fprintf(s,'FREQUE,33e3');
%{
m =3;

for n = 1:m
    fprintf(s,'BEEP');
    pause(0.5);
end
%}
fprintf(s,'LCR?');
val = fscanf(s);

fclose(s);


r1  = 10.23;        %rayon interieur bobine d = 20.46
r2  = 21.315;       %rayon exterieur bobine d = 42.63 mm
l3      = 2.45;   %hauteur bobine 
turn    = 20;     %nombre de spires
coil = [r1 r2 l3 turn];

sigma     = 0;     %conductivite du couvercle
mu_r      = 10000;     %permeabilite du couvercle
epaisseur = 2.21;     %epaisseur du couvercle
l4        = 0.1;     %distance bobine au couvercle
cup =[sigma,mu_r,epaisseur,l4];

c1_1=0.61e6; %Conductivites m1
c2 = 0 ; %Conductivites m2
sig = [c1_1 c2];

mu_1=1; %Permeabilites relatives dans les milieux 1 et 2
mu_2=1;
mu =[mu_1 mu_2];

%Freq = 33; %en kHz
t1 = 20;  %Epaisseur de la plaque conductrice en mm
l0 = 0;  %Distance capteur-cible en mm





valnum = str2num(val);
%{
valnum(x) =

1 : freq   ||  2 : magnitude ch1  ||  3 : magnitude ch2  ||  5 : phase  ||
6 : resistance  ||  7 : Inductance  ||  9 : resistance parallel  ||  
10 : inductance parallel || 13 : Q factor
%}

Freq = valnum(1);%on récup val IAI
omeg = 2*pi*Freq;
Res  = valnum(6)-0.075
Ind  = valnum(7);
Z_mes = Res+Ind*omeg*j;
R_sim =real(Z_integral(coil,Freq,t1,l0,[0.61,0],mu,cup))-0.075
val_integral = Z_integral(coil,Freq,t1,l0,sig,mu,cup);
%delta_Indu=Ind-imag(val_integral)/(2*pi*Freq*1000)
%Ind_mes = Ind
%Ind_sim =imag(val_integral)/(2*pi*Freq*1000)
%{
coil
Freq
t1
l0
sig
mu
cup
%}

%Z_sim = Z_integral(coil,Freq,t1,l0,sig,mu,cup);
%E_Z=abs(Z_mes-Z_sim)^2;


f=@(c1)abs(Z_integral(coil,Freq,t1,l0,[c1,0],mu,cup)-Z_mes)^2;
%I_ressssss=abs(Z_integral(coil,Freq,t1,l0,[0.61,0],mu,cup)-Z_mes)^2
%abs_test_sim = abs(Z_integral(coil,Freq,t1,l0,[20.1e6,0],mu,cup))^2
%abs_test_mes = abs(Z_mes)^2
%f=@(c1)abs(Z_integral(coil,Freq,t1,l0,[c1,0],mu,cup)-Z_integral(coil,Freq,t1,l0,[20.1e6,0],mu,cup))^2;
%f=@(c1)(Ind-(imag(Z_integral(coil,Freq,t1,l0,[c1,0],mu,cup))/(2*pi*Freq*1000)))+(Res-0.078-real(Z_integral(coil,Freq,t1,l0,[c1,0],mu,cup)));
fun = @(c1)f(c1);

%{
 Z_mes
Z_integral(coil,Freq,t1,l0,[c1,0],mu,cup)
ABS=abs(Z_mes-(Z_integral(coil,Freq,t1,l0,[c1,0],mu,cup)))^2
%}

c1_0=5e6;
options = optimset('PlotFcns',@optimplotfval);

c1= fminsearch(fun,c1_0,options)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%{
f = @(x,a)100*(x(2) - x(1)^2)^2 + (a-x(1))^2;
a = 3;
fun = @(x)f(x,a);
x0 = [-1,1.9];
x = fminsearch(fun,x0)
%}

