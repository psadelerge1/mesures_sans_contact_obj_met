s = serial('COM1','BaudRate',19200,'Terminator','CR/LF'); %Create a serial port  
fopen(s);
%{


m =3;

for n = 1:m
    fprintf(s,'BEEP');
    pause(0.5);
end
%}
fprintf(s,'OUTPUT,ON');
fprintf(s,'FREQUE,700');
pause(2);
fprintf(s,'*TRG');
pause(3);
fprintf(s,'LCR?');
val = fscanf(s);





r1  = 4.35;        %rayon interieur bobine 
r2  = 8.25;       %rayon exterieur bobine 

l3      = 0.4;   %hauteur bobine 
turn    = 22;     %nombre de spires
coil = [r1 r2 l3 turn];

sigma     = 0;     %conductivite du couvercle
mu_r      = 1000;     %permeabilite du couvercle
epaisseur = 0.4;     %epaisseur du couvercle
l4        = 0;     %distance bobine au couvercle
cup =[sigma,mu_r,epaisseur,l4];

c1_1=20.1e6; %Conductivites m1
c2 = 0 ; %Conductivites m2
sig = [c1_1 c2];

mu_1=1; %Permeabilites relatives dans les milieux 1 et 2
mu_2=1;
mu =[mu_1 mu_2];

%Freq = 33; %en kHz
%
t1 = 1;  %Epaisseur de la plaque conductrice en mm
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
Res  = valnum(6)-0.36;
Ind  = valnum(7);
Z_mes = Res+Ind*omeg*j;
sig_freq=5.666666666666667e+09;
%Z_mes =0.215860000000000 + 1.084269810585529i;
%val_integral = Z_integral(coil,Freq,t1,l0,sig,mu,cup);
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


%f=@(c1)abs((Z_integral(coil,Freq/1000,t1,l0,[c1,0],mu,cup)/real(Z_integral(coil,Freq/1000,t1,l0,[c1,0],mu,cup)))-(Z_mes/real(Z_mes)))^2;

%f=@(c1)(real(Z_integral(coil,Freq/1000,t1,l0,[c1,0],mu,cup))-real(Z_mes))+(imag(Z_integral(coil,Freq/1000,t1,l0,[c1,0],mu,cup))-imag(Z_mes));
%g=@(f1)abs(Z_integral(coil,f1/1000,t1,l0,[c1_1,0],mu,cup)-Z_mes)^2;
%I_ressssss=abs(Z_integral(coil,Freq,t1,l0,[0.61,0],mu,cup)-Z_mes)^2

%fun=@(x)abs(Z_integral(coil,Freq/1000,x(1),l0,[x(2),0],mu,cup)-Z_mes)^2   ;

fun=@(c1)abs(Z_integral(coil,Freq/1000,t1,l0,[c1,0],mu,cup)-Z_mes)^2;
%f=@(c1)(Ind-(imag(Z_integral(coil,Freq,t1,l0,[c1,0],mu,cup))/(2*pi*Freq*1000)))+(Res-0.078-real(Z_integral(coil,Freq,t1,l0,[c1,0],mu,cup)));
%fun = @(x0)f(x0);
%gun = @(f1)g(f1);

%{
Z_mes
Z_integral(coil,Freq,t1,l0,[c1,0],mu,cup)
ABS=abs(Z_mes-(Z_integral(coil,Freq,t1,l0,[c1,0],mu,cup)))^2
%}

c1_0=5e6;
t1_0=10;
x0=5e6; 
f1_0 = 3.5e3;
options = optimset('PlotFcns',@optimplotfval,'MaxIter',20);


%c_res= fminsearch(fun,x0,options)
c_res= fminsearch(fun,c1_0,options)

Freq
%1 = épaisseur 2 = conductivité c_res(1)
%f_res= fminsearch(gun,f1_0,options)



N_Freq=sig_freq/c_res%(2)

fprintf(s,['FREQUE,', num2str(N_Freq)]);
fprintf(s,'*TRG');
pause(2);
fprintf(s,'LCR?');
pause(2);

val = fscanf(s);
valnum = str2num(val);

omeg = 2*pi*N_Freq;

Res  = valnum(6)-0.36;
Ind  = valnum(7);

Z_mes_2 = Res+Ind*omeg*j;

%fun_2=@(x)abs(Z_integral(coil,N_Freq/1000,x(1),l0,[x(2),0],mu,cup)-Z_mes)^2;
fun_2=@(c1)abs(Z_integral(coil,N_Freq/1000,t1,l0,[c1,0],mu,cup)-Z_mes)^2;

%fun_2 = @(x)f2(c1);
c_res_2= fminsearch(fun_2,c1_0,options)



fclose(s);