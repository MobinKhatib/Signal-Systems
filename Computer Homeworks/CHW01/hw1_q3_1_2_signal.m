clear; clc; close all;

syms z k;
n = -35:1:100;

u = heaviside(n);
u(36)=1;

X1 = 1./(1-0.5./z);
X2 = 1./(1-(1.1)./z);
X3 = 1./(1-(1)./z);
X4 = 1./(1-(0.9)./z);
X5 = 1./(1-(5)./z);
X6 = 1./(1-(1)./z).^2;

figure(1);

subplot(6,2,1)
[m,d] = numden(X1);
soorat = sym2poly(m);
makhraj = sym2poly(d);
zplane(soorat,makhraj);

subplot(6,2,2)

[m,d] = numden(X2);
soorat = sym2poly(m);
makhraj = sym2poly(d);
zplane(soorat,makhraj);

subplot(6,2,3)

[m,d] = numden(X3);
soorat = sym2poly(m);
makhraj = sym2poly(d);
zplane(soorat,makhraj);

subplot(6,2,4)

[m,d] = numden(X4);
soorat = sym2poly(m);
makhraj = sym2poly(d);
zplane(soorat,makhraj);

subplot(6,2,5)

[m,d] = numden(X5);
soorat = sym2poly(m);
makhraj = sym2poly(d);
zplane(soorat,makhraj);

subplot(6,2,6)

[m,d] = numden(X6);
soorat = sym2poly(m);
makhraj = sym2poly(d);
zplane(soorat,makhraj);



subplot(6,2,7)
x1 = iztrans(X1);
%x1 = iztrans(X1, z, k);
%gn = double( subs(x1, sym('k'), k) );
%stem(gn, k)
stem(0.5.^n.*u);
disp("x1");
disp(x1);
subplot(6,2,8)
x2 = iztrans(X2);
stem((11./10).^n.*u);
disp("x2");
disp(x2);
subplot(6,2,9)
x3 = iztrans(X3);
stem(1.*u);
disp("x3");
disp(x3);
subplot(6,2,10)
x4 = iztrans(X4);
stem(0.9.^n.*u);
disp("x4");
disp(x4);
subplot(6,2,11)
x5 = iztrans(X5);
stem(5.^n.*u);
disp("x5");
disp(x5);
subplot(6,2,12)
x6 = iztrans(X6);

stem((1+n).*u);
disp("x6");
disp(x6);




% 3_1_3

X7 = 1./(1-(sqrt(2)./z)+1./(z).^2);
X8 = 1./(1-(1./z)+2./(z).^2);
X9 = 1./(2-(1./z)+1./(z).^2);
%

figure(2);

subplot(3,1,1)
[m,d] = numden(X7);
soorat = sym2poly(m);
makhraj = sym2poly(d);
zplane(soorat,makhraj);

subplot(3,1,2)

[m,d] = numden(X8);
soorat = sym2poly(m);
makhraj = sym2poly(d);
zplane(soorat,makhraj);

subplot(3,1,3)

[m,d] = numden(X9);
soorat = sym2poly(m);
makhraj = sym2poly(d);
zplane(soorat,makhraj);


%%%%%%%%%%%%%
x7 = iztrans(X7);
disp(x7);
x8 = iztrans(X8);
disp(x8);
x9 = iztrans(X9);
disp(x9);
