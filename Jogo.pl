inicia() :- matrizBase(X), imprimeMatriz(X).

%% Imprime a matriz atual do jogo
imprimeMatriz([]) :- !.
imprimeMatriz([H|T]) :- imprimeLista(H), nl, imprimeMatriz(T).

%% Imprime uma lista de elementos
imprimeLista([]):- !.
imprimeLista([H|T]) :-
  write(H), 
  write(" "),
  imprimeLista(T).

%% Recupera elemento da lista
recuperaElemento(X, Y, Elemento) :- matrizBase(Matriz), achaX(X,0,Matriz,ListaX), achaY(Y,0,ListaX,Elemento).

%%Acha posição X na Lista
achaX(_, _, [], _) :- false.
achaX(X, Aux, [Resp|_], Resp) :- X == Aux.
achaX(X, Aux, [_|T], R) :- Aux1 is Aux + 1, achaX(X,Aux1,T,R).

%%Acha posição Y na Lista
achaY(_,_,[],_) :- false.
achaY(Y,Aux,[H|_],H) :- Y == Aux.
achaY(Y,Aux,[_|HT],R) :- Aux1 is Aux + 1, achaY(Y,Aux1,HT,R).

%%Descobre vizinhos de (X,Y)
elementosVizinhos(X,Y,[S,I,D,E]) :- elementoSuperior(X,Y,S), elementoInferior(X,Y,I),elementoDireita(X,Y,D),elementoEsquerda(X,Y,E).
elementoSuperior(X,Y,Elemento) :- N is X-1,recuperaElemento(N,Y,Elemento).
elementoInferior(X,Y,Elemento)  :- N is X+1,recuperaElemento(N,Y,Elemento).
elementoDireita(X,Y,Elemento) :- N is Y+1,recuperaElemento(X,N,Elemento).
elementoEsquerda(X,Y,Elemento) :- N is Y-1,recuperaElemento(X,N,Elemento).

%%Verifica se jogo chegou ao fim
fimDeJogo() :- matrizBase(Matriz), verificaFim(Matriz,X), X < 2.
verificaFim([],X) :- X is 0, !.
verificaFim([H|T],X) :- verificaFimColuna(H,X1), verificaFim(T,X2), X is X1 + X2.
verificaFimColuna([],X) :- X is 0, !.
verificaFimColuna([H|T],R) :- H == -1, verificaFimColuna(T, R).
verificaFimColuna([H|T],X) :- H == 0, verificaFimColuna(T, R), X is R+1.

%%Tenta achar solução
%jogar(X,Y) :- matrizBase(Matriz), mover(Matriz, X, Y).
%mover(Matriz, X,Y) :- x == 0, y == 0, moveDireita().
%mover(Matriz, X,Y) :- x == 0, y == 0, moveAbaixo().

%%Muda numero em (X,Y)
%reduz(X,Y) :- recuperaElemento(X, Y, Z).

%%Matriz usada
matrizBase([[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]).