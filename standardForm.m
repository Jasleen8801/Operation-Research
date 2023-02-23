format short
clear
clc

C = [3 5];
A = [1 2; 1 1; 0 1];
b = [2000; 1500; 600];
IneqSign = [0 0 1];

% Create matrix S with -1 on rows where inequality sign is >=
S = eye(size(A,1));
S(IneqSign==1, :) = -S(IneqSign==1, :);

% Combine A, S, and b into a single matrix
Mat = [A, S, b];

% Create tables for objective function and constraints
objFn = array2table(C, 'VariableNames', {'x_1', 'x_2'});
Constraint = array2table(Mat, 'VariableNames', {'x_1','x_2','s_1','s_2','s_3','Sol'});

% Display tables
disp(objFn);
disp(Constraint);
