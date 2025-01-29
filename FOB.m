function Y = FOB (x)
% Função Objetivo para minimizar o custo de operação das termoelétricas

% Coeficientes da função de custo para cada termoelétrica
a=[26.97,1.865,39.79];
b=[-0.3975,-0.03988,-0.3116];
c=[0.002176,0.001138,0.001457];

% Potências geradas por cada termoelétrica
PG=[x(1),x(2),x(3)];

% Número de termoelétricas
m=3;

% Inicializa o valor da função de custo
f=0;
% Calcula o custo de operação para cada termoelétrica
for e=1:m
    f=f+a(e)+b(e)*x(e)+c(e)*x(e)^2;
    %f=a(e)+b(e)*x(e)+c(e)*x(e)^2;
end
% Adiciona o termo de penalidade para a restrição de igualdade
Y=f+50*abs((x(1)+x(2)+x(3))-550);

% Solução esperada
% x1=186.678
% x2=114
% x3=93.3749
end

