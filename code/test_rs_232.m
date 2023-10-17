s = serial('COM1','BaudRate',19200,'Terminator','CR/LF'); %Create a serial port  
% s.Flow='none';

fopen(s);
fprintf(s,'*TRG');
fprintf(s,'OUTPUT,ON');
%fprintf(s,'IAI,MANUAL,INDUCTANCE,NORMAL');
fprintf(s,'FREQUE,33e3');
m =3;
for n = 1:m
    fprintf(s,'BEEP');
    pause(0.25);
end
fprintf(s,'LCR?');
val = fscanf(s);
%idn = fscanf(s);
fclose(s);



 %{
r1  = 4.5;   %bobine 
r2  = 8.5;   %bobine 
l3      = 0.8;   %bobine 
turn    = 1;   %bobine 

Freq    = 33;% en kHz
t1      = 1;
l0      = 0.1;% distance capt cible 
sig     = 1; %Conductivites dans les milieux 1 et 2
mu      =  1; %Permeabilites relatives dans les milieux 1 et 2
%cup     =   %Dimension et constitution du couvercle en ferrite

sigma     = 1;    %conductivite du couvercle
mu_r      = 1;     %permeabilite du couvercle
epaisseur = 1;    %epaisseur du couvercle
l4        = 1;    %distance bobine au couvercle
cup =(sigma,mu_r,epaisseur,l4);
%Z_integral(coil,Freq,t1,l0,sig,mu,cup); 
%}
r1  = 20.46;        %rayon interieur bobine
r2  = 42.63;       %rayon exterieur bobine
l3      = 2.45;   %hauteur bobine 
turn    = 20;     %nombre de spires
coil = [r1 r2 l3 turn];

sigma     = 0;     %conductivite du couvercle
mu_r      = 1000;     %permeabilite du couvercle
epaisseur = 2.21;     %epaisseur du couvercle
l4        = 0;     %distance bobine au couvercle
cup =[sigma,mu_r,epaisseur,l4];

c1=1; %Conductivites m1
c2 = 1 ; %Conductivites m2
sig = [c1 c2];

mu_1=1; %Permeabilites relatives dans les milieux 1 et 2
mu_2=1;
mu =[mu_1 mu_2];

Freq = 33; %en kHz
t1 = 0;  %Epaisseur de la plaque conductrice en cm
l0 = 0;  %Distance capteur-cible en cm
val_integral =Z_integral(coil,Freq,t1,l0,sig,mu,cup);
