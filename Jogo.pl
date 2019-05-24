inicia() :- matrizBase(X), imprimeMatriz(X).

%% Imprime a matriz atual do jogo
imprimeMatriz([]) :- !.
imprimeMatriz([H|T]) :- imprimeLista(H), nl, imprimeMatriz(T).

%% Imprime uma lista de elementos
imprimeLista([]):- !.
imprimeLista([H|T]) :-
  write(H), 
  write(", "),
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
fimDeJogo() :- matrizBase(Matriz), verificaFim(Matriz,X), X == 1.
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
insereLista(E,X,[E|X]).
insereFimLista(E,Lista,R) :- append(Lista,E,R).

decrementa(X,Y,MatrizAtualizada) :-  matrizBase(Matriz), reduzX(X,Y,0,0,Matriz, MatrizAtualizada).
reduzX(_,_,_,_,[],NResp) :- !.
%reduzX(X,Y,XAux,YAux,[H|T],Resp) :- X == XAux, reduzY(Y,YAux,H,NL), insereLista(NL,Resp,NResp), NX is XAux+1, reduzX(X,Y,NX, YAux,T,NResp).
reduzX(X,Y,XAux,YAux,[H|T],Resp) :- X == XAux, insereLista([H|H],Resp,NResp), NX is XAux+1, reduzX(X,Y,NX, YAux,T,NResp).
reduzX(X,Y,XAux,YAux,[H|T],Resp) :- insereLista(H,Resp,NResp), NX is XAux+1, reduzX(X,Y,NX, YAux,T,NResp).
reduzY(_,_,[],Resp).
reduzY(Y,YAux,[H|T],Resp) :- Y == YAux, NH is H-1, insereLista(NH,Resp,NResp), NY is YAux+1, reduzY(Y,NY,T,NResp).
reduzY(Y,YAux,[H|T],Resp) :- insereLista(H,Resp,NResp), NY is YAux+1, reduzY(Y,NY,T,NResp).



%% decrementa(X,Y,MatrizAtualizada) :-  matrizBase(Matriz), reduz(X,Y,0,0,Matriz, MatrizAtualizada).
%% reduz(X,Y,XAux,YAux,[H|T], Resp) :- X == XAux, Y == YAux, NH is H+1, insereFimLista(NH,Resp, XResp), insereFimLista(T,XResp, XResp).
%% reduz(X,Y,XAux,YAux,[H|T], Resp) :- X == XAux, NYAux is YAux+1, insereFimLista(H,Resp,XResp), reduz(X,Y,XAux,NYAux,T,XResp).
%% reduz(X,Y,XAux,YAux,[H|T], Resp) :- NXAux is XAux+1, insereFimLista(H,Resp,XResp), reduz(X,Y,NXAux,YAux,T,XResp).



%% decrementa(X,Y,MatrizAtualizada) :-  matrizBase(Matriz), reduz(X,Y,0,0,Matriz, MatrizAtualizada).
%% reduz(_, _, _, _, [], _) :- !.
%% %% reduz(X,Y, AuxX, AuxY, [H|T], [NH|T]) :- X @>= AuxX, Y @>= AuxY, NH is H-1.
%% reduz(X,Y, AuxX, AuxY, [H|T], [_|T]) :- X == AuxX, Y == AuxY, N is H-1, finaliza(X,Y, AuxX, AuxY,T,[N|T]).
%% reduz(X,Y, AuxX, AuxY, [H|T], [H|T]) :- X == AuxX, NAuxY is AuxY +1, reduz(X,Y, AuxX, NAuxY, H, H).
%% reduz(X,Y, AuxX, AuxY, [H|T], [H|T]) :- NAuxX is AuxX +1, reduz(X,Y, NAuxX,AuxY, T, T).
%% finaliza(_,_,_,_,[H|T],[H|T]) :- finaliza(_,_,_,_,T,T).

%%Matriz usada
matrizBase([[1,2,3,4],[3,4,5,6]]).