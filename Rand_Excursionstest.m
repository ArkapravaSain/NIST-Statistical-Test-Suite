clc
close all
VOLTAGELEVVALS; %Contains the Imported CELL Containing LSBs of Binary Equivalent of Voltage Values
string=str2double(VOLTAGELEVVALS); %Converts CELL data to DOUBLE Data
n=length(string);%Counts Length of String
e = 2.*string;
S=string;
Xi = e-1;
k=1;
for i=1:1:n
    for j=1:1:k
        S(i)=S(i)+Xi(j);
    end
    k=k+1;
end
SD=zeros(n+2,1);
SD(1)=0;
for  k=1:1:n;
    SD(k+1)=S(k);
end
SD(n+2)=0;

countzero=0;
for i=1:1:n
    if SD(i)==0;
        countzero=countzero+1;
    end
end

countzero=countzero-1;

Step5=zeros(8,countzero);
mat1=1;
u=0;
v=0;
start=1;
for i=1:1:n
    
    mat1=start;
    if SD(i)==0
        u=i;
        for j=i+1:1:n
            if SD(j)==0;
                v=j;
                for l=u:1:v
                    if SD(l)==-4
                        mat1=start;
                        Step5(mat1)=Step5(mat1)+1;  
                    end
                    if SD(l)==-3
                        mat1=start+1;
                        Step5(mat1)=Step5(mat1)+1;     
                    end
                    if SD(l)==-2
                        mat1=start+2;
                        Step5(mat1)=Step5(mat1)+1; 
                    end
                    if SD(l)==-1
                         mat1=start+3;
                        Step5(mat1)=Step5(mat1)+1; 
                    end
                    if SD(l)==1
                        mat1=start+4;
                        Step5(mat1)=Step5(mat1)+1; 
                    end
                    if SD(l)==2
                        mat1=start+5;
                        Step5(mat1)=Step5(mat1)+1;  
                    end
                    if SD(l)==3
                        mat1=start+6;
                        Step5(mat1)=Step5(mat1)+1; 
                    end
                    if SD(l)==4
                         mat1=start+7;
                        Step5(mat1)=Step5(mat1)+1; 
                    end
                end
                start=start+8;
                break;
            end 
        end        
    end
    
end
% //////////////////////////////////////////////////////////////////

freq=zeros(8,6);
for i=1:1:8
    for j=1:1:countzero
        if Step5(i,j)==0
            freq(i,1)=freq(i,1)+1;
        end
        if Step5(i,j)==1
            freq(i,2)=freq(i,2)+1;
        end
        if Step5(i,j)==2
            freq(i,3)=freq(i,3)+1;
        end
        if Step5(i,j)==3
            freq(i,4)=freq(i,4)+1;
        end
        if Step5(i,j)==4
            freq(i,5)=freq(i,5)+1;
        end
        if Step5(i,j)>=5
            freq(i,6)=freq(i,6)+1;
        end
    end
end


% ///////////////////////////////////////////////////////////////////////

PItable=zeros(8,6);

for i=1:1:8
    for j=1:1:6
        if j==0
            PItable(i,j)=1-1/abs(freq(i,1));
        end
        
        if j>0 && j<5
            PItable(i,j)=(1/(4*freq(i,1)*freq(i,1)))*power((1-1/(2*abs(freq(i,1)))),j-1);
        end
        if j>=5
            PItable(i,j)=(1/(2*abs(freq(i,1))))*power((1-(1/(2*abs(freq(i,1))))),4);
        end
    end
end

Jtable=zeros(8,1);

for i=1:1:8
    for j=1:1:6
        Jtable(i)=Jtable(i)+freq(i,j);
    end
end

OBStable=zeros(8,1);

for i=1:1:8
    for j=1:1:6
        OBStable(i)=OBStable(i)+((power((freq(i,j)-Jtable(i,1)*PItable(i,j)),2))/(Jtable(i,1)*PItable(i,j)));
    end
end
P_val=zeros(8,1);
for i=1:1:8
    P_val(i)=gammainc(Jtable(i)/2,OBStable(i)/2);
end


