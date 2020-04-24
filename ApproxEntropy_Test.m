clc
close all
VOLTAGELEVVALS; %Contains the Imported CELL Containing LSBs of Binary Equivalent of Voltage Values
S=str2double(VOLTAGELEVVALS); %Converts CELL data to DOUBLE Data
n=length(S);%Counts Length of String
m=7;

for i=1:1:m-1
    S(n+i)=S(i);
end

bufferm=zeros(1,m);
n=floor(n/m);

BinaryM=decimalToBinaryVector(0:(power(2,m)-1),m);
freqM=zeros(power(2,m),1);
for i=1:1:n
    
    k=1;
    for j=i:1:i+m
        bufferm(k)=S(j);
        k=k+1;
    end 
% //////////////////////////////////////////
    for l=1:1:power(2,m)
        if BinaryM(l,1:m)==bufferm(1,1:m)
           freqM(l)=freqM(l)+1;
        end
    end
% //////////////////////////////////////////
end


CvalM=zeros(power(2,m),1);

for i=1:1:power(2,m)
    CvalM(i)=freqM(i)/n;
end

J=zeros(power(2,m),1);
for i=1:1:power(2,m)
    temp=decimalToBinaryVector(i-1);
    
end

% 
% PI=zeros(power(2,m),1)
% for i=1:1:power(2,m)
%     PI(i)=
% end
% 
% 
