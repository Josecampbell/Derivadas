function[]=extrapolacion_Richardson()
clc
syms x 
format long
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%----------------------Entrada de Datos--------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x0=2.0;%punto a evaluar
h0=0.2;% h de prueba nota el h puede ser un vector
f=x*exp(x);%funcion para calcular la derivada en un punto x0
N=extrapolacion(f,x0,h0);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%----------------------Parametros de salidad---------------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%N es la matrix de extrpolación cuyas columnas es el orden del metodo el
%termino N(4,4) es el resultado de la derivada de orden O(4)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%---------------------- Informe ---------------------------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
save('Extrapolacion Richardson.mat','N') %guardando los resultados obtenidos
fileID=fopen('Extrapolacion Richardson.txt','w'); %nombre de el archivo txt llamado Extrapolacion Richardson
fprintf(fileID,'N(h)\t');
fprintf(fileID,'%12.8f\t',N(1,:));
fprintf(fileID,'\n');
fprintf(fileID,'N(h/2)\t');
fprintf(fileID,'%12.8f\t',N(2,:));
fprintf(fileID,'\n');
fprintf(fileID,'N(h/4)\t');
fprintf(fileID,'%12.8f\t',N(3,:));
fprintf(fileID,'\n');
fprintf(fileID,'N(h/8)\t');
fprintf(fileID,'%12.8f\t',N(4,:));
fprintf(fileID,'\n');
fclose(fileID);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %---------------------- Representación Grafica --------------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pendientes=diag(N); %derivadas de O(h),0(h^2),O(h^3),O(h^4)
f=matlabFunction(f);
y0=f(x0); %imagen del punto x0
close all
hold on;fplot(f,[x0-floor(x0),x0+ceil(x0)]);
for i=1:4
     rectas=pendientes(i)*x+y0-pendientes(i)*x0; % construyendo las rectas tangentes con las distintas derivadas de ordenes O(h),O(h^2),O(h^3),O(h^4)
     rectas=matlabFunction(rectas);
     fplot(rectas,[x0-floor(x0),x0+ceil(x0)]);
end
scatter(x0,y0);legend('funcion','rectas tangente','derivada en el punto');hold off
xlabel('eje x') %coamando xlabel para colocar nombre a el eje x
ylabel('eje y') %coamando label para colocar nombre a el eje y
title('Extrapolación Richardson')%el comando title para colocar nombre a las graficas
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %---------------------- Metodo ------------------------------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function[N]=extrapolacion(f,x0,h0)
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %--------------------- diferencia tres puntos -------------------------- %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
syms x h
y=[x-h x+h]; %terminos a evaluar en las funciones 
g(1)=subs(f,{x},{y(1)});%comando para evaluar y en en la funcion f
g(2)=subs(f,{x},{y(2)});%comando para evaluar y en en la funcion f
df=(g(2)-g(1))/(2*h);%esta formula calcula la derivada de f(x0) en funcion de los puntos (x0+h) y (x0-h)
df=matlabFunction(df);%calculo de la derivada con respecto a el punto x y el parametro h
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %--------------------- extrapolacion -------------------------- %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=0:3
    N(i+1,1)=double(df(h0/(2^i),x0)); %derivadas de terminos de orden h
end 

 for i=2:4
     for j=2:i
         N(i,j)=N(i,j-1)+(N(i,j-1)-N(i-1,j-1))/(4^(j-1)-1);%derivadas de ordenes h^2, h^3 y h^4
     end
 end


end