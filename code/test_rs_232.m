%test

s = serial('COM1','BaudRate',19200,'Terminator','CR/LF'); %Create a serial port  
% s.Flow='none';

fopen(s);
fprintf(s,'*TRG');
fprintf(s,'OUTPUT,ON');
%fprintf(s,'IAI,MANUAL,INDUCTANCE,NORMAL');
fprintf(s,'FREQUE,330e3');
m =3;
for n = 1:m
    fprintf(s,'BEEP');
    pause(0.5);
end
fprintf(s,'LCR?');
val = fscanf(s)
%idn = fscanf(s);

fclose(s);

valnum = str2num(val);
%{
valnum(x) =

1 : freq   ||  2 : magnitude ch1  ||  3 : magnitude ch2  ||  5 : phase  ||
6 : resistance  ||  7 : Inductance  ||  9 : resistance parallel  ||  
10 : inductance parallel || 13 : Q factor
a
%}
