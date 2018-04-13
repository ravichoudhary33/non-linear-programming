clc
clear
close all
%% defining three hump camel function
three_hump_camel = @(X,Y) 2*X.^2 - 1.05*X.^4 + X.^6/6 + X.*Y + Y.^2;
%% surface ploting three hump camel function
[X,Y] = meshgrid(-5:.1:5, -5:.1:5);
Z = three_hump_camel(X,Y);
% display the surface plot of the function
figure(1)
surf(X,Y,Z)
title('surface plot of three hump camel functoin');
xlabel('x(1)');
ylabel('x(2)');
zlabel('threeHumpCamel');
shading interp
%% algorithm implementation
phi_ = @(x,r) 2*x(1)^2 - 1.05*x(1)^4 + (x(1)^6)/6 + x(1)*x(2) + x(2)^2 - r * (1/(-x(1)-5) + 1/(-x(2)-5) + 1/(x(1)-5) + 1/(x(2)-5));
% defining variables
r = 1000.0;
c = 0.01;
epsilon = 0.005;
options = optimoptions(@fminunc,'Algorithm','quasi-newton');
% display contour plot and converging points
figure(2)
contour(X,Y,Z);
title('contour of f(x,y) converges at black point');
xlabel('x(1)');
ylabel('x(2)');
shading interp
hold on
% declaring initial point x1
x1 = [-4.5, 2.5];
f1 = three_hump_camel(x1(1), x1(2));
scatter(x1(1),x1(2),'*');
iteration = 0;
% while function not converge keep iterating
while true
    iteration = iteration + 1;
    phi = @(x)phi_(x,r);   
    [x2,opt_phi] = fminunc(phi, x1, options);
    f2 = three_hump_camel(x2(1), x2(2));
    dx = x2 - x1;
    quiver(x1(1),x1(2),dx(1),dx(2),0);
    % convergence check
    if abs((f2 - f1)/f2) <= epsilon
        min_f = f2;
        x_star = x2;
        display('function Converged!');
        fprintf('Number of Iteration taken to converge = %i\n', iteration);
        fprintf('Minimum value of function = %f\n', min_f);
        display('Optimal point is');
        display(x_star);
        scatter(x_star(1),x_star(2),'k*');
        break
    end
    scatter(x2(1),x2(2),'*');
    r = c * r;
    x1 = x2;
    f1 = f2;
end
legend('contour','intermediate point','direction of minima');
hold off