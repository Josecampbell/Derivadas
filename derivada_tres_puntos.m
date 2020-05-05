function[]=derivada_tres_puntos()
clc
syms x h
format long
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%----------------------Entrada de Datos--------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f=x*exp(x);%funcion para calcular la derivada en un punto x0
x0=2.0;%punto de prueba a evaluar
h0=0.1;%h de prueba
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %---------------------- Metodo ------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
y=[x-h x+h];
g(1)=subs(f,{x},{y(1)});%comando para evaluar y en en la funcion f
g(2)=subs(f,{x},{y(2)});%comando para evaluar y en en la funcion f
df=(g(1)-g(2))/(2*h);%esta formula calcula la derivada de f(x0) en funcion de los puntos (x0+h) y (x0-h)
df=matlabFunction(df);%calculo de la derivada con respecto a el punto x y el parametro h
f=matlabFunction(f);
y0=f(x0);
recta=double(df(h0,x0))*x+(-double(df(h0,x0))*x0+y0);
recta=matlabFunction(recta);%recta tangente en los puntos de prueba (x0,y0)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%----------------------Representacion grafica--------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
hold on;fplot(f,[x0-floor(x0),x0+ceil(x0)]);fplot(recta,[x0-floor(x0),x0+ceil(x0)]);scatter(x0,y0);legend('funcion','recta tangente','derivada en el punto');hold off
xlabel('eje x') %coamando xlabel para colocar nombre a el eje x
ylabel('eje y') %coamando label para colocar nombre a el eje y
title('Derivada tre puntos')%el comando title para colocar nombre a las graficas
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%----------------------Guardar Resultados--------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
save('Diferencia tres puntos.mat','df') %guardando los resultados obtenidos
end
