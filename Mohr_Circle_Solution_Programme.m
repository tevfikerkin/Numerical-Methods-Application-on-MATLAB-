
%% Getting Data
clc;
clear all;
close all;
sigma_1= input('Please input sigma_x value(MPa): ');
sigma_2= input('Please input sigma_y value(MPa): ');
sigma_3=input('Please input sigma_z value(MPa): ');
tors_1=input('Please input shear stress value (sigma_x)(MPa): ');
tors_1=-tors_1;
tors_2=-tors_1;
x_axis=(sigma_1+sigma_2)/2;
y=tors_1;
radius=sqrt((sigma_1-x_axis)^2+tors_1^2);
%% Drawing circle
th = 0:pi/100:2*pi;
xunit = radius * cos(th) + x_axis;
yunit = radius * sin(th);
figure();
h =plot(xunit, yunit,'color','r','linewidth',2);
title('Maximum Shear Stress');
hold on
%% drawing linear 
max_shear=x_axis+radius;
min_shear=x_axis-radius;
slp=(y)/(sigma_1-x_axis); % finding the slope value 
k=xlim;
if k(1)>0
    k(1)=-k(2)/2;
elseif k(1)<0 && k(2)<0 
    k(1)=-k(1);
end
j=slp*(k-x_axis);
plot(k,j,'color','cyan');
hold on
%% plotting coordinate axis
xL = k;
yL = ylim ;
line([0 0], yL,'color','black','linewidt',2);  %x-axis
line(xL,  [0 0],'color','black','linewidt',2);  %y-axis
xlabel('\sigma_(_a_x_i_s_)');
ylabel('                      \tau_(_a_x_i_s_)');
hold on
%% plotting some point 

plot(sigma_1,tors_1,'bx',sigma_2,tors_2,'bx',x_axis,0,'bo',max_shear,0,'g*',min_shear,0,'g*');
text(max_shear,0,'\sigma_m_a_x','VerticalAlignment', 'bottom','Color','g' ,'FontSize',10);
text(max_shear,-max(yL/15),num2str(max_shear)+" MPa",'Color','g' ,'FontSize',10);
text(min_shear,0,'\sigma_m_i_n','HorizontalAlignment', 'right',...
    'VerticalAlignment', 'bottom','Color','g','FontSize',10);
text(min_shear,-max(yL)/15,num2str(min_shear)+" MPa",'HorizontalAlignment',...
    'right','Color','g' ,'FontSize',10);
plot(x_axis,radius,'gx');
axis equal
text(x_axis,radius,"\tau_m_a_x"+num2str(radius)+" MPa",'Color','g',...
    'VerticalAlignment','bottom','FontSize',10);
hold on
%% Angle Display
ang=atand(slp); %atand= arctandegree. This command show result angle as degree
ang_2=(atand(1/slp))/2;
ang_str="Orientation of Principal Plane : "+num2str(ang/2)+" degree clockwise";
ang_str_2="Maximum In-Plane Shear Stress : "+num2str(ang_2)+" degree counter-clockwise";
strng="Angle= "+num2str(ang);
if ang<0
    strng="Angle= "+num2str(ang+180);
    ang=-ang;
    ang_str="Orientation of Principal Plane : "+num2str(ang/2)+" degree counter-clockwise";
end
if ang_2<0
    ang_2=-ang_2;
    ang_str_2="Maximum In-Plane Shear Stress : "+num2str(ang_2)+" degree clockwise";
end
text(x_axis,0,strng,'VerticalAlignment','bottom','FontSize',8);
grid on;
%% Preparing to Draw 3D Mohr's
if sigma_1<sigma_2 && sigma_3>sigma_1 && sigma_1<min_shear
    K=sigma_1; 
elseif sigma_1>sigma_2 && sigma_3>sigma_2 && sigma_2<min_shear
    K=sigma_2;
elseif sigma_1>sigma_3 && sigma_2>sigma_3 && sigma_3<min_shear 
    K=sigma_3;
else
    K=min_shear;
end
switch K
    case {sigma_1}
        if sigma_2>sigma_3 && sigma_2>max_shear
            B=sigma_2;
        elseif sigma_3>sigma_2 && sigma_3>max_shear
            B=sigma_3;
        else
            B=max_shear;
        end
    case {sigma_2}
        if sigma_1>sigma_3 && sigma_1>max_shear
            B=sigma_1;
        elseif  sigma_1<sigma_3 && sigma_3>max_shear
            B=sigma_3;
        else
            B=max_shear;
        end
    case {sigma_3}
        if sigma_2>sigma_1  && sigma_2>max_shear
            B=sigma_2;
        elseif sigma_2<sigma_1&& sigma_1>max_shear 
            B=sigma_1;
        else
            B=max_shear;
        end
    case {min_shear}
        if max_shear>sigma_1 && max_shear>sigma_2 && max_shear>sigma_3
        B=max_shear;
        elseif sigma_1>sigma_2 && sigma_1>sigma_3
            B=sigma_1;
        elseif sigma_2>sigma_1 && sigma_2>sigma_3
            B=sigma_2;
        else
            B=sigma_3;
        end
