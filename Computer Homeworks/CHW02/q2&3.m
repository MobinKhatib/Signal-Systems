%% 2.2.1
clear;
clc;

syms s;
H1 = 1 / (s^3 + 40*s^2 + 10*s + 500);
H2 = 1 / (s^4 + 12.5*s^3 + 10*s^2 + 1);
H3 = 1 / (s^5 + 125*s^4 + 100*s^3 + 100*s^2 + 20*s +10);
H4 = 1 / (s^6 + +5*s^5 + 125*s^4 + 100*s^3 + 100*s^2 + 20*s +10);

[N1,D1] = numden(H1);
roots(sym2poly(D1))

if real(roots(sym2poly(D1))) < 0
   disp('H1 is stable');
else
   disp('H1 is not stable');
end
[N2,D2] = numden(H2);
roots(sym2poly(D2))

if real(roots(sym2poly(D2))) < 0
   disp('H2 is stable');
else
   disp('H2 is not stable');
end
[N3,D3] = numden(H3);
roots(sym2poly(D3))

if real(roots(sym2poly(D3))) < 0
   disp('H3 is stable');
else
   disp('H3 is not stable');
end
[N4,D4] = numden(H4);
roots(sym2poly(D4))

if real(roots(sym2poly(D4))) < 0
   disp('H4 is stable');
else
   disp('H4 is not stable');
end
pause;
%% 2.2.2
clear;
clc;
syms x ;
syms s ; 
H1 = 1 / (s^3 + 40*s^2 + 10*s + 500);
H2 = 1 / (s^4 + 12.5*s^3 + 10*s^2 + 1);
H3 = 1 / (s^5 + 125*s^4 + 100*s^3 + 100*s^2 + 20*s +10);
H4 = 1 / (s^6 + +5*s^5 + 125*s^4 + 100*s^3 + 100*s^2 + 20*s +10);
s1(x) = ilaplace(H1 / s, x);
s2(x) = ilaplace(H2 / s, x);
s3(x) = ilaplace(H3 / s, x);
s4(x) = ilaplace(H4 / s, x);

x_param = 0:0.1:40;
A1 = subplot(2,2,1);
plot(x_param, s1(x_param));
title(A1,'H1');
A2 = subplot(2,2,2);
plot(x_param, s2(x_param));
title(A2,'H2');
A3 = subplot(2,2,3);
plot(x_param, s3(x_param));
title(A3,'H3');
A4 = subplot(2,2,4);
plot(x_param, s4(x_param));
title(A4,'H4');
%% 2.2.4
clear;
clc;

syms s t;


G(s) = (s + 1) / (s^2 + 6*s + 8);
x1(t) = ilaplace(G(s), s, t);
x2(t) = ilaplace(G(s) / s, s, t);
x3(t) = ilaplace(G(s)/(s^2+9), s , t);
x4(t) = ilaplace(G(s)/(s+0.5), s , t);
x5(t) = ilaplace(G(s)/(s+0.2)/((s+0.2)^2+4), s , t);
x6(t) = ilaplace(G(s)/24/(s-0.5)^5, s , t);
x_param = 0:0.1:40;
A1 = subplot(3,2,1);
plot(x_param, x1(x_param));
title(A1,'x1');
A2 = subplot(3,2,2);
plot(x_param, x2(x_param));
title(A2,'x2');
A3 = subplot(3,2,3);
plot(x_param, x3(x_param));
title(A3,'x3');
A4 = subplot(3,2,4);
plot(x_param, x4(x_param));
title(A4,'x4');
A5 = subplot(3,2,5);
plot(x_param, x5(x_param));
title(A5,'x5');
A6 = subplot(3,2,6);
plot(x_param, x6(x_param));
title(A6,'x6');
%% 2.2.5
clear;
clc;

syms s a x;

G(s, a) = (2*s + 1) / (s^2 + a*s + 7);
h(x, a) = ilaplace(G(s, a), s, x);
s(x, a) = ilaplace(G(s, a) / s, s, x);

t = 0:0.01:20;
for i = 1:3
   subplot(3,2,2 * i - 1);
   plot(t, h(t, i + 3));
   xlabel(['h',i]);
   
   subplot(3,2,2 * i);
   plot(t, s(t, i + 3), 'r');
   xlabel(['s',i]);
   
   disp(['for a = ', num2str(i + 3), ':']);
   disp(vpa(limit(s(x, i + 3), inf)));
   S = vpa(solve(h(x, i + 3) == 0));
   time = vpa(real(S(2)));
   disp(time);
   m = vpa(s(time, i + 3));
   disp(m);
   half_time = vpa(solve(m/2 == s(x, i + 3)));
   disp(half_time);
end
pause;

%% 2.2.6
clear;
clc;

s = tf('s');
H1 = (s + 1) / (s^2 + 3*s + 4);
H2 = (s + 1) / (s^3 + 3*s^2 + 4*s);
H3 = (s + 1) / (s^4 + 3*s^3 + 4*s^2);
G1 = feedback(ss(H1), -1);
G2 = feedback(ss(H2), -1);
G3 = feedback(ss(H3), -1);
subplot(3,2,1);
step(G1);
subplot(3,2,3);
step(G2);
subplot(3,2,5);
step(G3);
subplot(3,2,2);
step(G1/s);
subplot(3,2,4);
step(G2/s);
subplot(3,2,6);
step(G3/s);
%% 2.3.1
clear;
clc;

syms s;

H = 1 / (s^2 + 2*s - 3);
[N,D] = numden(H);
roots(sym2poly(D))

if real(roots(sym2poly(D))) < 0
   disp('H is stable');
else
   disp('H is not stable');
end
pause;
%% 2.3.2
clear;
clc;
syms s;

H = (s^2 + 2*s - 3) / ((s^2 + 2*s - 3) + 1);
[N,D] = numden(H);
roots(sym2poly(D))

if real(roots(sym2poly(D))) < 0
   disp('H is stable');
else
   disp('H is not stable');
end

pause;
%% 2.3.3
clear;
clc;
syms s;
for k = -10 : 2 : 10
H = k*(s^2 + 2*s - 3) /(k*(s^2 + 2*s - 3) + 1);
[N,D] = numden(H);
roots(sym2poly(D))

if real(roots(sym2poly(D))) < 0
   disp('H is stable');
else
   disp('H is not stable');
end
end

%% 2.3.4
clear;
clc;
syms  s;
k = -50 : 1 : 50;
num=[k 2*k -3*k];

den=[k 2*k -3*k+1];

H=tf(num,den);

rlocus(H)
