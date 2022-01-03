function [out] = state_eqns_combined_2(in)
persistent p2
t=in(1);

if t==0
    p2 = evalin('base','p2');
end

u = in(2);
x = in(3:5);

out(1) = -u;
out(2) = -p2.lam2_p*x(2) + u;
out(3) = -p2.lam2_n*x(3) + u;

end