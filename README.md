# Jogo_MovimentacaoEmMatriz_Prolog
## Trabalho Prático 1
## Liguagens de Programacao
### Professor Guilherme Baumgratz Figueiroa
### Abril 2019

## 1 Sobre o Trabalho

O objetivo ́e solucionar o problema descrito na seccao 2.

```
O jogo n ̃ao limita em nada utilizar qualquer predicado, somente diz o que se deseja e qual deve
ser o resultado.
```
Esse trabalho deve:

- Ser implementado em linguagem Prolog.
- Ser desenvolvido de forma individual ou dupla.
- Estar bem documentado e identificado.

## 2 O Problema

Considere uma matriz M de n ́umeros inteiros e um marcador P em uma dada c ́elula (X,Y) da M. P pode andar para cima, para baixo, direita e esquerda de M, desde que essa c ́elula tenha um valor maior ou igual a zero. Quando P sai de (X,Y) para um nova celula, seu valor devera ser decrementado.

Desevolva um programa logico que dado uma matriz M qualquer e um posicao para o marcador P, determine uma lista de passos que deve ser seguidos para que essa matriz fique com o valor negativo em todas as suas celuas. Deve-se anotar todas as possibilidades de passos e deve-se escrever em um arquivo o seu resultado.

Por exemplo, ́e passado a Matriz 1 e a posicao(0,0). Caso desejamos ir para a direita, ira gerar a nova Matriz 2, em que estamos na posição (0,1), porem a posição (0,0) agora ́e 0, assim, so ́e permitido andar mais uma vez sobre essa posição.
Portando o objetivo ́e achar o caminho que seja capaz e andar por toda a matriz sem que se passe por valores negativos. O passo a passo que tem que ser dado para alcancar todas as posicoes da matriz

#### 1

```
Universidade Federal de Ouro Preto - UFOP
Departamento de Computacao e Sistemas - DECSI
```
```
1 1 1 1
1 1 1 1
1 1 1 1
1 1 1 1
```
```
Tabela 1: Matriz inicial e posicao (0,0)
```
```
0 1 1 1
1 1 1 1
1 1 1 1
1 1 1 1
```
```
Tabela 2: Matriz do primeiro passo
```
deve ser um lista de passos que diz se vai ir para cima, direita, embaixo ou esquerda. O programa deve ser capaz de criar um arquivo que deve conter todas as possibilidades de andar na matriz completa, em que cada passo ́e separado por um espaco e cada linha diz qual a sequencia de passos para alcancar todas as posicoes da matriz.

Entrega e Crit ́erios de Avalia ̧c ̃ao Todo oc ́odigo fonteproduzido deve ser entregue em um ́unico arquivo comprimido (.zip) no moodle ate as 23h e 59m do dia 02/06/2019.

```
Atenção
```
```
Esteja ciente que os codigos fontes serao verificados automaticamente por plagio e copia. Caso
constado cópia ambos os trabalhos serão zerados. não será permitido atrasos, sendo considerado
ao aluno atrasado, zero.
```
```
Critério Descrição Valor Modo
Assiduidade Código bem documentado, edentado, emprego de nomes apropriados dos functores
```
```
2,0 Binário
```
```
Organização Uma boa divisãao das partes do trabalho o que deixa o entendimento da mesma facilitado
```
```
1,0 Continuo
```
```
Entrevista Domínio do aluno frente a entrevista e perguntas realizadas durante a mesma
```
```
5,0 Continuo
```
```
Compilação Se o trabalho compila 1,0 Binario
Testes de execução Testes do funcionamento do trabalho 1,0 Binário
```
```
Tabela 3: Distribuição dos pontos
```
