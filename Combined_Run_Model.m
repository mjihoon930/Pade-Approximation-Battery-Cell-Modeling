clear all
close all
clc

% Maps & Parameters
t = [0 10 2000];
u = [0 0 0];

t = [0 100 200 300 310 320 330 340 350 360 370 380 390 400 500 600 700 800 900 910 920 930 940 950 960 970 980 990 1000 1100 1200 1300 1400 1500 1600 1700 1800 1900 2000];
u = [1 -3 5 -2 3 2 -1 0 2 3 4 2 1 5 1 -1 3 -2 2 -4 -3 5 2 -1 -3 2 1 -4 2 1 2 5 -4 -3 1 2 -3 2 3];

%%Parameters
%Negative
n.L_n = 3.4*10^(-3);
n.R_n = 3.5*10^(-4);
n.e_n = 0.55;
n.c_max_n = 31.07*10^(-3);
n.theta_0n = 0;
n.theta_100n = 0.8;
n.A_n = 1818;
n.D_n = 5.29*10^-11;
n.R_film_n = 0.001;

%Positive
p.L_p = 7.0*10^(-3);
p.R_p = 3.65*10^(-6);
p.e_p = 0.41;
p.c_max_p = 22.806*10^(-3);
p.theta_0p = 0.76;
p.theta_100p = 0.03;
p.A_p = 1771;
p.D_p = 1.18*10^-14;
p.R_film_p = 0;

c.F = 96487;
c.T_ref = 298.15;
c.T_inf = 298.15;
c.R_c = 0;
c.R_u = 8.314;
c.c_e = 1.2*10^(-3);
c.k_ref_p = 1.0614*10^(-4);
c.k_ref_n = 0.079;
c.E_a_p = 25*10^(3);
c.E_a_n = 40*10^(3);


n_Li = p.e_p*p.A_p*p.L_p*p.theta_0p*p.c_max_p + n.e_n*n.A_n*n.L_n*n.theta_0n*n.c_max_n;
Q_nom =c.F*p.e_p*p.A_p*p.L_p*(p.theta_0p-p.theta_100p)*p.c_max_p;

%initial state
x1_initial = 0.5*Q_nom; % x = 0.5*Q_nom
x2p_initial = 0;
x2n_initial = 0;
x3p_initial = 0;
x3n_initial = 0;
x4p_initial = 0;
x4n_initial = 0;

%%Parameters

a_p = 3*p.e_p/p.R_p;
a_n = 3*n.e_n/n.R_n;
m_p = -1/(p.A_p*p.L_p*a_p*p.D_p*c.F);
m_n = 1/(n.A_n*n.L_n*a_n*n.D_n*c.F);

% 2nd-order
p2.a0_n = -3*n.D_n*m_n/n.R_n;
p2.a1_n = -2*m_n*n.R_n/7;
p2.b2_n = n.R_n^2/(35*n.D_n);
p2.a0_p = -3*p.D_p*m_p/p.R_p;
p2.a1_p = -2*m_p*p.R_p/7;
p2.b2_p = p.R_p^2/(35*p.D_p);

p2.lam2_n = 1/p2.b2_n;
p2.lam2_p = 1/p2.b2_p;

p2.beta1_n = p2.a0_n;
p2.beta2_n = -(p2.a0_n-p2.a1_n/p2.b2_n);
p2.beta1_p = p2.a0_p;
p2.beta2_p = -(p2.a0_p-p2.a1_p/p2.b2_p);

% 3rd-order
p3.a0_n = -3*n.D_n*m_n/n.R_n;
p3.a1_n = -4*m_n*n.R_n/11;
p3.a2_n = -m_n*n.R_n^3/(165*n.D_n);
p3.b2_n = 3*n.R_n^2/(55*n.D_n);
p3.b3_n = n.R_n^4/(3465*n.D_n^2);
p3.a0_p = -3*p.D_p*m_p/p.R_p;
p3.a1_p = -4*m_p*p.R_p/11;
p3.a2_p = -m_p*p.R_p^3/(165*p.D_p);
p3.b2_p = 3*p.R_p^2/(55*p.D_p);
p3.b3_p = p.R_p^4/(3465*p.D_p^2);

p3.lam2_n = -(-p3.b2_n/p3.b3_n + sqrt((p3.b2_n/p3.b3_n)^2 - 4*1/p3.b3_n))/2;
p3.lam3_n = -(-p3.b2_n/p3.b3_n - sqrt((p3.b2_n/p3.b3_n)^2 - 4*1/p3.b3_n))/2;
p3.lam2_p = -(-p3.b2_p/p3.b3_p + sqrt((p3.b2_p/p3.b3_p)^2 - 4*1/p3.b3_p))/2;
p3.lam3_p = -(-p3.b2_p/p3.b3_p - sqrt((p3.b2_p/p3.b3_p)^2 - 4*1/p3.b3_p))/2;

