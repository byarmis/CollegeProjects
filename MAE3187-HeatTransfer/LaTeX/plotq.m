function [n]=plotq()
%This function asks the user if the temperature should be plotted during
%the calculations or not.
%
%There are no inputs currently.

plotquestion=input('When should the temperature be plotted (During/End/Never)?: ', 's');
plotansy=strcmpi('D',plotquestion);
plotansn=strcmpi('E',plotquestion);
plotans0=strcmpi('N',plotquestion);

if plotansy==1
    n=1;
elseif plotansn==1
    n=0;
elseif plotans0==1
    n=-1;
end

end