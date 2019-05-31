%% Função que inicia o jogo
%% Parametros: Posição inicial X, posição inicial Y, a matriz do jogo, retorno
%% Retorno: uma lista com todos os caminhos possíveis de solução.
play(X,Y,Matriz,Caminhos):-bagof(Caminho,jogar(X,Y,Matriz,Caminho),Caminhos),escreveArq(Caminhos).

%% Imprime a matriz atual do jogo, imprimindo cada lista interna da matriz
%% Parametros:Lista de elementos
%% Retorno: Chamada da função imprimeLista
imprimeMatriz([]).
imprimeMatriz([H|T]) :- imprimeLista(H),nl, imprimeMatriz(T).

%% Imprime uma lista de elementos, escreve a cabeça, uma virgula e chama novamente a função 
%% até que a lista esteja vazia.
%% Parametros: Lista
%% Retorno: Lista Impressa  no console
imprimeLista([]).
imprimeLista([H|T]) :- write(H),  write(", "), imprimeLista(T).

%% Função responsável por abrir e fechar o aquivo, além de chamar função para 
%% efetivamente escrever cada linha do arquivo. Escreve no arquivo caminho.txt.
%% Parametros: Lista
%% Retorno: Arquivo caminho.txt aberto e após função escreveRota, fecha o arquivo
escreveArq([]).
escreveArq(Rota) :- open('caminho.txt', write, ID), escreveRota(Rota,ID), close(ID).

%% Escreve a rota em uma linha do arquivo, recebido no parametro ID, e pula uma linha.
%% Parametros: Lista, referencia ao arquivo
%% Retorno: Lista escrita no arquivo
escreveRota([],_) .
escreveRota([H|[]],ID) :- write(ID, H).
escreveRota([H|T],ID) :- write(ID, H), write(ID,'\n'), escreveRota(T,ID).

%% Recupera elemento na posição X Y da matriz
%% Parametros: Posição X, posição Y, matriz, resposta
%% Retorno: Elemento na posição (X,Y)
recuperaElemento(X, Y,Matriz, Elemento):-achaElemento(X,0,Matriz,ListaX), achaElemento(Y,0,ListaX,Elemento).
%% Acha um elemento (lista ou número) em uma posição em uma determinada lista.
%% Parametros: posição do elemento, auxiliar de posição, Matriz e a Resposta.
%% Retorno: Elemento na posição recebida.
achaElemento(_,_,[],_) :- false.
achaElemento(Elemento,Aux,[R|_],R) :- Elemento == Aux.
achaElemento(Elemento,Aux,[_|HT],R) :- Aux1 is Aux + 1, achaElemento(Elemento,Aux1,HT,R).

%% Descobre vizinhos do elemento em (X,Y)
%% Parametros: Posição X, posição Y, resposta, Matriz
%% Retorno: elemento superior em S, inferior em I, a direita em D e a esquerda em E.
elementosVizinhos(X,Y,Matriz,[S,I,D,E]) :- elementoSuperior(X,Y,Matriz,S),
										   elementoInferior(X,Y,Matriz,I), 
										   elementoDireita(X,Y,Matriz,D),
										   elementoEsquerda(X,Y,Matriz,E).
%%Descobre vizinho de (X,Y)
%% Parametros: Posição X, posição Y, Matriz, Resposta
%% Retorno: Elemento vizinho
elementoSuperior(X,Y,Matriz,Elemento) :- N is X-1, recuperaElemento(N,Y,Matriz,Elemento).
elementoSuperior(_,_,_,-5).
elementoInferior(X,Y,Matriz,Elemento) :- N is X+1, recuperaElemento(N,Y,Matriz,Elemento).
elementoInferior(_,_,_,-5).
elementoDireita(X,Y,Matriz,Elemento) :- N is Y+1, recuperaElemento(X,N,Matriz,Elemento).
elementoDireita(_,_,_,-5).
elementoEsquerda(X,Y,Matriz,Elemento) :- N is Y-1, recuperaElemento(X,N,Matriz,Elemento).
elementoEsquerda(_,_,_,-5).

