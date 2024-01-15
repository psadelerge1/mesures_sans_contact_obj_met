% Cr�ation du port s�rie
s = serial('COM1', 'BaudRate', 19200, 'Terminator', 'CR/LF'); 
fopen(s);
 
try
    % Configuration initiale
    fprintf(s, 'OUTPUT,ON');
    fprintf(s, 'FREQUE,700');
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
    Res = valnum(6) - 0.362;
    Ind = valnum(7);
    Z_mes = Res + Ind * omeg * 1j;
    
    % D�finition des constantes g�om�triques et mat�rielles
    r1 = 4.35;
    r2 = 8.25;
    l3 = 0.4;
    turn = 22;
    coil = [r1, r2, l3, turn];

    sigma = 0;
    mu_r = 1000;
    epaisseur = 0.4;
    l4 = 0;
    cup = [sigma, mu_r, epaisseur, l4];

    c1_1 = 58.2e6;
    c2 = 0;
    sig = [c1_1, c2];

    mu_1 = 1;
    mu_2 = 1;
    mu = [mu_1, mu_2];

    t1 = 25;
    l0 = 0;

    % Fonction d'optimisation
    f = @(c1) abs(Z_integral(coil, Freq/1000, t1, l0, [c1, 0], mu, cup) - Z_mes)^2;
    fun = @(c1) f(c1);

    % Param�tres d'optimisation
    c1_0 = 5e6;
    options = optimset('PlotFcns', @optimplotfval, 'MaxIter', 15);
    sig_freq =8e9;

    % Optimisation
    %c_res= fminsearch(fun,c1_0,options)

    % Calcul de la nouvelle fr�quence en fonction de la conductivit� optimale
   % N_Freq = sig_freq/c_res

    % R�ouverture du port s�rie pour la nouvelle configuration
    fopen(s);
options = optimset('PlotFcns',@optimplotfval,'MaxIter',5);
    for c = 1:5
        N_Freq = sig_freq/c_res
        fprintf(s, ['FREQUE,', num2str(N_Freq)]);
        fprintf(s, '*TRG');
        pause(2);
        fprintf(s, 'LCR?');
        pause(2);
    
        % Mise � jour de la fr�quence
        fprintf(s, ['FREQUE,', num2str(N_Freq)]);
        fprintf(s, '*TRG');
        pause(2);
        fprintf(s, 'LCR?');
        pause(2);

        % Nouvelle lecture des donn�es
        val = fscanf(s);
        valnum = str2num(val);

        omeg = 2 * pi * N_Freq;
        Res = valnum(6) - 0.362;
        Ind = valnum(7);
        Z_mes_2 = Res + Ind * omeg * 1j;

        % Nouvelle fonction d'optimisation
        f2 = @(c1) abs(Z_integral(coil, N_Freq/1000, t1, l0, [c1, 0], mu, cup) - Z_mes_2)^2;
        fun_2 = @(c1) f2(c1);

        % Optimisation pour la nouvelle fr�quence
        c_res = fminsearch(fun_2, c1_0, options)
        
        
    end
    a='fin'
    %{
    % Mise � jour de la fr�quence
    fprintf(s, ['FREQUE,', num2str(N_Freq)]);
    fprintf(s, '*TRG');
    pause(2);
    fprintf(s, 'LCR?');
    pause(2);

    % Nouvelle lecture des donn�es
    val = fscanf(s);
    valnum = str2num(val);

    omeg = 2 * pi * N_Freq;
    Res = valnum(6) - 0.362;
    Ind = valnum(7);
    Z_mes_2 = Res + Ind * omeg * 1j;

    % Nouvelle fonction d'optimisation
    f2 = @(c1) abs(Z_integral(coil, N_Freq/1000, t1, l0, [c1, 0], mu, cup) - Z_mes_2)^2;
    fun_2 = @(c1) f2(c1);

    % Optimisation pour la nouvelle fr�quence
    c_res_2 = fminsearch(fun_2, c1_0, options)

    % Fermeture du port s�rie
    %}
    fclose(s);
    
    
catch
    disp('Erreur lors de la communication s�rie ou de l''optimisation.');
    fclose(s); % Fermeture du port s�rie en cas d'erreur
end
