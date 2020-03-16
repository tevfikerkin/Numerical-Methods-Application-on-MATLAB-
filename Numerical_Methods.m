cont='y';
while cont=='y';
    clc;
    clear all;
    fprintf('\t\t\t WELCOME TO THE NUMERIC INTEGRATION PROGRAM \n\n');
    fprintf('-------------------------------------------------------\n');
    fprintf('1-Single Trapezoidal\n\n2-Composite Trapezoidal\n\n3-Single Simpson 1/3 Rule\n\n4-Composite Simpson 1/3 Rule\n\n5-Simpson 3/8 Rule\n\n6-Composite Simpson 3/8 Rule\n');
    fprintf('-------------------------------------------------------\n');
    wish=input('Please choose what you want to calculate type :');
    
    a=0; %input('Please enter the integral lower value: ');%alt limit
    b=4; %input('Please enter the integral upper value: ');%üst limit
    
    fun=@(x)(1 -exp(-14 - x));%fonksiyonu tanýmladým
%     fun=@(x)(0.2 + 25.*x - 200*x.^2 + 675.*x.^3 - 900.*x.^4 + 400.*x.^5);
    result = integral(fun,a,b);%sonucu bir deðere atadým
    if wish==2 || wish==4 ||wish==6
        n=input('Please enter a value ''n'': ');
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
            res=(h./2).*(fun(a)+fun(b));
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
            choosing= 'Composite 3/8 Simpson''s Rule'
            h=(b-a)./3;
            a3=a;
            sum=0;
            
            for p=1:n+1
                if p==1 || p==n+1
                    sum=fun(a3)+sum;
                elseif mod(p,3)==0 && p<n+1
                    sum=2.*fun(a3)+sum;
                else
                    sum=3.*fun(a3)+sum;
                end
                a3=h+a3;
            end
            res=((3.*h)./8).*sum;
            error=abs(res-result);
            perc_error=(error./result).*100;
            
        otherwise
            disp('WRONG CHOOSING.');
    end
    clc;
    fprintf('*************--------RESULTS--------*************\n\n');
    fprintf('Your Choosing: %s\nResult: %1.6f\nError: %1.6f\nPercent Relative Error: %1.6f\nReal Result: %1.6f\nNumerical Result: %1.6f\n',choosing,res,error,perc_error,result,res);
    cont=input('Do you want to make a new calculation ? Y/N: ','s');
    cont=lower(cont);
    if cont=='n'
        clc;
        disp('Thanks for using program, bye bye...');
    end
end