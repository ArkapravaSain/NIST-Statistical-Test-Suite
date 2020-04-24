clc
close all
VOLTAGELEVVALS; %Contains the Imported CELL Containing LSBs of Binary Equivalent of Voltage Values
X=transpose(str2double(VOLTAGELEVVALS)); %Converts CELL data to DOUBLE Data
n=length(X);%Counts Length of String
temp=zeros(1,n);
M=12;
Q=10;

N=floor(n/(M*Q));
Rank=zeros(1,N);
start=1;
m=1;

%Checking all the Matrix elements and putthing the elements into
%Submatrices
for i=1:n
   
        
  if i==M*Q
            temp=X([1],[start:i]);
            tempz=imresize(temp,[M+1,Q-1]);
            start=start+i;
            Rank(m)=rank(tempz);
            m=m+1;
  end
        
end

FMAT=find(Rank==M);
Fm=length(FMAT);
FMAT_1=find(Rank==M-1);
Fm_1=length(FMAT_1);
Foth=N-Fm-Fm_1

Xobs=((Fm-0.2888*N)*(Fm-0.2888*N)/(0.2888*N))+((Fm_1-0.5776*N)*(Fm_1-0.5776*N)/(0.5776*N))+((N-Fm-Fm_1-0.1336*N)*(N-Fm-Fm_1-0.1336*N)/(0.1336*N));
P_val=exp(-Xobs/2)

if P_val >0.01
    disp('The result is Random');
else
    disp('The result is non Random');
end

