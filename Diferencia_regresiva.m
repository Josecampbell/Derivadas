function[]=Diferencia_regresiva()
clc
syms x h
format long
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%----------------------Entrada de Datos--------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x0=1.8;%punto a evaluar
h0=[0.1 0.01 0.001];% h de prueba nota el h puede ser un vector
f=log(x);%funcion para calcular la derivada en un punto x0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%---------------------- Metodo -----------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
y=x+h;
y=matlabFunction(y);%comando para definir funciones que dependan de x y h
fh=subs(f,{x},{y});%comando para evaluar y en en la funcion f
df=(fh-f)/h;%formula de diferencia regresiva de la derivada
df=matlabFunction(df);%dy es la aproximacion de la derivada en el punto (h,x)
f=matlabFunction(f);%comando para definir funciones que dependan de x y h
y0=double(f(x0));%punto de prueba evaluado en la funcion
recta=double(df(h0,x0))*x+(-double(df(h0,x0))*x0+y0);
recta=matlabFunction(recta);%recta tangente en los puntos de prueba (x0,y0)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%----------------------Representacion grafica--------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
hold on;fplot(f,[x0-floor(x0),x0+ceil(x0)]);fplot(recta,[x0-floor(x0),x0+ceil(x0)]);scatter(x0,y0);legend('funcion','recta tangente','derivada en el punto');hold off
xlabel('eje x') %coamando xlabel para colocar nombre a el eje x
ylabel('eje y') %coamando label para colocar nombre a el eje y
title('Derivada diferencia regresiva')%el comando title para colocar nombre a las graficas
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%----------------------Guardar Resultados--------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
save('Diferencia Regresiva.mat','df') %guardando los resultados obtenidos

%dy es una funcion que depende de h y x para calcular derivada evaluada en
%un punto x0 de la forma dy(h0,x0 )

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%----------------------Informe Resultados--------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fileID=fopen('Diferencia Regresiva.txt','w'); %nombre de el archivo txt llamado biseccion
Resultados=h0'; %primera columna indica los distintos h0
y=x0+h0;
Resultados(:,2)=f(y)';
Resultados(:,3)=df(h0,x0)';
Resultados(:,4)=(h0/(2*x0^2))';
fprintf(fileID,'%5s %5s %5s %20s\n','h','f(x+h)','df(x)','aproximacion del error');
fprintf(fileID,' %12.8f %12.8f %12.8f %12.8f\n',Resultados');
fclose(fileID);
end
