clc
close all
VOLTAGELEVVALS; %Contains the Imported CELL Containing LSBs of Binary Equivalent of Voltage Values
string=str2double(VOLTAGELEVVALS); %Converts CELL data to DOUBLE Data
n=length(string);%Counts Length of String

e = 2.*string;
Xi = e-1
Ssum=abs(sum(Xi))
Sabs=Ssum/sqrt(n)
Pval=erfc(Sabs/sqrt(2))

if(Pval<0.01)
    disp('The String of Numbers is Not Random');
else
    disp('The String of Numbers is Random');
end



