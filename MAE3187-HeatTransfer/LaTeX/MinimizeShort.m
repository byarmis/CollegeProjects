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