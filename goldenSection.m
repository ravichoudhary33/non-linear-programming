clc
clear
close all
%% declaring ackely function
ackley = @(X,Y)-20 * exp(-0.2 * sqrt(0.5*(X.^2 + Y.^2))) - exp(0.5*(cos(2*pi*X) + cos(2*pi*Y))) + exp(1) + 20;

%% golden section implementation
% defining and declaring variables
a = -5.0;
b = 5.0;
x = a:0.1:b;
gammaInv = 0.618;
L0 = b - a;
L2_star = gammaInv.^2 * L0;
x1 = a + L2_star;
x2 = b - L2_star;
n = 10;

% ploting the function value with initial points
figure(1)
plot(x,ackley(x,0));
title('golden section method on ackley function initial situation');
xlabel('x');
ylabel('f');
hold on
plot(a,ackley(a,0),'*k');
plot(x1,ackley(x1,0),'*m');
plot(x2,ackley(x2,0),'*r');
plot(b,ackley(b,0),'*g');
legend('f','a','x1','x2','b');
hold off

figure(2)
plot(x,ackley(x,0));
title('golden section method on ackley function final situation');
xlabel('x');
ylabel('f');
hold on

for j = 1:n
   f1 = ackley(x1,0);
   f2 = ackley(x2,0);
   % checking unimodality condition and 
   % assigning new a,x1,x2 and b accordingly
   if f2 > f1
       x3 = a + (x2 - x1);
       b = x2;
       x2 = x1;
       x1 = x3;
   elseif f1 > f2
       x3 = x1 + (b - x2);
       a = x1;
       x1 = x2;
       x2 = x3;
   else
      a = x1;
      b = x2;
      L0 = b - a;
      L2_star = 0.382 * L0;
      x1 = a + L2_star;
      x2 = b - L2_star;
   end
end
% plot the final point along with their function value
plot(a,ackley(a,0),'*k');
plot(x1,ackley(x1,0),'*m');
plot(x2,ackley(x2,0),'*r');
plot(b,ackley(b,0),'*g');
legend('f','a','x1','x2','b');
hold off
% display the final interval
Ln = [a b];
display(Ln);