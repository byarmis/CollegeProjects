function [t]=tnode(T,T10,T01,Tm10,T0m1,Fo,g,k,dx)
%A function for computing the subsequent temperature of nodes along an
%internal node
%
%Inputs are:    
%              T    -- The temperature at the node at a given time
%              T10  -- The temperature at node m+1 at a given time
%              T01  -- The temperature at node n+1 at a given time
%              Tm10 -- The temperature at node m-1 at a given time
%              T0m1 -- The temperature at node n-1 at a given time
%              Fo   -- The Fourier Number
%               g   -- The heat generation term
%               k   -- The heat conduction coefficient
%               dx  -- The step distance

t = Fo*(T10+Tm10+T01+T0m1+(g/k)*dx^2)+(1-4*Fo)*T;

end