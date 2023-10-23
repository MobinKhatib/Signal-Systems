clear; clc; close all;
syms z;
X1z = (2-z^-1)./((1-(0.7.*z^-1)+0.49.*z^-2));


[m,d] = numden(X1z);
soorat = sym2poly(m);
makhraj = sym2poly(d);
[r,p,k] = residue(soorat,makhraj);

con = 100;
%syms n2 
%a1=heaviside(n2-1)+0.5 *kroneckerDelta(n2-1);
n = -con:1:con;

%stem(n,hn);

 x = heaviside(n-1);
 x (con+2) = 1;
 stem(n,x);
 
 
hn = (((0.35+0.6.*1i).^(n-1)).*(0.2+0.69.*1i)+ ((0.35-0.6.*1i).^(n-1)).*(0.2-0.69.*1i)  ).*x; 
 figure(1)
stem(n,hn);

%3_4_2

figure(2)
[m,d] = numden(X1z);
soorat = sym2poly(m);
makhraj = sym2poly(d);
x = (n==0);
h2n = filter(soorat,makhraj,x);
stem(n,h2n,'blue');

%h2n = filter(soorat,makhraj,
%{
Htest = z./(z-0.5);
[m,d] = numden(Htest);
soorat = sym2poly(m);
makhraj = sym2poly(d);
x = (n==0);
htest = filter(soorat,makhraj,x);
stem(n,htest,'red');
%}

