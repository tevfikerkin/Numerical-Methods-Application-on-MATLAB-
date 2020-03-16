clc;
clear all;
%% Baþlangýç koþullarý
a=0;
b=2;
h=[0.05 0.025];
fun=@(x,y) ( exp ( (x^4) /4 -14*x) );
Dy=@(x,y)(y*x^3-14*y);
x=a:h:b; %x deðeri
x_2=a:h/2:b; %x deðeri midpoint için
step=length(x); %adým deðeri normal euler için
step_2=length(x_2); % adým deðeri midpoint
y(1)=1; % y baþlangýç deðeri
%% Euler Method
for i=1:step-1
    y(i+1)=y(i)+h(1)*Dy(x(i),y(i));
end
plot(x,y,'--bs','LineWidth',2);
hold on;
%% 4th Order Runge Kutta Method
for i=1:step-1
    k1=Dy(x(i),y(i));
    k2=Dy(x(i)+0.5*h(1),y(i)+0.5*k1*h(1));
    k3=Dy(x(i)+0.5*h(1),y(i)+0.5*k2*h(1));
    k4=Dy(x(i)+h(1),y(i)+k3*h(1));
    y(i+1)=y(i)+(1/6)*(k1+2*k2+2*k3+k4)*h(1);
end
plot(x,y,'--o','Color','c','LineWidth',2);
hold on;
%% Analytic Solution
for i=1:step-1
    y(i)=fun(x(i),y(i));
end
plot(x,y,'Color','m','LineWidth',2);
hold on;
%% Midpoint Method
for i=1:step-1
    y(i+1)=y(i)+ h(1)*Dy( x(i) + h(1)/2 , y(i) + (h(1)/2)* Dy(x(i),y(i)) );
end
plot(x,y,'-*','Color','g','LineWidth',2);
%% Euler Method h=0.025
for i=1:step_2-1
    y(i+1)=y(i)+h(2)*Dy(x_2(i),y(i));
end
plot(x_2,y,'Color','y','LineWidth',2);
hold on
hold on;
grid on;
legend('Euler Method','4th RK method','Real Solution','Midpoint Method','Euler h=0.025');