%% Se verificaFim der como resposta 1, retorna true
%% Parametros: Matriz
%% Retorno: true se jogo chegou ao fim
fimDeJogo(Matriz) :- verificaFim(Matriz,X), X == 1.
%% Verifica se todos os elementos são -1, e se for 0, incrementa contador
%% Parametros: Matrix, reposta
%% Retorno: Quantidade de 0's na matriz
verificaFim([],X) :- X is 0.
verificaFim([H|T],X) :- verificaFimLinha(H,X1), verificaFim(T,X2), X is X1 + X2.
%% verifica se todos elementos da lista são -1 e conta a quantidade de 0's
%% Parametros: Matrix, reposta
%% Retorno: Quantidade de 0's na lista
verificaFimLinha([],X) :- X is 0, !.
verificaFimLinha([H|T],R) :- H == -1, verificaFimLinha(T, R).
verificaFimLinha([H|T],R) :- H == 0, verificaFimLinha(T, X), R is X+1.

%% Verifica se existe alguma jogada possível, ou seja, se tem vizinhos maiores ou iguais a 0.
%% Parametros: Matrix, Posição X, posição Y
%% Retorno: true se não existe alguma jogada possível
impossivelJogar(Matriz, X,Y) :- elementosVizinhos(X,Y,Matriz,Resp), verificaLista(Resp).
%% Verifica se existe elemento menor que 0 na lista
%% Parametros: Lista
%% Retorno: Ture se existe elemento menor que zero
verificaLista([]).
verificaLista([H|T]) :- H < 0, verificaLista(T).

%% Função que realiza as jogadas, caso não tenha acabado o jogo e existe movimento possível
%% movimenta acima, abaixo, esquerda ou direita.
%% Parametros: Posição X, posição Y, Matriz, Resposta
%% Retorno: Acrescenta letra eferente ao caminho escolhido 
%% S para superior, I para inferior, E para esquerda, D para direita
jogar(X,Y,Matriz, []) :- fimDeJogo(Matriz), recuperaElemento(X,Y,Matriz,0).
jogar(X,Y,Matriz, _) :- impossivelJogar(Matriz, X,Y), fail.
jogar(X,Y,Matriz,["S"|Rota]) :- elementoSuperior(X,Y,Matriz,Z),Z > -1,
					decrementa(X,Y,Matriz,NMatriz),NX is X-1,jogar(NX, Y,NMatriz,Rota).
jogar(X,Y,Matriz,["I"|Rota]) :- elementoInferior(X,Y,Matriz,Z),Z > -1, 
					decrementa(X,Y,Matriz,NMatriz), NX is X+1,jogar(NX, Y,NMatriz,Rota).
jogar(X,Y,Matriz,["E"|Rota]) :- elementoEsquerda(X,Y,Matriz,Z),Z > -1,
					decrementa(X,Y,Matriz,NMatriz),NY is Y-1,jogar(X, NY,NMatriz,Rota).
jogar(X,Y,Matriz,["D"|Rota]) :- elementoDireita(X,Y,Matriz,Z) ,Z > -1,
					decrementa(X,Y,Matriz,NMatriz),NY is Y+1,jogar(X, NY,NMatriz,Rota).

%% Decrementa 1 na posição (X,Y) na matriz
%% Parametros: Posição X, posição Y, Matriz, resposta
%% Retorno: resposta com posição (X,Y) decrementada em 1
decrementa(X,Y,Matriz, MatrizAtualizada) :- reduzX(X,Y,0,0,Matriz,MatrizAtualizada).

%% Acha posição em X para decrementar.
reduzX(X,Y,    X, AuxY, [H|T], [LAlt|T]) :- reduzY(X,Y, AuxY,  AuxY, H, LAlt).
reduzX(X,Y, AuxX, AuxY, [H|T], [   H|Mat]) :- NAuxX is AuxX+1, reduzX(X,Y,NAuxX, AuxY, T,  Mat).
%% Decrementa posição em Y.
reduzY(_,Y, _,    Y, [H|T], [NH|T]) :- NH is H-1.
reduzY(_,Y, _, AuxY, [H|T], [ H|MAT]) :- NY is AuxY+1, reduzY(_,Y, _, NY, T, MAT).