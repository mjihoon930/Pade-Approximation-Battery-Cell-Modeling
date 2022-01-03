function C = output_C_3(in)

persistent F n_Li n p p3 c

t=in(1);

if t==0
    c = evalin('base','c');
   
    n_Li  = evalin('base','n_Li');
    n = evalin('base','n');
    p = evalin('base','p');
    p3 = evalin('base','p3');
end


x = in(2:6);

C_avg_p = (-1/(c.F*p.e_p*p.A_p*p.L_p))*x(1) + p.theta_0p*p.c_max_p;
C_avg_n = (1/(n.e_n*n.A_n*n.L_n))*(n_Li-(p.e_p*p.A_p*p.L_p*C_avg_p));

C(1) = C_avg_p + p3.beta2_p*x(2) + p3.beta3_p*x(3);
C(2) = C_avg_n + p3.beta2_n*x(4) + p3.beta3_n*x(5);

end