function [h,R1_] = SolveModel(b0,a0,r0,mu0,sigma0)

% Rutina para correr el programa completo de búsqueda de empleo, basado en Mauricio Tejada en Python.


%CDF
pd = makedist('lognormal','mu',mu0,'sigma',sigma0);

%Iteraciones
R0_=1;

diff=10;
tol=0.00001;
step=0.5;

fun = @(x) 1-cdf(pd,x);

while diff>tol;
    R1_ = b0+(a0/r0)*integral(fun,R0_,inf);
    h=a0*fun(R1_);
    diff=abs(R1_-R0_);
    R0_ = R0_ + step*(R1_-R0_);
end
