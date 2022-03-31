%% Rosenbrock function implementation
%% Author:  Pietro Mosca
%% Email:   pietromosca1994@gmail.com
%% Date:    20.09.2020
%% Reference: https://en.wikipedia.org/wiki/Rosenbrock_function

function [y]=rosenbrock(x)
d = length(x);
sum = 0;
for i = 1:(d-1)
	xi = x(i);
	xnext = x(i+1);
	new = 100*(xnext-xi^2)^2 + (xi-1)^2;
	sum = sum + new;
end
y = sum;
end