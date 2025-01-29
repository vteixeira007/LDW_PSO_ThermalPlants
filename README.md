# Planejamento da Operação de Sistemas Termoelétricos com PSO

## Autores
- THADEU CARNEIRO DA SILVA 
- VINICIUS DE LIRA TEIXEIRA

## Introdução
Este projeto aborda a resolução do problema de planejamento da operação de sistemas termoelétricos utilizando o algoritmo de Otimização por Enxame de Partículas com Peso de Inércia com Decrescimento Linear (LDW-PSO). O objetivo é minimizar o custo operacional das termoelétricas, considerando as restrições de igualdade e os limites operacionais.

## Descrição do Problema
### Função de Custo da Termoelétrica
A representação básica de um gerador térmico pode ser aproximada por uma função quadrática, conforme a equação:

$$ C_i = a_i + b_i \cdot P_i + c_i \cdot P_i^2 $$

Os coeficientes \( b \) e \( c \) estão diretamente relacionados com a utilização do combustível, enquanto o coeficiente \( a \) representa o custo relacionado à mão-de-obra e à manutenção da termoelétrica. Os dados para solução do problema são apresentados na Tabela 1.

#### Tabela 1. Dados Gerais do Problema
| Termoelétrica | \( a \) (\$/h) | \( b \) (\$/MWh) | \( c \) (\$/MW²h) | \( P_{min} \) (MW) | \( P_{max} \) (MW) |
|---------------|----------------|------------------|-------------------|--------------------|--------------------|
| 1             | 26.97          | -0.3975          | 0.002176          | 100                | 226                |
| 2             | 1.865          | -0.03988         | 0.001138          | 50                 | 114                |
| 3             | 39.79          | 0.3116           | 0.001457          | 200                | 332                |

### Função Objetivo
A função objetivo é minimizar o custo operacional, sujeita à restrição de igualdade do balanço da potência ativa:

$$ P_{G1} + P_{G2} + P_{G3} = 550 $$

Com os limites operacionais:

$$ 100 \leq P_{G1} \leq 196 $$
$$ 50 \leq P_{G2} \leq 114 $$
$$ 200 \leq P_{G3} \leq 332 $$

### Tratamento da Restrição de Igualdade
A restrição de igualdade é tratada adicionando um termo de penalidade à função objetivo:

$$ \text{FOB} = \sum_{i=1}^{3} C_i + \alpha \cdot \left( (P_{G1} + P_{G2} + P_{G3}) - 550 \right)^2 $$

Onde \( \alpha \) é o fator de penalidade.

## Solução do Problema

### Dados de Entrada
Para a solução do problema, implementou-se o algoritmo LDW-PSO no Octave/Matlab, adotando-se:
- Número máximo de iterações: 500
- Número de partículas: 150
- Número de dimensões do problema: 3
- Intervalos adotados de \( x \): \([196, 114, 332]\) e \([100, 50, 200]\)

Os parâmetros para determinar o peso de inércia de decrescimento linear foram:
- \( W_{max} = 0.9 \)
- \( W_{min} = 0.4 \)
- \( \alpha = 50 \)

### Análises dos Resultados
O processo de iteração pode ser observado na Figura 1. O número de iterações para esse problema pode ser otimizado, tendo em vista que por volta de 350 iterações, o valor da Função Objetivo é praticamente o mesmo (em torno de \( C = 93.37 \)).

!Figura 100

Na Tabela 2 são apresentados os valores de \( x1 \), \( x2 \), \( x3 \), \( PG \) e a função objetivo denominada como \( Y \). O tempo total para esse algoritmo solucionar esse problema foi de aproximadamente 29 minutos e 51 segundos.

#### Tabela 2. Valores de \( x1 \), \( x2 \), \( x3 \), \( PG \) e \( Y \) considerando um peso de inércia por decrescimento linear
| Run | \( x1 \) | \( x2 \) | \( x3 \) | \( PG \) | \( Y \) |
|-----|----------|----------|----------|----------|---------|
|  1  | 186.6782 | 114.0000 | 249.3218 | 550.0000 | 93.3749 |
| ... | ...      | ...      | ...      | ...      | ...     |
|  30 | 186.6782 | 114.0000 | 249.3218 | 550.0000 | 93.3749 |

Na Figura 2 tem-se o gráfico de caixa, no qual se pode observar que o algoritmo manteve seus resultados bastante concentrados em torno de 93.3749 com apenas um outlier em 93.69.

!Figura 200

## Conclusão
Neste trabalho, apresentaram-se modos diferentes de trabalhar com a Otimização por Enxame de Partículas. Para a resolução do Problema 2, implementou-se o algoritmo LDW-PSO, cujos resultados mantiveram-se bastante concentrados em torno de 93.3749 com apenas um outlier em 93.69. As soluções adotadas apresentaram resultados satisfatórios, destacando a importância de delimitar bem o problema para evitar um número excessivo de iterações.

## Referências
- Coello, C. A., et al. (2004). "Handling multiple objectives with particle swarm optimization."
- Shi, Y., & Eberhart, R. C. (1999). "Empirical study of particle swarm optimization."
- Jiao, B., et al. (2008). "A dynamic inertia weight particle swarm optimization algorithm."
- Yang, X., et al. (2007). "A modified particle swarm optimizer with dynamic adaptation."
- Lvbjerg, M., et al. (2001). "Hybrid particle swarm optimiser with breeding and subpopulations."
- Cavalca, D. L. (2018). "Algoritmo Híbrido De Otimização Por Enxame De Partículas Aplicado Ao Gerenciamento De Cargas Residenciais."
