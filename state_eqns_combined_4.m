function [out] = state_eqns_combined_4(in)
persistent p4
t=in(1);

if t==0
    p4 = evalin('base','p4');
end

u = in(2);
x = in(3:9);

out(1) = -u;
out(2) = -p4.lam2_p*x(2) + u;
out(3) = -p4.lam3_p*x(3) + u;
out(4) = -p4.lam4_p*x(4) + u;
out(5) = -p4.lam2_n*x(5) + u;
out(6) = -p4.lam3_n*x(6) + u;
out(7) = -p4.lam4_n*x(7) + u;

end