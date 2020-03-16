%Lagrange Polynomial Method.
%Tevfik Erkin 16030021014

clc;
clear all;
name='Tevfik ERKÝN';
ID=16030021014;

x=[1980 1985 1990 2000 2007];
y=[44.7 50.6 56.4 67.8 70.5];

x_value= 1991.4; %that value is desired.

sum=0; %to obtain y(x) function
leng=length(x); %number of x matrix value. The process will contuinue until this length.
%%
for i=1:leng

    pr_1=1; % every step production will be calculated, for initial value is 1.
    
  %%calculating L(x) for every X(i) value.
  for j=1:leng
        if j~=i
        pr_1= pr_1.*((x_value-x(j))/(x(i)-x(j)));
    
        end
  end
  %%
  sum = sum + y(i).*(pr_1);
end
fprintf('Your number= %g \nResult= %g \n-----------------------------\nStudent Number= %d\nName/Surname= %s\n',x_value,sum,ID,name );
%%
plot(x,y,'--g','LineWidth',2);
grid on;
xlabel('Year');
ylabel('Population');
title('Year/Population');
%%
%Referances buders.com
%mathworks
%Programming Numerical Methods in MATLAB