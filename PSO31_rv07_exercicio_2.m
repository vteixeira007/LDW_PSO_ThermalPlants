%**************************************************************************
%                      Inteligência Computacional
% Algoritmo Linear Decreasing Weight Particle Swarm Optimization  (LDW-PSO)
% Determina os menor custo de operação para 3 termoeletricas
% Código fonte base obtido na internet e adpatado Edmarcio Belati - 2021.1
% Adaptações finais: Vinicius Teixeira
%**************************************************************************
close all hidden    %Apaga todas as figuras abertas
clear all           %Limpa todas as variaveis armazenadas no cache do Matlab
clc                 %Limpa o historico do prompt de comando do Matlab
tic                 %Inicia contagem de tempo da aplicação
%% Parâmetros
c1=1.5;			% Fator de aprendizado individual
c2=2.5;			% Fator de aprendizado global
W_max=0.9;		% Peso de inércia máximo
W_min=0.4;		% Peso de inércia mínimo
M=150;			% Número de partículas
I_max=500;		% Número máximo de iterações
V_max=4;        % Intervalo de velocidade [-4, 4]
%% Problema
N=3;				  % Número de dimensões
X_max= [196,114,332]; % Limite superior das variáveis
X_min= [100,50,200];  % Limite inferior das variáveis
Func=@FOB;            % Invoca a função objetivo
%% Loop principal
Run=30; % Número de execuções do algoritmo
for r=1:Run
    fprintf(2,['O algoritmo esta sendo executado pela: ',num2str(r),'\n']) % Imprime no Command Window quantas vezes o algoritmo está sendo executado
    % Inicialização
    for i=1:M
        for j=1:N
            x(i,j)=X_min(j)+rand()*(X_max(j)-X_min(j)); % Inicializa posição
            v(i,j)=rand()*(X_max(j)-X_min(j)); % Inicializa velocidade
        end
        Fit(i,:)=Func(x(i,:)); % Avalia a função objetivo
        Pb(i,:)=x(i,:);        % Inicializa melhor posição individual
    end
    % Obtém a melhor posição global
    [gb1,ind1]=sort(Fit);
    Gb(r,:)=x(ind1(1,1),:);
    %% Loop secundário
    for t=1:I_max
        % Atualiza a posição e velocidade
        t=t+1;

        for i=1:M
            % Atualiza o melhor posição Pb
            if Func(x(i,:))<Fit(i)
                Fit(i)=Func(x(i,:));
                Pb(i,:)=x(i,:);
            end
            % Atualiza o melhor posição global Gb
            if Func(Gb(r,:))>Fit(i)
                Gb(r,:)=Pb(i,:);
            end
            % Calcula o peso de inércia com decrescimento linear
            w=W_max-(W_max-W_min)*t/I_max; % Decrescimo linear
            v(i,:)=w*v(i,:)+c1*rand*(Pb(i,:)-x(i,:))+c2*rand*(Gb(r,:)-x(i,:));
            % Verifica os limites da velocidade
            for j=1:N
                if v(i,j)>V_max
                    v(i,j)=V_max;
                elseif v(i,j)<-V_max
                    v(i,j)=-V_max;
                end
            end
            % Atualiza a posição
            x(i,:)=x(i,:)+v(i,:);
            for j=1:N
                if x(i,j)>X_max(j)
                    x(i,j)=X_max(j);
                elseif x(i,j)<X_min(j)
                    x(i,j)=X_min(j);
                end
            end
        end
        Y(r,:)=Func(Gb(r,:)); % Armazena o melhor valor de fitness
        x1(r,:)=Gb(r,1); % Armazena a melhor posição x1
        x2(r,:)=Gb(r,2);  % Armazena a melhor posição x2
        x3(r,:)=Gb(r,3); % Armazena a melhor posição x3
        PG(r,:)=sum(Gb(r,:)); % Soma das melhores posições

        % Plot, apenas para visualização
        figure(100);
        plot(t,Y(r,:),'m.'); % Decrescimo linear
        xlabel('Iteration');
        ylabel('Fitness');
        title(sprintf('The Best Fitness: %.15f',Y(r,:)));
        grid on;
        hold on;
    end
end
% end
% Nomes dos tipos de peso de inércia
Names={'Decrescimento Linear'};
figure(200)
boxplot(Y,Names)
grid on, box on

fprintf(2,'     Run     x1       x2        x3        PG        Y\n');
resp=[(1:1:Run)' x1 x2 x3 PG Y]; % vetor utilizado para saída
format short
disp(resp);
toc % Finaliza contagem de tempo da aplicação