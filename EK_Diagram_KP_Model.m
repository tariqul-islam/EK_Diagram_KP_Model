%Tariqul Islam
%
%Submitted as per the requirement
%
%KRONIG PENNEY MODEL
%PLOT E-K DIAGRAM IN REDUCED AND EXTENDED ZONE PLOT
%

clear;
clc;

increment = 10^6; %in crement in value of k
steps=5; %uto this value of k*a/pi there will be extended zone plot

a=10^-9; %value of a
b=0.2*10^-9; %value of b
e=1.6*10^-19; %value of electron charge
V0 = e; %value of v0
me=9.11*10^-31; %value of electron mass
hcut=1.05457173 * 10^-34; %value of reduced planck's constant

P=me*V0*b*a/(hcut*hcut); %value of p
beta=@(E) (sqrt(2*me*E*e)/hcut); %value of beta as a function

f=@(E, coskav) (P*sin(beta(E)*a)/(beta(E)*a)+cos(beta(E)*a)-coskav); %actural function

%{
%reduced zone plot
for m=1:1
    k=[-(m*pi/a):increment:-(m-1)*pi/a,(m-1)*pi/a:increment:(m*pi/a)];
    coska=cos(k*a);
    N=length(k);
    J=zeros(2,N);
    Q=[];
    P=[];
    p=1;
    for i=1:N
        for j=1:N2
            if(abs(f(Y(j),coska(i)))<10^-04)
                P(p)=Y(j);
                Q(p)=k(i);
                p=p+1;
                warning('the enemy has been found');
            end
        end
        warning('loop ended');
    end
    plot(Q,P,'.');
    hold on;
    Y=Y(Y>max(J(1,:)));
    N2=length(Y);
end

%}

%subplot 1 has extended zone plot
subplot(1,2,1);
title('Extended Zone Plot');
ylabel('E (eV)');
xlabel('k*a/pi');
hold on;


%subplot 2 has reduced zone plot
subplot(1,2,2);
title('Reduced Zone Plot');
ylabel('E (eV)');
xlabel('k*a/pi');
hold on;

%extended Zone Plot
E1 = 0; %energy
m=1;
oldk = NaN; %saving the value of k of previous iteration
for m=1:steps
    k=(m-1)*pi/a:increment:(m*pi/a); %values of k
    coska=cos(k*a); %cos ka
    N=length(k); %length of k
    flag = 1;
    %matching each value of E,k to obtain f=0 (under certain tolerance
    %level)
    while 1
        for i=1:N
            if (abs(f(E1,coska(i)))<10^-04) %checking the function
                if ~isnan(oldk)
                    if (abs(k(i)) < abs(oldk)) %means k has to be increases beyond the current limit
                        flag = 0;
                        break;
                    else
                        oldk=k(i);
                        
                        %putting the value in extended zone
                        subplot(1,2,1);
                        plot(k(i)*a/pi,E1,'b');
                        plot(-k(i)*a/pi,E1,'b');
                        
                        hold on;
                        
                        %putting the value in reduced zone
                        min = floor(m/2)*2*pi/a;
                        subplot(1,2,2);
                        plot((k(i)-min)*a/pi,E1,'b');
                        plot((-k(i)+min)*a/pi,E1,'b');
                        
                        hold on;
                        drawnow;
                    end
                else
                    oldk=k(i);
                    subplot(1,2,1);
                    plot(k(i)*a/pi,E1,'b');
                    plot(-k(i)*a/pi,E1,'b');
                    
                    hold on;
                    
                    min = floor(m/2)*2*pi/a;
                    subplot(1,2,2);
                    plot((k(i)-min)*a/pi,E1,'b');
                    plot((-k(i)+min)*a/pi,E1,'b');
                    
                    hold on;
                    drawnow;
                end
                E1=E1+0.0000001;
                break;
            end
            E1=E1+0.000001;
        end
        if ~flag
            break;
        end
    end
end