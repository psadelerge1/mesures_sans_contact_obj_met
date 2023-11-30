%--------------------------------------------------------- 
% calcul de l'impedance d'une une bobine circulaire en presence de
% materiaux plans.
% echelonement des milieux (de haut en bas):
% air,cup,air,bobine,air,milieux 1,milieux 2 
%---------------------------------------------------------
% z = z(coil,Freq,t1,l0,sig,mu,cup)
% z      :    vecteur de sortie, de dimension (nFreq)
% coil   :    Dimensions geometriques de la bobine d'excitation
%              r1  = coil[0];      rayon interieur bobine
%	       r2 = coil[1];      rayon exterieur bobine
%              l3 = coil[2];      hauteur bobine
%              turn = coil[3];    nombre de spires
% Freq   :   Frequence d'excitation exprimees en kHz (vecteur)
% t1     :   Epaisseur de la plaque conductrice (milieu 1)
% l0     :   Distance capteur-cible
% sig    :   Conductivites dans les milieux 1 et 2
% mu     :   Permeabilites relatives dans les milieux 1 et 2
% cup    :   Dimension et constitution du couvercle en ferrite
%              sigma = cup[1];    conductivite du couvercle
%              mu_r = cup[2];     permeabilite du couvercle
%              epaisseur=cup[3];  epaisseur du couvercle
%              l4 = cup[4];       distance bobine au couvercle
%---------------------------------------------------------
% Yann Le Bihan (a partir du programme de Nadia Madaoui ARZ_AIR.m)
% Mise a jour : 14/01/99

	function z = Z_integral(coil,Freq,t1,l0,sig,mu,cup)
echo off
format long
% DIMENSIONS GEOMETRIQUES DE LA BOBINE
 r1 = coil(1);	r2 = coil(2);	l3 = coil(3); turn  = coil(4);

% CONSTANTES CONSTITUTIVES DU VIDE
 eps0 = 1/ (36*pi) *1E-9; % Permittivité du vide
 mu0  = 4.0E-7*pi;  
 j=sqrt(-1); %pas besoin 
%----------------------------------------------------------
% Normalisation des grandeurs geometriques  §§§§§
  rbar =0.5*(r1+r2);  %§
  r1=r1/rbar;		r2=r2/rbar; l3=l3/rbar;  %for nor,al
  l0=l0/rbar;		t1=t1/rbar;
  thick4n = cup(3)/rbar; l4=cup(4)/rbar;
%----------------------------------------------------------
% Constantes de propagation pour toutes les frequences
  puls = 2*pi*Freq*1000;  %w
  csten = rbar*rbar*1E-6; % §§§
  w2ue0 = csten*puls.*puls*mu0*eps0;
  wusr1 = csten*puls*mu0*sig(1);
  wusr3 = csten*puls*mu0*sig(2);
  wusr4 = csten*puls*mu0*cup(1);

  k12   = mu(1)*(w2ue0 +j*wusr1);
  k32   = mu(2)*(w2ue0 +j*wusr3);
   k42   = cup(2)*(w2ue0 +j*wusr4);

% initialisations
  z=zeros(length(Freq),1);

% pas de calcul de X
   s1 = [.01,.05,0.1,0.2,0.5,1.0];
  % s1 = [.005,.01,0.01,0.01,0.1,0.1];
% bornes superieures des intervalles de X
  s2 = [3.0,9.0,29.0,59.0,100.0,200.0];

x=[]; dx=[]; b2=0.0;
for k=1:length(s1);
    pas=s1(k); b1 = b2 + 0.5*pas; b2 = s2(k);
    xk = [b1:pas:b2]; 	dxk = pas*ones(size(xk));
    x=[x,xk];		dx = [dx,dxk];
end

%--------------------------------------------------- 
%  [xjr2m1,y2] = ijbessel(x, r1, r2);

 
 %  xjr2m1 : vecteur de taille identique �  x
 % xjr2m1 = (1/x^3) * integrale( J1(z) z dz )
 %		dans l'intervalle  [z1=x*r1 , z2=x*r2]
 f = @(zz) besselj(1,zz).*zz;
 size(x);
 for k=1:length(x) 
%   xjr2m1(k) = (1/x(k)^3)* (-0.5.*pi.*(x(k)*r2.*((besselj(0,x(k)*r2).*StruveH1(x(k)*r2)-besselj(1,x(k)*r2).*StruveH0(x(k)*r2)))-x(k)*r1.*((besselj(0,x(k)*r1).*StruveH1(x(k)*r1)-besselj(1,x(k)*r1).*StruveH0(x(k)*r1)))));
%   (-0.5.*pi.*(a.*2.*((besselj(0,a.*2).*StruveH1(a.*2)-besselj(1,a.*2).*StruveH0(a.*2)))-a.*((besselj(0,a).*StruveH1(a)-besselj(1,a).*StruveH0(a)))))

 xjr2m1(k) = (1/x(k)^3)*integral(f,x(k)*r1,x(k)*r2,'RelTol',1e-12,'AbsTol',1e-12);
%   on utilise le fonction integral de Matlab.
 end     
 
%  figure 
%  plot(x,'+-')
%  figure
%   plot(x,xjr2m1,'+-')
  
 tt1 = turn/((r2-r1)*l3);  % n/.... 
 cste = j*puls*2*pi*mu0*tt1^2*rbar*1E-3;
%------------------------------------------------------

 xx = x.*x;
 
for jfreq=1:length(Freq)
    %fprintf('.');
    x0 = sqrt(xx-w2ue0(jfreq));
    x1 = sqrt(xx-k12(jfreq));
    x3 = sqrt(xx-k32(jfreq));
    x4 = sqrt(xx-k42(jfreq));

    y1 = x1/(mu(1));
    y3 = x3/(mu(2));      %
    y4 = x4/(cup(2));


   % /*  coefficients de reflexion		
   r01 = (x0-y1)./(x0+y1);
   r13 = (y1-y3)./(y1+y3);
   r04 = (x0-y4)./(x0+y4);

   exp_x4 = exp(-2*x4*thick4n);
   p21 = exp_x4 - 1;
   p11 = (r04.^2.*exp_x4) - 1;
   q10 = r04 .* (p21./p11) .* exp(-2*x0*(l0+l3+l4));

   xt1 = 2*x1*t1;
   exp_x1 = exp(-xt1);
   p12  = 1   + (r01.*r13.*exp_x1);
   p22  = r01 + r13.*exp_x1;
   s10 = p22./p12;
   
   expl03 = exp(x0*(l0+l3));
   exp_l03 = exp(-x0*(l0+l3));
   exp2l03 = exp(2*x0*(l0+l3));
   exp_2l03 = exp(-2*x0*(l0+l3));
   expl0 = exp(x0*l0);
   exp_l0 = exp(-x0*l0);
   exp2l0 = exp(2*x0*l0);
   exp_2l0 = exp(-2*x0*l0);

   % /* Calcul de z

   D =x0.*(1 - (q10.*s10));
   N1=(q10.*expl03-exp_l03).*(s10.*exp_l0-expl0)-(1+q10.*s10);
   N2 = q10.*(exp2l03+exp2l0)+s10.*(exp_2l03+exp_2l0);
  
   s5 = x./x0; 
   s5 = x .* s5 .* s5 .* xjr2m1 .* xjr2m1;
   s5 = s5 .* dx;
   size(s5);

   T=s5*(l3+(N1./D)+(N2./(2*D)))';
   
  z(jfreq) = cste(jfreq) * T;

end  %(for jfreq)