end 
%% Drawing 3D Mohr's
th = 0:pi/100:2*pi;
% for first plane
xunit_1 = radius * cos(th) + x_axis;
yunit_1 = radius * sin(th);
figure();
h = plot(xunit_1, yunit_1,'color','r','linewidth',2);
hold on
%for second plane
if max_shear>0 && min_shear>=0
center_1=(min_shear+K)/2;
radius_1=(abs(min_shear-K))/2;
xunit_1 = radius_1 * cos(th)+center_1;
yunit_1 = radius_1 * sin(th);
h = plot(xunit_1, yunit_1,'color','b','linewidth',2);
axis equal
hold on
% for the absolute max shear stress
center_2=(max_shear+K)/2;
radius_2=(abs(max_shear-K))/2;
xunit_2 = radius_2 * cos(th)+center_2;
yunit_2 = radius_2 * sin(th);
h = plot(xunit_2, yunit_2,'color','g','linewidth',2);
plot(center_2,radius_2,'mx');
text(center_2,radius_2,"  \tau _m_a_x= "+num2str(radius_2)+" MPa",'VerticalAlignment','top','Color','m','FontSize',12);
grid on
line([center_2 center_2],[0 radius_2],'color','m','linewidt',1,'LineStyle','--'); 
absolute=radius_2;
axis equal
title('Absolute Maximum Shear Stress');
hold on
elseif max_shear>0 && min_shear<0
center_1=(max_shear+0)/2;
radius_1=(abs(max_shear)+0)/2;
xunit_1 = radius_1 * cos(th)+center_1;
yunit_1 = radius_1 * sin(th);
% subplot(2,1,2);
h = plot(xunit_1, yunit_1,'color','b','linewidth',2);
axis equal
hold on
% for the absolute max shear stress
center_2=(min_shear+0)/2;
radius_2=(abs(min_shear))/2;
xunit_2 = radius_2 * cos(th)+center_2;
yunit_2 = radius_2 * sin(th);
h = plot(xunit_2, yunit_2,'color','g','linewidth',2);
axis equal
plot(x_axis,radius,'mx');
text(x_axis,radius,"  \tau _m_a_x= "+num2str(radius)+" MPa",'VerticalAlignment','top','Color','m','FontSize',12);
grid on
line([x_axis x_axis],[0 radius],'color','m','linewidt',1,'LineStyle','--'); 
absolute=radius;
title('Absolute Maximum Shear Stress');
hold on
elseif max_shear<=0 && min_shear<0
center_1=(max_shear+0)/2;
radius_1=(abs(max_shear)+0)/2;
xunit_1 = radius_1 * cos(th)+center_1;
yunit_1 = radius_1 * sin(th);
% subplot(2,1,2);
h = plot(xunit_1, yunit_1,'color','b','linewidth',2);
axis equal
hold on
% for the absolute max shear stress
center_2=(min_shear+0)/2;
radius_2=(abs(min_shear))/2;
xunit_2 = radius_2 * cos(th)+center_2;
yunit_2 = radius_2 * sin(th);
h = plot(xunit_2, yunit_2,'color','g','linewidth',2);
axis equal
plot(center_2,radius_2,'mx');
text(center_2,radius_2,"  \tau _m_a_x= "+num2str(radius_2)+" MPa",'VerticalAlignment','top','Color','m','FontSize',12);
grid on
line([center_2 center_2],[0 radius_2],'color','m','linewidt',1,'LineStyle','--'); 
absolute=radius_2;
title('Absolute Maximum Shear Stress');
hold on
end
xL = k;
yL = ylim ;
line([0 0], yL,'color','black','linewidt',2);  %x-axis
line(xL,  [0 0],'color','black','linewidt',2);  %y-axis
xlabel('        \sigma _(_a_x_i_s_)');
ylabel('                        \tau_(_a_x_i_s_)');
plot(max_shear,0,'m*');
text(max_shear,0,"\sigma= "+num2str(max_shear)+"MPa",'VerticalAlignment','top','HorizontalAlignment','left','Color','m','FontSize',10);
plot(K,0,'m*');
text(K,0,"\sigma= "+num2str(K)+"MPa",'VerticalAlignment','top','HorizontalAlignment','right','Color','m','FontSize',10);
hold on
% subplot(2,1,1);
%% Result show
fprintf('\n-------------------------------------------\n<< Results >>\nPrinciple Stresses: %1.4f(MPa) and %1.4f(MPa)\nMaximum Shear Stress: %1.4f(MPa)\nAbsolute Maximum Shear Stress: %1.4f(MPa)\n',max_shear,min_shear,radius,absolute);
disp(ang_str);
disp(ang_str_2);
wish=input('Do you want to make a new calculation[Y/N]: ','s');
wish=lower(wish);
if wish=='n'
    clc;
    disp('Good Bye...');
end
