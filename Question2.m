% Matlab file used in the 2nd question of the homework of macroeconomics

% Declares the vector a with the approximation and the matrix B with the
% transition matrix
[a,B] = tauchen(20,log(0.36*0.95)/(1-0.36),0.36,0.01,3)

%Plot the vector a with the numerical approximation
eje = 1:1:20
plot(eje,a)
title('Results of Tauchen algorithm in Matlab')
xlabel('Iterations')
ylabel('Expected value')
print -djpeg Fig1Quest3.jpg
pause

%3D Plot of the transition matrix
surfl(a,a,B)
title('Plot of the joint density of the transition matrix')
xlabel('Values of ln(k(t))')
ylabel('Values of ln(k(t+1))')
zlabel('Probability')
grid on
print -djpeg Fig2Quest3.jpg
pause

%Subplots of the ergodic transition matrix
C=B^20
c=C(20,1:20)

%Plot of 3D joint density
surfl(a,a,C)
title('Plot of the joint density of the ergodic transition matrix')
xlabel('Values of ln(k(t))')
ylabel('Values of ln(k(t+1))')
zlabel('Probability')
grid on
print -djpeg Fig3Quest3.jpg
pause

%Subplot of conditional density of ln(k)
subplot(2,1,1)
plot(a,c)
title('Ergodic density of the matrix pi')
xlabel('Values of ln(k)')
ylabel('Probability')

%Subplot of conditional density of ln(k)
subplot(2,1,2)
semilogy(exp(a),c)
title('Ergodic density of the matrix pi')
xlabel('Values of k')
ylabel('Probability')
print -djpeg Fig4Quest3.jpg

clc
descr = {'Please close graph window, then click HERE in the command window and finally press any key'}
pause

%Plot of analytical conditional density of k
d=0.18:0.001:0.20
e=lognpdf(d,log(0.36*0.95)/0.64,sqrt((0.01^2)/(1-0.36)))/1000/0.9995
plot(d,e,'-'), hold on
title('Analytical and empirical ergodic density of the matrix pi')
xlabel('Values of k')
ylabel('Probability')
semilogy(exp(a),c,':'), hold off
hleg1=legend(strcat('Analytical, skewness=',num2str(skewness(e))),strcat('Numerical, skewness=',num2str(skewness(c))))
print -djpeg Fig5Quest3.jpg

clc