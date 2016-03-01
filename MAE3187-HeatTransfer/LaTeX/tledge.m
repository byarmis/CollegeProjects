function [t]=tledge(T,T10,T01,T0m1,Fo,q,k,dx,g)
%A function for computing the subsequent temperature of nodes along the
%left edge.
%
%Inputs are:    
%              T    -- The temperature at the node at a given time
%              T10  -- The temperature at node m+1 at a given time
%              T01  -- The temperature at node n+1 at a given time
%              T0m1 -- The temperature at node n-1 at a given time
%              Fo   -- The Fourier Number
%               q   -- The heat flux along the left edge
%               k   -- The conduction coefficient
%               dx  -- The step distance

t=Fo*(2*T10+T01+T0m1+q/k*dx+g/k*dx)+(1-4*Fo)*T;

end