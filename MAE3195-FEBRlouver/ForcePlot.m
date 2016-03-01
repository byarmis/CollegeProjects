clc
clear all
close all

n = 100;
limit = 10;

[x y] = meshgrid(-limit:limit/n:limit, -limit:limit/n:limit);

r = sqrt(x.^2 + y.^2);

Z = 500*(cos(pi*r/10)+1);

[x_r_max y_r_max] = size(r);

for i=1:x_r_max
    for j=1:y_r_max
        if r(i,j)>10
            Z(i,j) = 0;
        end
    end
end

surf(x,y,Z,'EdgeColor','none')
xlabel('X-Axis')
ylabel('Y-Axis')
zlabel('Force (psi)')