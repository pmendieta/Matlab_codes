%Simulacion sobre la diversidad y la utilidad

clc;
clear;
 
%number of varieties
mind=50;
maxd=100;
range=maxd-mind;
 
%number of replications for each variety
rep=500;
 
UV=zeros(range,1);
UO=zeros(range,1);
WLP=zeros(range,1);
 
for p=1:range
    aux=zeros(rep,1);
    aux1=zeros(rep,1);
    for m=1:rep
        [U,LP]=DS(p);
        aux(m)=U;
        aux1(m)=LP;
    end
    UO(p)=mean(aux);
    aux=aux/min(aux);
    UV(p)=mean(aux);
    WLP(p)=mean(aux1);
    clc;
    'Variedad'; p
end
 
subplot(2,1,1);
plot(UO,'r');
title('Utilidad según la diversidad');
xlabel({'\omega','(Diversidad)'});
ylabel('Utilidad');
 
subplot(2,1,2);
ksdensity(WLP);
title('Nivel general de precios acorde a la diversidad');
xlabel({'Nivel general de precios'});
ylabel('Frecuencia');
 
clc;
'Done'
