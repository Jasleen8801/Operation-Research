clc
clear

% Define the problem
A = [1 2; 1 1; 0 1; -1 0];
B = [2000; 1500; 600; 0];
C = [3 5];

% Find the maximum value of B for plotting
v = max(B);

% Plot the constraints
x1 = 0:v;
x2 = zeros(size(A,1), v+1);
for i = 1:size(A,1)
    x2(i,:) = (B(i) - (A(i,1) .* x1)) ./ A(i,2);
    x2(i,:) = max(0, x2(i,:));
    plot(x1, x2(i,:));
    hold on
end

% Add labels and legend to the plot
xlabel('x1')
ylabel('x2')
title('Graphical Method for Linear Programming')
legend('x1+2x2<=2000', 'x1+x2<=1500', 'x2<=600', 'x1>=0', 'x2>=0')

% Find the corner points
A_corners = [A; eye(size(A,2))];
B_corners = [B; zeros(size(A,2), 1)];

corners = [];
for i = 1:size(A_corners,1)-1
    for j = i+1:size(A_corners,1)
        A3 = [A_corners(i,:); A_corners(j,:)];
        B3 = [B_corners(i); B_corners(j)];
        if det(A3) == 0
            continue
        end
        X = A3 \ B3;
        corners = [corners, X];
    end
end

% Remove corner points outside of feasible region (not mandatory)
outside = corners(1,:) < 0 | corners(2,:) < 0 | A * corners > B;
if any(outside)
    corners(:, outside) = [];
end

% Evaluate the objective function at each corner point
Z = C * corners;

% Find the optimal solution
[optimal_value, idx] = max(Z);
optimal_point = corners(:,idx);

% Display the results
fprintf('Optimal point: (%0.2f, %0.2f)\n', optimal_point(1), optimal_point(2))
fprintf('Optimal value of Z: %0.2f\n', optimal_value)
