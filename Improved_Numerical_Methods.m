
clc;clear all;
cont='y';
 fprintf('\t\t\t\t WELCOME TO THE NUMERIC INTEGRATION PROGRAM \n\n');
    beep;
    fprintf('USER GUIDE (it will continue after 10 seconds)\n\nPlease read the article to use program without problem :\n\n  This program designed as user-friendly.\nIf you wants to calculate the every rules, you can only\npress the YES ''y'' button at end of the calculation and program let you for new calculation \n');
   
    while cont=='y';
    clear all;
    fprintf('\nn = Number of segment (Program needs this value for composite applications)\n\n')

    fprintf('-------------------------------------------------------\n');
    fprintf('1-Single Trapezoidal\n\n2-Composite Trapezoidal\n\n3-Single Simpson''s 1/3 Rule\n\n4-Composite Simpson''s 1/3 Rule\n\n5-Simpson''s 3/8 Rule\n\n6-Composite Simpson''s Rule\n');
    fprintf('-------------------------------------------------------\n');
    wish=input('Please choose what you want to calculate type :');
    a=0; %input('Please enter the integral lower value: ');%alt limit
    b=4; %input('Please enter the integral upper value: ');%üst limit
    fun=@(x)(1 -exp(-14.*x));%fonksiyonu tanýmladým
    result = integral(fun,a,b);%sonucu bir deðere atadým
    if wish==2 || wish==4 ||wish==6
        n=input('Please enter number of segment as ''n'': ');
    end
    %% Composite Trapezoidal Rule
    switch wish
        case 2
            choosing='Composite Trapezoidal';
            a1=a;
            sum=0;%fonksiyonlarýn aldýklarý deðerlerin toplamý
            
            h=(b-a)/n;%aralýklarýn kaç birim olmasý gerekiyor onu hesaplýyoruz
            
            for j=1:n+1
                if j==1 || j==n+1
                    sum=fun(a1)+sum;
                else
                    sum=2.*fun(a1)+sum;
                end
                a1=a1+h;%hangi x deðerleri aldýðýný göstermek için bu matrise kaydediyorum.
            end
            res=(h/2)*(sum);
            error=abs(res-result);
            perc_error=(error./result)*100;
            j=1;i=1;
            %% Single Trapezoidal Rule
        case 1
            choosing='Single Trapezoidal';
            h=(b-a)/2;
            res=(h).*(fun(a)+fun(b));
            error=abs(result-res);
            perc_error=(error./result).*100;
            
            %% Composite Simpson's 1/3 Rule
        case 4
            choosing='Composite Simpson''s 1/3 Rule';
            a2=a;
            sum=0;%fonksiyonlarýn aldýklarý deðerlerin toplamý
            
            h=(b-a)/n;%aralýklarýn kaç birim olmasý gerekiyor onu hesaplýyoruz
            
            for j=1:n+1
                if j==1 || j==n+1
                    sum=fun(a2)+sum;
                elseif mod(j,2)==0 && j~=n+1
                    sum=4.*fun(a2)+sum;
                else
                    sum=2.*fun(a2)+sum;
                end
                a2=a2+h;%hangi x deðerleri aldýðýný göstermek için bu matrise kaydediyorum.
                
            end
            res=(h/3)*(sum);
            error=abs(res-result);
            perc_error=(error./result).*100;
            
        case 3
            choosing= 'Single Simpson''s 1/3 Rule'
            h=(b-a)/2;
            res=h./3.*(fun(a)+4.*fun(a+h)+fun(b));
            error=abs(result-res);
            perc_error=(error./result).*100;%yüzde cinsinden hata payýný hesaplýyorum
            
            %% 3/8 Simpson Rule FIRST
        case 5
            choosing= '3/8 Simpson''s Rule'
            h=(b-a)./3;
            a3=a;
            sum=0;
            for k=1:4
                if k==1 || k==4
                    sum=fun(a3)+sum;
                else
                    sum=3.*fun(a3)+sum;
                end
                a3=a3+h;
            end
            res=((3.*h)./8).*sum;
            error=abs(result-res);
            perc_error=(error./result).*100;
        case 6
            choosing= 'Composite  Simpson''s Rule'
            h1=4/5;
            sum1=h1./3.*(fun(0)+4.*fun(0+h1)+fun(0+2*h1));
            h2=h1;
            a3=4-3*h1;
            sum=0;
            for k=1:4
                if k==1 || k==4
                    sum=fun(a3)+sum;
                else
                    sum=3.*fun(a3)+sum;
                end
                a3=a3+h2;
            end
            sum= ((3.*h2)./8).*sum;
            res=sum+sum1;
            error=abs(res-result);
            perc_error=(error./result).*100;
            
        otherwise
            disp('WRONG CHOOSING.');
    end
    %% question 2
    
    multi_matris=[-8 -8 -6  4;
        -4 -3  1  7;
        -2 -1  4  10];
    upper_x=12;
    lower_x=0;
    upper_y=4;
    lower_y=0;
    del_x=(upper_x-lower_x);
    leng_x=size(multi_matris,2)-1; % n deðerini bulmak için kullandým.
    leng_y=size(multi_matris,1)-1; % tüm sonuçlar elde edildikten sonraki y
    %deperindeki n deðerini bulmak için kullandým
    sum_multi_1=0;
    for p=1:size(multi_matris,1)
        sum_multi_1=0;
        for o=1:size(multi_matris,2)
            multi_matris(p,o)
            if o==1 || o==size(multi_matris,2)
                sum_multi_1=multi_matris(p,o)+sum_multi_1;
            else
                sum_multi_1=2.*multi_matris(p,o)+sum_multi_1;
            end
        end
        sum_3(p)=((upper_x-lower_x)./(leng_x.*2)).*sum_multi_1;
        %     res=(del_x./4).*sum_2;
    end
    
    result_multi = ((upper_y-lower_y)./(leng_y.*2)).*(sum_3(1)+2.*sum_3(2)+sum_3(3))
    result_multi = result_multi./((upper_x-lower_x).*(upper_y-lower_y));
    clc;
    func=func2str(fun);
    fprintf('*************--------RESULTS Of QUESTION-1--------*************\n\n');
    fprintf('Your Choosing: %s\nYour equation: %s\nError: %1.6f\nPercent Relative Error: %%%1.6f\nReal Result: %1.6f\nNumerical Result: %1.6f\n\n',choosing,func,error,perc_error,result,res);
    fprintf('\n*************--------RESULTS Of QUESTION-2--------*************\n\n');
    tab=array2table(multi_matris,'VariableNames',{'Column_1','Column_2','Column_3','Column_4'});
    fprintf('\t\tYour Values From Table as a Matrix\n\n');
    disp(tab);
    fprintf('Avarage Value of Table: %1.6f\n\n',result_multi);
    fprintf('----------------------END OF CALCULATIONS------------------------ \n\n');
    cont=input('Do you want to make a new calculation ? Y/N: ','s');
    cont=lower(cont);
    clc;
    if cont=='n'
        clc;
        disp('Thanks for using program, bye bye...');
    end
    
end