p3.beta1_n = p3.a0_n;
p3.beta2_n = 1/p3.b3_n*(p3.a0_n-p3.a1_n*p3.lam2_n+p3.a2_n*p3.lam2_n^2)/(-p3.lam2_n*(p3.lam3_n-p3.lam2_n));
p3.beta3_n = 1/p3.b3_n*(p3.a0_n-p3.a1_n*p3.lam3_n+p3.a2_n*p3.lam3_n^2)/(-p3.lam3_n*(p3.lam2_n-p3.lam3_n));
p3.beta1_p = p3.a0_p;
p3.beta2_p = 1/p3.b3_p*(p3.a0_p-p3.a1_p*p3.lam2_p+p3.a2_p*p3.lam2_p^2)/(-p3.lam2_p*(p3.lam3_p-p3.lam2_p));
p3.beta3_p = 1/p3.b3_p*(p3.a0_p-p3.a1_p*p3.lam3_p+p3.a2_p*p3.lam3_p^2)/(-p3.lam3_p*(p3.lam2_p-p3.lam3_p));

% 4th-order
p4.a0_n = -3*n.D_n*m_n/n.R_n;
p4.a1_n = -2*m_n*n.R_n/5;
p4.a2_n = -2*m_n*n.R_n^3/(195*n.D_n);
p4.a3_n = -4*m_n*n.R_n^5/(75075*n.D_n^2);
p4.b2_n = n.R_n^2/(15*n.D_n);
p4.b3_n = 2*n.R_n^4/(2275*n.D_n^2);
p4.b4_n = n.R_n^6/(675675*n.D_n^3);
p4.a0_p = -3*p.D_p*m_p/p.R_p;
p4.a1_p = -2*m_p*p.R_p/5;
p4.a2_p = -2*m_p*p.R_p^3/(195*p.D_p);
p4.a3_p = -4*m_p*p.R_p^5/(75075*p.D_p^2);
p4.b2_p = p.R_p^2/(15*p.D_p);
p4.b3_p = 2*p.R_p^4/(2275*p.D_p^2);
p4.b4_p = p.R_p^6/(675675*p.D_p^3);

p4.lam2_n = 20.2*n.D_n/n.R_n^2;
p4.lam3_n = 65.9*n.D_n/n.R_n^2;
p4.lam4_n = 508*n.D_n/n.R_n^2;
p4.lam2_p = 20.2*p.D_p/p.R_p^2;
p4.lam3_p = 65.9*p.D_p/p.R_p^2;
p4.lam4_p = 508*p.D_p/p.R_p^2;

p4.beta2_n = (p4.a0_n - p4.a1_n*p4.lam2_n + p4.a2_n*p4.lam2_n^2-p4.a3_n*p4.lam2_n^3)/(-p4.lam2_n*(p4.lam3_n-p4.lam2_n)*(p4.lam4_n-p4.lam2_n))/p4.b4_n;
p4.beta3_n = (p4.a0_n - p4.a1_n*p4.lam3_n + p4.a2_n*p4.lam3_n^2-p4.a3_n*p4.lam3_n^3)/(-p4.lam3_n*(p4.lam2_n-p4.lam3_n)*(p4.lam4_n-p4.lam3_n))/p4.b4_n;
p4.beta4_n = (p4.a0_n - p4.a1_n*p4.lam4_n + p4.a2_n*p4.lam4_n^2-p4.a3_n*p4.lam4_n^3)/(-p4.lam4_n*(p4.lam2_n-p4.lam4_n)*(p4.lam3_n-p4.lam4_n))/p4.b4_n;
p4.beta2_p = (p4.a0_p - p4.a1_p*p4.lam2_p + p4.a2_p*p4.lam2_p^2-p4.a3_p*p4.lam2_p^3)/(-p4.lam2_p*(p4.lam3_p-p4.lam2_p)*(p4.lam4_p-p4.lam2_p))/p4.b4_p;
p4.beta3_p = (p4.a0_p - p4.a1_p*p4.lam3_p + p4.a2_p*p4.lam3_p^2-p4.a3_p*p4.lam3_p^3)/(-p4.lam3_p*(p4.lam2_p-p4.lam3_p)*(p4.lam4_p-p4.lam3_p))/p4.b4_p;
p4.beta4_p = (p4.a0_p - p4.a1_p*p4.lam4_p + p4.a2_p*p4.lam4_p^2-p4.a3_p*p4.lam4_p^3)/(-p4.lam4_p*(p4.lam2_p-p4.lam4_p)*(p4.lam3_p-p4.lam4_p))/p4.b4_p;



%Run model
t_final = 2000;

sim('Combined_Pade_Model.slx',t_final)

save Pade_3.mat