function varargout = Interface2(varargin)
% INTERFACE2 MATLAB code for Interface2.fig
%      INTERFACE2, by itself, creates a new INTERFACE2 or raises the existing
%      singleton*.
%
%      H = INTERFACE2 returns the handle to a new INTERFACE2 or the handle to
%      the existing singleton*.
%
%      INTERFACE2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INTERFACE2.M with the given input arguments.
%
%      INTERFACE2('Property','Value',...) creates a new INTERFACE2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Interface2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Interface2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Interface2

% Last Modified by GUIDE v2.5 21-Dec-2023 08:33:01.

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Interface2_OpeningFcn, ...
                   'gui_OutputFcn',  @Interface2_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

s = serial('COM1','BaudRate',19200,'Terminator','CR/LF'); %Create a serial port 

% --- Executes just before Interface2 is made visible.
function Interface2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Interface2 (see VARARGIN)

% Choose default command line output for Interface2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Interface2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Interface2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
s = serial('COM1','BaudRate',19200,'Terminator','CR/LF');  
fopen(s);
fprintf(s,'*TRG');
fprintf(s,'OUTPUT,ON');
Freq_str =3.3e3;
fprintf(s,'*TRG');
fprintf(s,'OUTPUT,ON');
fprintf(s,['FREQUE,', num2str(Freq_str)]);
fprintf(s,'LCR?');
fclose(s);
msgbox('Réglage PSM OK')

function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double



% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
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

fclose(s); %Fermeture de la liaison avce le PSM et IAI

set(handles.edit5,'string',valnum(7)); %Attribue les valeurs de l'inductance du PSM sur les "EDIT" pour l'affichage 
pause(0.5);%Attente de 0.5 secondes 
set(handles.edit6,'string',valnum(6));%Attribue les valeurs de la resistance du PSM sur les "EDIT" pour l'affichage 
pause(0.5);%Attente de 0.5 secondes 
set(handles.edit8,'string',c_res_2);%Attribue les valeurs de la conductivite du PSM sur les "EDIT" pour l'affichage 
pause(0.5);%Attente de 0.5 secondes 
set(handles.edit9,'string',N_Freq(1));%Attribue les valeurs de la fréquence du PSM sur les "EDIT" pour l'affichage 


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
s = serial('COM1','BaudRate',19200,'Terminator','CR/LF'); %Créer un port COM1 à un débit de 19200 bauds
fopen(s); % Ouverture de la laisaion 

fprintf(s,'*TRG');%Configure TRG du PSM
fprintf(s,'OUTPUT,ON'); %Configure OUTPUT du PSM
fprintf(s,'LCR?');%Configure LCR du PSM
fprintf(s,'*TRG');
fprintf(s,'OUTPUT,ON');
fprintf(s,'LCR?');

val = fscanf(s);
valnum = str2num(val);

r1  = 4.35;        %Rayon interieur bobine 
r2  = 8.25;       %Rayon exterieur bobine 

l3      = 0.4;   %Hauteur bobine 
turn    = 22;     %Nombre de spires
coil = [r1 r2 l3 turn];

sigma     = 0;     %conductivite du couvercle
mu_r      = 1000;     %Permeabilite du couvercle
epaisseur = 0.4;     %Epaisseur du couvercle
l4        = 0;     %Distance bobine au couvercle
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

fclose(s); %Fermeture de la liaison avce le PSM et IAI

set(handles.edit5,'string',valnum(7)); %Attribue les valeurs de l'inductance du PSM sur les "EDIT" pour l'affichage 
pause(0.5);%Attente de 0.5 secondes 
set(handles.edit6,'string',valnum(6));%Attribue les valeurs de la resistance du PSM sur les "EDIT" pour l'affichage 
pause(0.5);%Attente de 0.5 secondes 
set(handles.edit8,'string',c_res_2);%Attribue les valeurs de la conductivite du PSM sur les "EDIT" pour l'affichage 
pause(0.5);%Attente de 0.5 secondes 
set(handles.edit9,'string',N_Freq(1));%Attribue les valeurs de la fréquence du PSM sur les "EDIT" pour l'affichage


function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
