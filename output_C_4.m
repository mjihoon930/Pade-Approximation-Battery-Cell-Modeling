function C = output_C_4(in)

persistent  c  n_Li n p p4

t=in(1);

if t==0
    
    c = evalin('base','c');
    n_Li  = evalin('base','n_Li');
    n = evalin('base','n');
    p = evalin('base','p');
    p4 = evalin('base','p4');

end


x = in(2:8);

C_avg_p = (-1/(c.F*p.e_p*p.A_p*p.L_p))*x(1) + p.theta_0p*p.c_max_p;
C_avg_n = (1/(n.e_n*n.A_n*n.L_n))*(n_Li-(p.e_p*p.A_p*p.L_p*C_avg_p));

C(1) = C_avg_p + p4.beta2_p*x(2) + p4.beta3_p*x(3) + p4.beta4_p*x(4);
C(2) = C_avg_n + p4.beta2_n*x(5) + p4.beta3_n*x(6) + p4.beta4_n*x(7);



end