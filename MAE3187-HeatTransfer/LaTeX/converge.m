function [deltat g]=converge(alpha,dx,fudge_factor)
%This function finds the timestep such that the function either converges
%or diverges.  It asks the user if the function should diverge or not.
%
%It also prompts the user for heat generation.

%Inputs are:
%            alpha          -- The thermal diffusivity of the material
%            dx             -- The step distance
%            fudge_factor   -- The factor by which, should it be
%                              decided that the simulation should 
%                              diverge, how quickly it should diverge

converge=input('Should the program converge (Y is suggested)(Y/N)?: ', 's');
convergey=strcmpi('Y',converge);
convergen=strcmpi('N',converge);

if convergey==1
    deltat=.8*(1/(2*alpha))*(1/(1/(dx^2)+1/(dx^2)));
elseif convergen==1
    deltat=(1/(2*alpha))*(1/(1/(dx^2)+1/(dx^2)))*fudge_factor;
else
    disp('That is not a valid input')
end

ganswer=input('Should there be heat generation (Y/N)?: ', 's');
ganswersy=strcmpi('Y',ganswer);
ganswersn=strcmpi('N',ganswer);

if ganswersy==1
    g=1e6; %Watts per meter cubed
elseif ganswersn==1
    g=0;
else
    disp('That is not a valid input')
end

end