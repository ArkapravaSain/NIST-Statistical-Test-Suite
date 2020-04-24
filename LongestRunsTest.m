clc
close all
VOLTAGELEVVALS; %Contains the Imported CELL Containing LSBs of Binary Equivalent of Voltage Values
X=transpose(str2double(VOLTAGELEVVALS)); %Converts CELL data to DOUBLE Data
n=length(X);%Counts Length of String
if(n>=128 && n<6272)
    M=8;
else if (n>=6272 && n<750000)
        M=128;
    else
        M=10000;
    end
end
temp=zeros(1,M);
N=floor(n/M);
Freq=zeros(1,N);
m=1;
start=1;
for i=1:1:length(X)
    r=rem(i,M);
        if r==0
            temp=X([1],[start:i])
            start=start+i;
            for j=1:length(temp)
                if temp(j)==1
                    Freq(m)=Freq(m)+1;
                end
                if temp(j)==0
                    break;
                end
            end  
            m=m+1;
        end
end

v=zeros(1,4);
 for k=1:1:length(Freq)
                if Freq(k)<=1
                    v(1)=v(1)+1;
                    else if Freq(k)==2
                            v(2)=v(2)+1;
                        else if Freq(k)==3
                                v(3)=v(3)+1;
                                else if Freq(k)>=4
                                    v(4)=v(4)+1;
                                    end
                            end
                        end
                end
                    
 end
 Xobs=0;
 K=3;
 N=16;
 pi=[0.2148 0.3672 0.2305 0.1875];
 
 for b=0:K
    Xobs=Xobs+((v(b+1)-N*pi(b+1))*(v(b+1)-N*pi(b+1)))/(N*pi(b+1));
 end
 
 P_val=gammainc(K/2,Xobs/2,'upper')
 
if P_val >0.01
    disp('The result is Random');
else
    disp('The result is non Random');
end