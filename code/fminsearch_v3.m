% Cr�ation du port s�rie
s = serial('COM1', 'BaudRate', 19200, 'Terminator', 'CR/LF'); 
fopen(s);

try
    % Configuration du dispositif externe
    fprintf(s, 'OUTPUT,ON');
    fprintf(s, 'FREQUE,1.953437500000000e+04');
    pause(2);
    fprintf(s, '*TRG');
    pause(2);
    fprintf(s, 'LCR?');
    val = fscanf(s);
    
    % Fermeture du port s�rie
    fclose(s);

    % Conversion de la cha�ne re�ue en valeurs num�riques
    valnum = str2num(val);
    Freq = valnum(1);
    omeg = 2 * pi * Freq;
    Res = valnum(6) - 0.075;
    Ind = valnum(7);
    Z_mes = Res + Ind * omeg * 1j;

    % D�finition des constantes g�om�triques et mat�rielles
    r1 = 10.23;
    r2 = 21.315;
    l3 = 2.45;
    turn = 20;
    coil = [r1, r2, l3, turn];

    sigma = 0;
    mu_r = 1000;
    epaisseur = 2.21;
    l4 = 0.1;
    cup = [sigma, mu_r, epaisseur, l4];

    c1_1 = 20.1e6;
    c2 = 0;
    sig = [c1_1, c2];

    mu_1 = 1;
    mu_2 = 1;
    mu = [mu_1, mu_2];

    t1 = 25;
    l0 = 0;

    % Fonction d'optimisation
    f = @(c1) abs(Z_integral(coil, Freq / 1000, t1, l0, [c1, 0], mu, cup) - Z_mes);
    fun = @(c1) f(c1);

    % Param�tres d'optimisation
    c1_0 = 5e6;
    options = optimset('PlotFcns', @optimplotfval, 'MaxIter', 15);

    % Optimisation
    c_res = fminsearch(fun, c1_0, options);

    % Affichage des r�sultats
    disp('R�sultats de l''optimisation :');
    disp(['Conductivit� optimale : ']);
    c_res
    disp(['Fr�quence : ', num2str(Freq)]);
    disp(['Conductivit� initiale : ', num2str(c1_1)]);

catch
    disp('Erreur lors de la communication s�rie ou de l''optimisation.');
    fclose(s); % Fermeture du port s�rie en cas d'erreur
end