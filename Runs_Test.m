clc
close all
VOLTAGELEVVALS; %Contains the Imported CELL Containing LSBs of Binary Equivalent of Voltage Values
string=str2double(VOLTAGELEVVALS); %Converts CELL data to DOUBLE Data
n=length(string);%Counts Length of String

% Truncate and make 0/1
string = string(1:n,:);
if ~isempty(find(string < 0, 1))
    string = (string > 0);
end

% Proportion of ones (pi)
pi_r = sum(string,1)/n;
estCrit = abs(pi_r - 0.5) > 2/sqrt(n);
% Zero all streams for which Pi condition is not fulfilled
string(:,estCrit) = 0;

% Compute V_n
results.V = sum(xor(string(1:end-1,:), string(2:end,:)),1) + 1;

% Compute P-value
results.p_value = erfc(abs(results.V - 2*n * pi_r .* (1-pi_r))./ (2*sqrt(2*n) * pi_r .* (1-pi_r)));

disp(results.p_value);

if results.p_value >0.01
    disp('The result is Random');
else
    disp('The result is non Random');
end





