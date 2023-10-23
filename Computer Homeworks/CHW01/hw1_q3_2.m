clear; clc; close all;
syms n z;
a=heaviside(n)+0.5 *kroneckerDelta(n);
n3 = -35:1:100;

u = heaviside(n3);
u(36)=1;

x = cos((n.*pi)./6);
X0z = ztrans(x);
n2 = -50:1:50;



figure(1)
subplot(2,1,1)
stem(n2,cos((n2.*pi)./6));

subplot(2,1,2)
[m,d] = numden(X0z);
soorat = sym2poly(m);
makhraj = sym2poly(d);
zplane(soorat,makhraj);

disp("X0z");
disp(X0z);

%3_2_2 ************************************

X1z = ztrans(x,n,2.*z);



figure(2)

subplot(2,1,1)
[m,d] = numden(X1z);
soorat = sym2poly(m);
makhraj = sym2poly(d);
zplane(soorat,makhraj);
pretty(iztrans(X1z));
subplot(2,1,2)
stem((((-1).^n3)./(2.^n3)).*cos((5.*pi.*n3)./6));


%3_2_3 **************************************
X2z = ztrans(x,n,z.^3);
figure(3)
subplot(2,1,1)
[m,d] = numden(X1z);
soorat = sym2poly(m);
makhraj = sym2poly(d);
zplane(soorat,makhraj);
disp(iztrans(X2z));

%subplot(2,1,2)
%{
syms z k;
x2z = iztrans(X2z, z, k);
gn = double( subs(x2z, sym('k'), k) );
stem(gn, k);
%}
%x2z = iztrans(X2z);
%plot(x2z);