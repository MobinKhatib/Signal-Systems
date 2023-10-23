clear; clc; close all;



n = -35:1:100;

u = heaviside(n);
u30 = heaviside(n-30);
u30(66)=1;
u40 = heaviside(n-40);
u40(76)=1;
imshow(u);
u(36)=1;
%h1 = ((1/2).^n).*(heaviside(n))-(((1/2).^n).*heaviside(n-30));
h1 = ((1/2).^n).*(u)-(((1/2).^n).*u30);

%stem(n,x);
h2 = ((2).^n).*(u-u40);
h3 = ((1/2).^n).*u;
h4 = ((2).^n).*u;

%tiledlayout(3,1)




figure(1)
subplot(4,1,1)
stem(n,h1);
subplot(4,1,2)
stem(n,h2);
subplot(4,1,3)
stem(n,h3);
subplot(4,1,4)
stem(n,h4);

syms n2 
a=heaviside(n2)+0.5 *kroneckerDelta(n2);
a30 = heaviside(n2-30)+0.5 *kroneckerDelta(n2-30);
a40 = heaviside(n2-40)+0.5 *kroneckerDelta(n2-40);
a1 = heaviside(n2-1)+0.5 *kroneckerDelta(n2-1);


h1 = ((1/2)^n2).*(a)-(((1/2)^n2).*a30);
h2 = ((2)^n2)*(a-a40);
h3 = ((1/2)^n2)*a;
h4 = ((2)^n2)*a;



H1 = ztrans(h1);
H2 = ztrans(h2);
H3 = ztrans(h3);
H4 = ztrans(h4);



pretty(H1);
pretty(H2);
pretty(H3);
pretty(H4);


syms z;
figure(2)

subplot(4,1,1)
[m,d] = numden(H1);
soorat = sym2poly(m);
makhraj = sym2poly(d);
zplane(soorat,makhraj);
subplot(4,1,2)
[m,d] = numden(H2);
soorat = sym2poly(m);
makhraj = sym2poly(d);
zplane(soorat,makhraj);

subplot(4,1,3)
[m,d] = numden(H3);
soorat = sym2poly(m);
makhraj = sym2poly(d);
zplane(soorat,makhraj);

subplot(4,1,4)

[m,d] = numden(H4);
disp(m);
soorat = sym2poly(m);
disp(soorat);
makhraj = sym2poly(d);
zplane(soorat,makhraj);
%{
soorat = poly2sym(m);
makhraj = poly2sym(d);
zplane(m,d);
%}

%pretty(ztrans(a));


%nexttile
%plot(h1,n);



%nexttile
%plot(h2,n);

%nexttile
%plot(h3,n);
