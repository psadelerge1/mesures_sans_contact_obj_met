s = serial('COM1','BaudRate',19200,'Terminator','CR/LF'); %Créer un port COM1 à un débit de 19200 bauds
fopen(s); % Ouverture de la laisaion 

fprintf(s,'*TRG');%Configure TRG du PSM
fprintf(s,'OUTPUT,ON'); %Configure OUTPUT du PSM
fprintf(s,'LCR?');%Configure LCR du PSM
val = fscanf(s);
valnum = str2num(val);

r1  = 10.23;        %Rayon interieur bobine d = 20.46
r2  = 21.315;       %Rayon exterieur bobine d = 42.63 mm
l3      = 2.45;   %Hauteur bobine 
turn    = 20;     %Nombre de spires
coil = [r1 r2 l3 turn];
sigma     = 0;     %Conductivite du couvercle
mu_r      = 1000;     %Permeabilite du couvercle
epaisseur = 2.21;     %Epaisseur du couvercle
l4        = 0.1;     %Distance bobine au couvercle
cup =[sigma,mu_r,epaisseur,l4];


c1_1=0.61e6; %Conductivites m1
c2 = 0 ; %Conductivites m2
sig = [c1_1 c2];%////
mu_1=1; %Permeabilites relatives dans les milieux 1 et 2
mu_2=1;%////
mu =[mu_1 mu_2];

choice = menu('Regler :','Hauteur'); %Affichage de la fenetre "REGLER"
prompt = {'Hauteur en mm :'}; %Affichage du texte sur la fenetre precedente
dlg_title = 'Input'; %Creation d'une entrer de valeurs 
num_lines = 1; %Valeurs sur 1 ligne 
answer = inputdlg(prompt,dlg_title,num_lines);
x = answer{1}; %Attribue X a la valeurs ecrite 

t1=str2num(x);%Epaisseur de la plaque conductrice en mm avec conversion d'un string en valeur numérique 
l0 = 0;  %Distance capteur-cible en mm

Freq = valnum(1);%On récup val IAI
omeg = 2*pi*Freq;%Formule de la pulsation
Res  = valnum(6)-0.075;%Attribue la valeurs de la ressiatnce du PSM a la variable Res 
Ind  = valnum(7); %Atribue la valeur de l'inductance du PSM a la variable Ind
Z_mes = Res+Ind*omeg*j; %Formule de la conductivite mesure
sig_freq=1.900666666666667e+10;
f=@(c1)abs(Z_integral(coil,Freq/1000,t1,l0,[c1,0],mu,cup)-Z_mes)^2;
fun = @(c1)f(c1);

c1_0=5e6;
f1_0 = 3.5e3;

options = optimset('PlotFcns',@optimplotfval,'MaxIter',10); %Limite le nombre ittération pendant les mesures 
c_res= fminsearch(fun,c1_0,options)%Ajuste les paramètres en fonction des mesures obtenues
N_Freq=sig_freq/c_res;

fprintf(s,['FREQUE,', num2str(N_Freq)]); %Affichage de la frequence apres optimisation
fprintf(s,'*TRG');%Configure TRG du PSM
pause(2); %Attente de 2 secondes 
fprintf(s,'LCR?'); %Configure LCR du PSM

val = fscanf(s);
valnum = str2num(val); %Conversion d'un string en valeur numérique 

omeg = 2*pi*N_Freq; %Formule de la pulsation
Res  = valnum(6)-0.075;%Attribue la valeurs de la ressiatnce du PSM a la variable Res 
Ind  = valnum(7); %Attribue la valeurs de l'inductance du PSM a la variable Ind 
Z_mes_2 = Res+Ind*omeg*j;%Formule de la conductivite mesure une deuxieme fois 
f2=@(c1)abs(Z_integral(coil,N_Freq/1000,t1,l0,[c1,0],mu,cup)-Z_mes_2)^2;
fun_2 = @(c1)f2(c1);
c_res_2= fminsearch(fun_2,c1_0,options)%Ajuste les paramètres en fonction des mesures obtenues une deuxieme fois
cond=1.4e6

fclose(s);