clc
clear all
close all
tic

disp('Note: Case does not matter when entering text responses')
disp(' ')

%This allows the 'getfigure' command to grab the whole window, as opposed 
%to part of the window that renders due to Windows 7 aero effects
opengl('software')

k=250; %W/(m-k)
alpha=8.418e-5; %Thermal diffusivity in (m^2)/s
dx=.01;
xmax=.3; ymax=.3; thick=.02;
nx=xmax/dx;

%User Input
tmax=input('How long should the program run for (seconds)?: ');

[deltat g]=converge(alpha,dx,1.1);
%End User Input
Fo=alpha*deltat/dx^2; %Fourier Number

t=0:deltat:tmax;
[timemax ~]=size(t');

T=zeros(nx,nx,timemax);

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

%User Input
plotnum=plotq();
%End User Input

for time=1:timemax-1
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
                    T(i-1,j,time),T(i+1,j,time),Fo,q1,k,dx,g);
            
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
    
    if plotnum==1
        S=surf(flipud(T(:,:,time)),'LineStyle','none');
        axis([0 1.1*xmax/dx 0 1.2*xmax/dx])
        xlabel('X Node'); ylabel('Y Node');
        text(.125*xmax/dx, 1.1*xmax/dx,...
            ['Temperature Contour Plot at Time t= ', num2str(t(time)), 'seconds'])
        colorbar
        M(time)=getframe; %#ok<SAGROW>
    end
    
end

if plotnum==1
    movie(M,5,90)
elseif plotnum==0
    surf(flipud(T(:,:,timemax)),'LineStyle','none')
    xlabel('X Node'); ylabel('Y Node');
    title(['Temperature Contour Plot at Time t= ', num2str(t(timemax)), 'seconds']);
    axis([0 1.1*xmax/dx 0 1.1*xmax/dx])
    colorbar
    fprintf('\nThe maximum temperature is %f degrees K\n\n',max(max(T(:,:,timemax))))
elseif plotnum==-1
    fprintf('\nThe maximum temperature is %f degrees K\n\n',max(max(T(:,:,timemax))))
end

toc