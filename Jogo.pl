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

%%Descobre opções de caminhos
elementosVizinhos(X,Y,[S,I,D,E]) :- elementoSuperior(X,Y,S), elementoInferior(X,Y,I),elementoDireita(X,Y,D),elementoEsquerda(X,Y,E).
elementoSuperior(X,Y,Elemento) :- N is X-1,recuperaElemento(N,Y,Elemento).
elementoInferior(X,Y,Elemento)  :- N is X+1,recuperaElemento(N,Y,Elemento).
elementoDireita(X,Y,Elemento) :- N is Y+1,recuperaElemento(X,N,Elemento).
elementoEsquerda(X,Y,Elemento) :- N is Y-1,recuperaElemento(X,N,Elemento).




%%Descobre quantos elementos tem na lista
%qntElemLista([],0).
%qntElemLista([_|T], S) :- qntElemLista(T,G), S is 1+G.

%%Matriz usada
matrizBase([[1,2,3,4],[5,6,7,8],[9,10,11,12],[13,14,15,16]]).