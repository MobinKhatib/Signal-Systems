clear; clc; close all;
syms z;
%./(1-(sqrt(2)./z)+1./(z).^2);
H1 = (1-1./z)./((1-(1./z)+(0.5)./((z).^2)));
H2 = (1./z)./((1-(1./z)+(0.5)./(z).^2));

figure(1)
subplot(2,1,1)
[m,d] = numden(H1);
soorat = sym2poly(m);
makhraj = sym2poly(d);
zplane(soorat,makhraj);


subplot(2,1,2)
[m,d] = numden(H2);
soorat = sym2poly(m);
makhraj = sym2poly(d);
zplane(soorat,makhraj);


%3_3_2

[m,d] = numden(H1);
soorat = sym2poly(m);
makhraj = sym2poly(d);
[r1,p1,k1] = residuez(soorat,makhraj);

disp('r1');
disp(r1);

disp('k1');
disp(k1);

disp('p1');
disp(p1);
[m,d] = numden(H2);
soorat = sym2poly(m);
makhraj = sym2poly(d);
[r2,p2,k2] = residuez(soorat,makhraj);

disp('r2');
disp(r2);

disp('k2');
disp(k2);

disp('p2');
disp(p2);


%%%%%%%%%%%
pretty(iztrans(H1));
pretty(iztrans(H2));
