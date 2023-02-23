clear all;
clc;

C = [2 3 4 7];
A = [2 3 -1 4; 1 -2 6 -7];
b = [8; -3];

m = size(A,1); %no of constraints
n = size(A,2); %no of variables

if n>=m
    nv = nchoosek(n,m); % total no of basic solutions
    t = nchoosek(1:n,m); % pairs of basic solution
    
    sol = zeros(n, nv); % preallocate the matrix
    
    for i=1:nv
        sol(t(i,:),i) = A(:,t(i,:))\b;
    end
    
    % check feasibility condition
    feasible = (sol>=0 & sol~=inf & sol~=-inf);
    feasible = all(feasible, 1);
    sol = sol(:, feasible);
    
    %objective function
    Z = C * sol;

    %finding the optimal value
    [Zmax, Zind] = max(Z);
    BFS = sol(:,Zind); %optimal bfs values

    %print all the solution
    optval = [BFS' Zmax];
    OPTIMAL_BFS = array2table(optval);
    OPTIMAL_BFS.Properties.VariableNames(1:size(OPTIMAL_BFS,2)) = {'x_1','x_2','x_3','x_4','Value_of_Z'};

    disp(OPTIMAL_BFS);
else
    error("Equations is large than variables");
end
