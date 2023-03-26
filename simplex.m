clc;
clear all;

% Define the problem data
cost = [2 1 0 0 0 0];   % objective function - extra zero added for solution
A = [1 2 1 0 0; 1 1 0 1 0; 1 -1 0 0 1];  % constraints coefficients
b = [10; 6; 2]; % RHS of constraints
Var = {'x1','x2','s1','s2','s3','sol'}; % variable names
bv = [3 4 5]; % indices of basic variables in the initial BFS

% Construct the initial simplex table
A = [A b];
zjcj = cost(bv)*A - cost;
simplex_table = [A; zjcj];
array2table(simplex_table,'VariableNames',Var)

RUN = true;
while RUN
    if any(zjcj(1:end-1) < 0)
        fprintf("The current BFS is optimal\n")
        zc = zjcj(1:end-1);
        [Enter_val, pvt_col] = min(zc);
        if all(A(:, pvt_col) <= 0)
            error("LPP is unbound")
        else
            Sol = A(:, end);
            Column = A(:, pvt_col);
            Ratio = zeros(size(A, 1) - 1, 1);
            for i = 1:size(A, 1) - 1
                if Column(i) > 0
                    Ratio(i) = Sol(i) / Column(i);
                else
                    Ratio(i) = inf;
                end
            end
            [leaving_value, pvt_row] = min(Ratio);
        end

        pvt_key = A(pvt_row, pvt_col);

        % Perform the pivot operation
        A(pvt_row, :) = A(pvt_row, :) / pvt_key;
        for i = 1:size(A, 1)
            if i ~= pvt_row
                A(i, :) = A(i, :) - A(i, pvt_col) * A(pvt_row, :);
            end
        end

        % Update the basic variable indices and the simplex table
        bv(pvt_row) = pvt_col;
        zjcj = cost(bv)*A - cost;
        simplex_table = [A; zjcj];
        array2table(simplex_table,'VariableNames',Var)
    else
        RUN = false;
    end
end

fprintf("Optimal Solution is %f\n", zjcj(end));
