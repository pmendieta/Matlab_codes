%Modelo basico de busqueda en el mercado laboral basado en Mauricio Tejada.

clear;
clc;

%Parametros
b=1;
alpha=0.3;
r=0.1;
mu=0.8;
sigma=0.5;

%CDF
pd = makedist('lognormal','mu',mu,'sigma',sigma);

%Iteraciones
R0=1;

diff=10;
tol=0.00001;
step=0.5;

fun = @(x) 1-cdf(pd,x);

while diff>tol;
    R1 = b+(alpha/r)*integral(fun,R0,inf);
    diff=abs(R1-R0);
    R0   = R0 + step*(R1-R0);
end

Msg1 = 'El salario de reserva es'; 
Msg1, R1
'Presione una tecla para continuar en la ventana de comando'

pause;

%Grafico de equilibrio
w=0:1:5;
U=R1/r*ones(rows(w'))';
Nw = w/r;

plot(w,U,'r',w,Nw);
string1=['Valor de la iteración: ',num2str(R1)];
title({' Salario de Reserva de Equilibrio', string1});

xlabel('\omega');
ylabel('U,  N(\omega)');

pause;

clc;

Y=zeros(6);
[h,R1_]=SolveModel(b,alpha,r,mu,sigma); 

%Prueba del modelo
Msg2 = 'Prueba de la subrutina construida. El salario de reserva es'; 
Msg2, R1_
Msg3 = 'La duracion promedio del desempleo es: ';
Msg3, 1/h
%'Presione una tecla para continuar en la ventana de comando'
%pause;

%Efecto de un cambio del ingreso en situacion de desempleo
b_values = 0:0.25:2;
R_values = zeros(1,rows(b_values'));
h_values = zeros(1,rows(b_values'));

for i=1:1:9
    [h,R1_]=SolveModel(b_values(i),alpha,r,mu,sigma);
    R_values(i)= R1_;
    h_values(i) = h;
end

%Grafico de sensibilidad de R respecto a b
subplot(2,1,1);
plot(b_values,R_values,'r');
title(' Efecto de b sobre el salario de reserva');
xlabel('b');
ylabel('R');
grid on;

%Grafico de sensibilidad de 1/h respecto a b
subplot(2,1,2);
plot(b_values,h_values,'r');
title(' Efecto de b sobre la probabilidad de salir del desempleo');
xlabel('b');
ylabel('h');
grid on;

'Presione una tecla para continuar en la ventana de comando'
pause;

%Efecto de un cambio en la tasa de arribo de nuevos empleos
alpha_values = 0:0.2:1;
clear R_values;
R_values = zeros(1,rows(alpha_values'));
clear h_values;
h_values = zeros(1,rows(alpha_values'));

for i=1:1:6
    [h,R1_]=SolveModel(b,alpha_values(i),r,mu,sigma);
    R_values(i)= R1_;
    h_values(i) = h;
end

%Grafico de sensibilidad de R respecto a alpha
subplot(2,1,1);
plot(alpha_values,R_values,'r');
title(' Efecto de \alpha sobre el salario de reserva');
xlabel('\alpha');
ylabel('R');
grid on;

%Grafico de sensibilidad de 1/h respecto a alpha
subplot(2,1,2);
plot(alpha_values,h_values,'r');
title(' Efecto de \alpha sobre la probabilidad de salir del desempleo');
xlabel('\alpha');
ylabel('h');
grid on;

pause;

F = makedist('lognormal','mu',mu,'sigma',sigma);
FT = truncate(F,R1,Inf);

Ndraws=10000;

w1=random(F,Ndraws,1);
w2=random(FT,Ndraws,1);

[f1,k1]=ksdensity(w1);
[f2,k2]=ksdensity(w2);
figure;
plot(k1,f1,'r'), hold on;
plot(k2,f2,'b'), hold off;
title(' Densidad de salarios ofrecidos y aceptados');
xlabel('\omega');
