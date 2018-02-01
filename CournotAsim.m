%Programa de resolucion del modelo de Cournot con informacion asimetrica y distribucion continua de precios

clear;
clc;
 
a=40;
cost=10;
sigma=5;
 
F = makedist('normal','mu',cost,'sigma',sigma);
FT = truncate(F,3,7);
 
Ndraws=10000;
 
c_est=random(F,Ndraws,1);
 
q_A=1/3*(a-2*cost+mean(c_est));
 
q_B=zeros(Ndraws,1);
p=zeros(Ndraws,1);
profit_A=zeros(Ndraws,1);
profit_B=zeros(Ndraws,1);
 
for i=1:Ndraws
    q_B(i)=1/3*(a+cost)-1/6*(mean(c_est)-cost)+1/6*(2*cost-c_est(i));
    p(i)=a-q_A-q_B(i);
    profit_A(i)=(p(i)-cost)*q_A;
    profit_B(i)=(p(i)-c_est(i))*q_B(i);
end
 
[f1,k1]=ksdensity(profit_A);
[f2,k2]=ksdensity(profit_B);
figure;
plot(k1,f1,'r'), hold on;
plot(k2,f2,'g'), hold off;
title(' Beneficios de las empresas A y B');
xlabel('$');
legend('Empresa A (Costo aleatorio)','Empresa B (Costo estable)');
 
pause;
 
q_Av=q_A*ones(Ndraws,1);
q=q_Av+q_B;
scatter(q_B,p,'b'), hold on
scatter(q_Av,p,'r')
scatter(q,p,'g'), hold off
legend('Empresa B','Empresa A','Total');
 
pause;
 
[f3,k3]=ksdensity(p);
[f4,k4]=ksdensity(c_est);
figure;
plot(k3,f3,'r'), hold on;
plot(k4,f4,'g'), hold off;
title('Precios y costos');
xlabel('$');
legend('Precio','Costo variable');
