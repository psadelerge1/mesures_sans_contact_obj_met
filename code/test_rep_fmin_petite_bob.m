% Création du port série
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
      
    
    % Fermeture du port série
    fclose(s);

    % Conversion de la chaîne reçue en valeurs numériques
    valnum = str2num(val);
    
    Freq = valnum(1);
    omeg = 2 * pi * Freq;
    Res = valnum(6) - 0.362;
    Ind = valnum(7);
    Z_mes = Res + Ind * omeg * 1j;
    
    % Définition des constantes géométriques et matérielles
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

    % Paramètres d'optimisation
    c1_0 = 5e6;
    options = optimset('PlotFcns', @optimplotfval, 'MaxIter', 15);
    sig_freq =8e9;

    % Optimisation
    %c_res= fminsearch(fun,c1_0,options)

    % Calcul de la nouvelle fréquence en fonction de la conductivité optimale
   % N_Freq = sig_freq/c_res

    % Réouverture du port série pour la nouvelle configuration
    fopen(s);
options = optimset('PlotFcns',@optimplotfval,'MaxIter',5);
    for c = 1:5
        N_Freq = sig_freq/c_res
        fprintf(s, ['FREQUE,', num2str(N_Freq)]);
        fprintf(s, '*TRG');
        pause(2);
        fprintf(s, 'LCR?');
        pause(2);
    
        % Mise à jour de la fréquence
        fprintf(s, ['FREQUE,', num2str(N_Freq)]);
        fprintf(s, '*TRG');
        pause(2);
        fprintf(s, 'LCR?');
        pause(2);

        % Nouvelle lecture des données
        val = fscanf(s);
        valnum = str2num(val);

        omeg = 2 * pi * N_Freq;
        Res = valnum(6) - 0.362;
        Ind = valnum(7);
        Z_mes_2 = Res + Ind * omeg * 1j;

        % Nouvelle fonction d'optimisation
        f2 = @(c1) abs(Z_integral(coil, N_Freq/1000, t1, l0, [c1, 0], mu, cup) - Z_mes_2)^2;
        fun_2 = @(c1) f2(c1);

        % Optimisation pour la nouvelle fréquence
        c_res = fminsearch(fun_2, c1_0, options)
        
        
    end
    a='fin'
    %{
    % Mise à jour de la fréquence
    fprintf(s, ['FREQUE,', num2str(N_Freq)]);
    fprintf(s, '*TRG');
    pause(2);
    fprintf(s, 'LCR?');
    pause(2);

    % Nouvelle lecture des données
    val = fscanf(s);
    valnum = str2num(val);

    omeg = 2 * pi * N_Freq;
    Res = valnum(6) - 0.362;
    Ind = valnum(7);
    Z_mes_2 = Res + Ind * omeg * 1j;

    % Nouvelle fonction d'optimisation
    f2 = @(c1) abs(Z_integral(coil, N_Freq/1000, t1, l0, [c1, 0], mu, cup) - Z_mes_2)^2;
    fun_2 = @(c1) f2(c1);

    % Optimisation pour la nouvelle fréquence
    c_res_2 = fminsearch(fun_2, c1_0, options)

    % Fermeture du port série
    %}
    fclose(s);
    
    
catch
    disp('Erreur lors de la communication série ou de l''optimisation.');
    fclose(s); % Fermeture du port série en cas d'erreur
end
