function [U,LP] = DS(var)

%Subrutina para la solución del modelo de Dixit y Stiglitz

nd=var;
 
%income
I=100;
 
%substitution elasticity
sigma=1.5;
rho=1-1/sigma;
 
%Marginal costs
 
cost=5; %mean marginal cost
sigma_cost=1; %sd of marginal costo
truncation=2; %truncation of marginal cost distribution
 
F = makedist('normal','mu',cost,'sigma',sigma_cost);
FT = truncate(F,cost-truncation,cost+truncation);
 
mc=random(F,nd,1);
 
%specific prices and whole level price
price=mc/(1-1/sigma);
 
for j=1:nd
    p_i=price(j)^(1-sigma);
end
 
LP=sum(p_i);
 
%quantities 
q=zeros(nd,1);
v=zeros(nd,1);
 
for i=1:nd
    q(i)=(I/LP)*(price(i)/LP)^(-sigma);
    v(i)=q(i)^rho;
end
 
%utility
U=(sum(v))^(1/rho);
