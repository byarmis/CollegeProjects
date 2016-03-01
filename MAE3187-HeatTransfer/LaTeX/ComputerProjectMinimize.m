clc
clear all
close all
tic

disp('Note: Case does not matter when entering text responses')
disp(' ')

k=250; %W/(m-k)
alpha=8.418e-5; %Thermal diffusivity in (m^2)/s
dx=.01;
xmax=.3; ymax=.3;
nx=xmax/dx;

%User Input
%tmax=input('How long should the program run for (seconds)?: ');

[deltat g]=converge(alpha,dx,1.1);
%End User Input
Fo=alpha*deltat/dx^2; %Fourier Number

T=zeros(nx,nx,1);

q1=100*(10000); %Watts per meter squared
q2=50* (10000); %Watts per meter squared

%The temperatures along the edges and initally along the internal nodes
T1=100; %K
T2=200; %K
Ti=10;

for i=1:nx
    for j=1:nx
        T(i,j,1)=Ti;
    end
end

%Sets the initial conditions along X=L and Y=L
T(1,:,1) =T2;
T(:,nx,1)=T1;

time=1;
difference=100;
while difference>.1
    for i=2:nx
        for j=1:nx-1
            
            %Corner Node
            if j==1 && i==nx
                T(i,j,time+1)=tcorner(T(i,j,time),T(i-1,j,time),...
                    T(i,j+1,time), Fo);
            
            %Bottom Edge
            elseif i==nx && j~=nx
                T(i,j,time+1)=tbedge(T(i,j,time),T(i-1,j,time),...
                    T(i,j-1,time),T(i,j+1,time),Fo,q2,k,dx);
            
            %Left Edge
            elseif i~=1 && j==1
                T(i,j,time+1)=tledge(T(i,j,time),T(i,j+1,time),...
                    T(i-1,j,time),T(i+1,j,time),Fo,q1,k,dx);
            
            %Internal Node
            elseif i~=1 && j~=1 && i~=nx && j~=nx
                T(i,j,time+1)=tnode(T(i,j,time),T(i,j+1,time),...
                    T(i+1,j,time),T(i,j-1,time),T(i-1,j,time),Fo,g,k,dx);
            end
            
            %Manually sets the temperature along the upper and right edges
            %along with the corner where they meet
            T(1,:,time+1) =T2;
            T(:,nx,time+1)=T1;
            T(1,nx,time+1)=(T1+T2)/2;
        end
    end
    
time=time+1;
difference=sum(sum(T(:,:,time)-T(:,:,time-1)));
end

fprintf('\nThe time it takes to reach steady-state is %f seconds\n',...
    deltat*time)

fprintf('\nThe maximum temperature is %f degrees K\n\n',max(max(T(:,:,time))))

toc