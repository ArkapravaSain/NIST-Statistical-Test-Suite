clc
close all
VOLTAGELEVVALS; %Contains the Imported CELL Containing LSBs of Binary Equivalent of Voltage Values
string=str2double(VOLTAGELEVVALS); %Converts CELL data to DOUBLE Data
n=length(string);%Counts Length of String
M=55;
N=floor(n/M);
PI=zeros(1,N+1);
for i=1:1:n
    start=1;
    stop=start+M;
    counter=0;
    PIindex=1;
    for j=start:1:stop
        if string(j)==1
            counter=counter+1;
        end
        
    end
    PI(PIindex)=counter/M;
    PIindex=PIindex+1;
    
    start=start+M;
end
for k=1:1:N
    chi_sqr=4*M*(PI(k)-0.5)*(PI(k)-0.5);
end
p_value=gammainc(N/2,chi_sqr/2)

if p_value<0.01
    disp('THE SERIES IS NON-RANDOM');
    
else 
    disp('THE SERIES IS RANDOM');
end

    
    
        

