function [out] = state_eqns_combined_3(in)
persistent p3

t=in(1);

if t==0
    p3 = evalin('base','p3');
end

u = in(2);
x = in(3:7);

out(1) = -u;
out(2) = -p3.lam2_p*x(2) + u;
out(3) = -p3.lam3_p*x(3) + u;
out(4) = -p3.lam2_n*x(4) + u;
out(5) = -p3.lam3_n*x(5) + u;


end