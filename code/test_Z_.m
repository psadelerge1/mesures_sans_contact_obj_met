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

Freq = 3000; %en kHz
t1 = 25;  %Epaisseur de la plaque conductrice en mm
l0 = 0.1;  %Distance capteur-cible en mm
val_integral = Z_integral(coil,Freq,t1,l0,sig,mu,cup)
Val_L=imag(val_integral)/(2*pi*Freq)
Val_R=real(val_integral)
test_r_r=val_integral-real(0.362)
%   Val_min=fminsearch(4.580922583797834e-06,c1)

