clc
close all
VOLTAGELEVVALS; %Contains the Imported CELL Containing LSBs of Binary Equivalent of Voltage Values
string=str2double(VOLTAGELEVVALS); %Converts CELL data to DOUBLE Data
n=length(string);%Counts Length of String
S=string;
m=10;
for i=1:1:m-1
    S(n+i)=S(i);
end

% //////////////////////////////////M BIT//////////////////////////////////
binary10bit=decimalToBinaryVector(0:1023,10);
freq10=zeros(1024,1);

buffer10=zeros(1,10);

start=1;
stop=m;
k=1;
for i=1:1:n
    if i<=stop
        buffer10(k)=S(i);
        k=k+1;
    end
    
    if i>=stop
%///////////////////////////////////////////
        for i=1:1:1024
            if binary10bit(i,1:10)==buffer10;
                freq10(i)=freq10(i)+1;
            end
        end
%//////////////////////////////////////////
        start=start+10;
        stop=stop+10;
        k=1;
    end
end




% //////////////////////////////////M-1 BIT///////////////////////////////
binary9bit=decimalToBinaryVector(0:511,9);
freq9=zeros(512,1);

buffer9=zeros(1,9);

start=1;
stop=m-1;
k=1;
for i=1:1:n
    if i<=stop
        buffer9(k)=S(i);
        k=k+1;
    end
    
    if i>=stop
%///////////////////////////////////////////
        for i=1:1:512
            if binary9bit(i,1:9)==buffer9;
                freq9(i)=freq9(i)+1;
            end
        end
%//////////////////////////////////////////
        start=start+9;
        stop=stop+9;
        k=1;
    end
end




% //////////////////////////////////M-2 BIT///////////////////////////////
binary8bit=decimalToBinaryVector(0:255,8);
freq8=zeros(256,1);

buffer8=zeros(1,8);

start=1;
stop=m-2;
k=1;
for i=1:1:n
    if i<=stop
        buffer8(k)=S(i);
        k=k+1;
    end
    
    if i>=stop
%///////////////////////////////////////////
        for i=1:1:256
            if binary8bit(i,1:8)==buffer8;
                freq8(i)=freq8(i)+1;
            end
        end
%//////////////////////////////////////////
        start=start+8;
        stop=stop+8;
        k=1;
    end
end
    


% CHI m SQUARE CALCULATION////////////////////////////////////////////////
Chim2=0;
for i=1:1:1024
    Chim2=Chim2+(power(freq10(i),2));
end
Chim2=(power(2,m)/n)*Chim2-n;


% CHI m-1 SQUARE CALCULATION////////////////////////////////////////////////
Chim_12=0;
for i=1:1:512
    Chim_12=Chim_12+(power(2,m-1)/n)*(power(freq9(i),2));
end
Chim_12=Chim_12-n;
        
% CHI m-2 SQUARE CALCULATION////////////////////////////////////////////////
Chim_22=0;
for i=1:1:256
    Chim_22=Chim_22+(power(2,m-2)/n)*(power(freq8(i),2));
end
Chim_22=Chim_22-n;




DelChim2=Chim2-Chim_12;
Del2Chim2=Chim2-2*Chim_12+Chim_22;

p_val1=gammainc(power(2,m-2),DelChim2);

p_val2=gammainc(power(2,m-3),Del2Chim2);

if p_val1>=0.01
    if p_val2>=0.01
        disp('THE SERIES IS RANDOM');
    end
else
    disp('THE SERIES IS NON-RANDOM');
end

        