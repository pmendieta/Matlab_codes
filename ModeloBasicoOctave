%Primera parte de la tarea de mercado laboral basado en la programación en Python de Mauricio Tejada para Octave

clear;
clc;

pkg load statistics

%Parametros
b=1;
alpha=0.3;
r=0.1;
mu=0.8;
sigma=0.5;

%CDF
%pd = makedist('lognormal','mu',mu,'sigma',sigma);

%Iteraciones
R0=1;

diff=10;
tol=0.00001;
step=0.5;


f = @(x) 1-logncdf(x,mu,sigma);

while diff>tol;
    R1 = b+(alpha/r)*quadcc(f,R0,inf);
    diff=abs(R1-R0);
    R0   = R0 + step*(R1-R0);
end

Msg1 = 'El salario de reserva es'; 
Msg1, R1

%pause;

%Grafico de equilibrio
w=0:1:5;
