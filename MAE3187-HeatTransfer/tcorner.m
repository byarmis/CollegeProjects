function [t]=tcorner(T,Tm10,T0m1,Fo)
%A function for computing the subsequent temperature of nodes along corner
%nodes
%
%Inputs are:    
%              T    -- The temperature at the node at a given time
%              Tm10 -- The temperature at node m-1 at a given time
%              T0m1 -- The temperature at node m-1 at a given time
%              Fo   -- The Fourier Number

t=2*Fo*(Tm10+T0m1)+(1-4*Fo)*T;

end