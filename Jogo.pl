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

%%Descobre quantos elementos tem na lista
%qntElemLista([],0).
%qntElemLista([_|T], S) :- qntElemLista(T,G), S is 1+G.

%%Matriz usada
matrizBase([[1,2,9],[3,4,2],[1,2,3]]).