%Output V
figure(1)
t=out.V.time;
y1=out.V.signals(1).values;
plot(t,y1)
title('Output V')
xlabel('time')
ylabel('Output Voltage')
hold on
y2=out.V.signals(2).values;
plot(t,y2)
y3=out.V.signals(3).values;
plot(t,y3)
hold off

legend('2nd-Order','3rd-Order', '4th-Order')

%Positive Surface Concentration
figure(2)

cp1=out.Cp.signals(1).values;
plot(out.V.time,cp1)
title('Positive electrode Surface Concentration')
xlabel('time')
ylabel('Cs,p')
hold on
cp2=out.Cp.signals(2).values;
plot(out.V.time,cp2)
cp3=out.Cp.signals(3).values;
plot(out.V.time,cp3)
hold off

legend('2nd-Order','3rd-Order', '4th-Order')

figure(3)

cn1=out.Cn.signals(1).values;
plot(out.V.time,cn1)
title('Negative electrode Surface Concentration')
xlabel('time')
ylabel('Cs,n')
hold on
cn2=out.Cn.signals(2).values;
plot(out.V.time,cn2)
cn3=out.Cn.signals(3).values;
plot(out.V.time,cn3)
hold off

legend('2nd-Order','3rd-Order', '4th-Order')

%X
figure(4)

x=out.X.signals.values;
plot(out.V.time,x)
title('Charge Level')
xlabel('time')
ylabel('X')

%current
figure(5)

i=out.I.signals.values;
plot(out.V.time,i)
title('Input Current')
xlabel('time')
ylabel('I')

