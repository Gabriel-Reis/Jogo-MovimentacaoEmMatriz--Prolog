inicia(X,Y) :- matrizBase(Matriz), imprimeMatriz(Matriz),lengthList(Matriz,T),  jogar(Matriz,X,Y,T).

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
recuperaElemento(X, Y, Elemento,Matriz) :- achaX(X,0,Matriz,ListaX), achaY(Y,0,ListaX,Elemento).
	achaX(_, _, [], _) :- false.
	achaX(X, Aux, [Resp|_], Resp) :- X == Aux.
	achaX(X, Aux, [_|T], R) :- Aux1 is Aux + 1, achaX(X,Aux1,T,R).
	
	achaY(_,_,[],_) :- false.
	achaY(Y,Aux,[H|_],H) :- Y == Aux.
	achaY(Y,Aux,[_|HT],R) :- Aux1 is Aux + 1, achaY(Y,Aux1,HT,R).

%%Descobre vizinhos de (X,Y)
elementosVizinhos(X,Y,[S,I,D,E],Matriz) :- elementoSuperior(X,Y,S,Matriz), elementoInferior(X,Y,I,Matriz),
										   elementoDireita(X,Y,D,Matriz), elementoEsquerda(X,Y,E,Matriz).
	elementoSuperior(X,Y,Elemento,Matriz) :- N is X-1, recuperaElemento(N,Y,Elemento, Matriz).
	elementoSuperior(_,_,-5,_).
	elementoInferior(X,Y,Elemento,Matriz) :- N is X+1, recuperaElemento(N,Y,Elemento,Matriz).
	elementoInferior(_,_,-5,_).
	elementoDireita(X,Y,Elemento,Matriz) :- N is Y+1, recuperaElemento(X,N,Elemento,Matriz).
	elementoDireita(_,_,-5,_).
	elementoEsquerda(X,Y,Elemento,Matriz) :- N is Y-1, recuperaElemento(X,N,Elemento,Matriz).
	elementoEsquerda(_,_,-5,_).

%%Verifica se jogo chegou ao fim
fimDeJogo(Matriz) :- verificaFim(Matriz,X), X == 1.
	verificaFim([],X) :- X is 0, !.
	verificaFim([H|T],X) :- verificaFimColuna(H,X1), verificaFim(T,X2), X is X1 + X2.
	verificaFimColuna([],X) :- X is 0, !.
	verificaFimColuna([H|T],R) :- H == -1, verificaFimColuna(T, R).
	verificaFimColuna([H|T],X) :- H == 0, verificaFimColuna(T, R), X is R+1.

%%Tenta achar solução
%Situacoes de fim de jogo
jogar(Matriz, _,_,_) :- fimDeJogo(Matriz), !.
jogar(Matriz, X,Y,_) :- elementosVizinhos(X,Y,[-1,-1,-1,-1],Matriz), false. %4 OPCOES
jogar(Matriz, 0,0,_) :- elementosVizinhos(0,0,[-5,-1,-1,-5],Matriz), false.	%SUP ESQ.
jogar(Matriz, 0,T,T) :- elementosVizinhos(0,T,[-5,-1,-5,-1],Matriz), false.	%SUP DIR.
jogar(Matriz, T,0,T) :- elementosVizinhos(T,0,[-1,-5,-1,-5],Matriz), false.	%INF ESQ.
jogar(Matriz, T,T,T) :- elementosVizinhos(T,T,[-1,-5,-5,-1],Matriz), false.	%INF DIR.
%Situacoes do jogador nas cantos
jogar(Matriz, 0,0,T) :- decrementa(0,0,Matriz,NMAtriz),			 jogar(NMAtriz,  1,  0,T).	%SUP ESQ.
jogar(Matriz, 0,0,T) :- decrementa(0,0,Matriz,NMAtriz),			 jogar(NMAtriz,  0,  1,T).	%SUP ESQ.
jogar(Matriz, 0,T,T) :- decrementa(0,T,Matriz,NMAtriz),			 jogar(NMAtriz,  1,  T,T).	%SUP DIR.
jogar(Matriz, 0,T,T) :- decrementa(0,T,Matriz,NMAtriz),NY is T-1,jogar(NMAtriz,  T, NY,T).	%SUP DIR.
jogar(Matriz, T,0,T) :- decrementa(T,0,Matriz,NMAtriz),NX is T-1,jogar(NMAtriz, NX,  0,T).	%INF ESQ.
jogar(Matriz, T,0,T) :- decrementa(T,0,Matriz,NMAtriz),			 jogar(NMAtriz,  T,  1,T).	%INF ESQ.
jogar(Matriz, T,T,T) :- decrementa(T,T,Matriz,NMAtriz),NX is T-1,jogar(NMAtriz, NX,  T,T).	%INF DIR.
jogar(Matriz, T,T,T) :- decrementa(T,T,Matriz,NMAtriz),NY is T-1,jogar(NMAtriz,  T, NY,T).	%INF DIR.
%Situacoes do jogador nas laterais
jogar(Matriz, X,0,T) :- decrementa(X,0,Matriz,NMAtriz),NX is X+1,jogar(NMAtriz, NX,  0,T).	%LAT ESQ.
jogar(Matriz, X,0,T) :- decrementa(X,0,Matriz,NMAtriz),NX is X-1,jogar(NMAtriz, NX,  0,T).	%LAT ESQ.
jogar(Matriz, X,0,T) :- decrementa(X,0,Matriz,NMAtriz),			 jogar(NMAtriz,  X,  1,T).	%LAT ESQ.
jogar(Matriz, X,T,T) :- decrementa(X,T,Matriz,NMAtriz),NX is X+1,jogar(NMAtriz, NX,  T,T).	%LAT DIR.
jogar(Matriz, X,T,T) :- decrementa(X,T,Matriz,NMAtriz),NX is X-1,jogar(NMAtriz, NX,  T,T).	%LAT DIR.
jogar(Matriz, X,T,T) :- decrementa(X,T,Matriz,NMAtriz),NY is T-1,jogar(NMAtriz,  X, NY,T).	%LAT DIR.
jogar(Matriz, 0,Y,T) :- decrementa(0,Y,Matriz,NMAtriz),			 jogar(NMAtriz,  1,  Y,T).	%LAT SUP.
jogar(Matriz, 0,Y,T) :- decrementa(0,Y,Matriz,NMAtriz),NY is Y+1,jogar(NMAtriz,  0, NY,T).	%LAT SUP.
jogar(Matriz, 0,Y,T) :- decrementa(0,Y,Matriz,NMAtriz),NY is Y-1,jogar(NMAtriz,  0, NY,T).	%LAT SUP.
jogar(Matriz, T,Y,T) :- decrementa(T,Y,Matriz,NMAtriz),NX is T-1,jogar(NMAtriz, NX,  Y,T).	%LAT INF.
jogar(Matriz, T,Y,T) :- decrementa(T,Y,Matriz,NMAtriz),NY is Y-1,jogar(NMAtriz,  T, NY,T).	%LAT INF.
jogar(Matriz, T,Y,T) :- decrementa(T,Y,Matriz,NMAtriz),NY is Y-1,jogar(NMAtriz,  T, NY,T).	%LAT INF.
%Situacoes do jogador nas bordas
jogar(Matriz, X,Y,T) :- decrementa(X,Y,Matriz,NMAtriz),NX is X-1,jogar(NMAtriz, NX, Y,T).
jogar(Matriz, X,Y,T) :- decrementa(X,Y,Matriz,NMAtriz),NX is X+1,jogar(NMAtriz, NX, Y,T).
jogar(Matriz, X,Y,T) :- decrementa(X,Y,Matriz,NMAtriz),NY is Y-1,jogar(NMAtriz, X, NY,T).
jogar(Matriz, X,Y,T) :- decrementa(X,Y,Matriz,NMAtriz),NY is Y+1,jogar(NMAtriz, X, NY,T).

%procuraX(_, AuxX, MatrizVelha, _) :- tamanhoMatriz(MatrizVelha,Tam), write(Tam), AuxX > Tam.
%procuraX(_, _, [], []).
%procuraX(X, AuxX, [HO|TO], [HO|MatrizAtualizada]) :- NovoX is AuxX+1, procuraX(X, NovoX, TO, MatrizAtualizada).

%%Muda numero em (X,Y)
decrementa(X,Y,Matriz, MatrizAtualizada) :- reduzX(X,Y,0,0,Matriz,MatrizAtualizada).
	
	reduzX(_,_,    _,    _,    [],         []) .
	reduzX(X,Y,    X, AuxY, [H|T], [LAlt|Mat]) :- NX is X+1,reduzY(_,Y,   _,  AuxY, H, LAlt),reduzX(X,Y,NX, AuxY, T, Mat).
	reduzX(X,Y, AuxX, AuxY, [H|T], [   H|Mat]) :- NAuxX is AuxX+1, reduzX(X,Y,NAuxX, AuxY, T,  Mat).
	
	reduzY(_,_, _,    _,    [],       []) .
	reduzY(_,Y, _, AuxY, [H|T], [ H|MAT]) :- AuxY > Y,  NY is AuxY+1, reduzY(_,Y, _, NY, T, MAT).
	reduzY(_,Y, _,    Y, [H|T], [NH|MAT]) :- NH is H-1, NY is Y+1, 	 reduzY(_,Y, _, NY, T, MAT).
	reduzY(_,Y, _, AuxY, [H|T], [ H|MAT]) :- 		   NY is AuxY+1, reduzY(_,Y, _, NY, T, MAT).


lengthList([],0).
lengthList([_|R],N):- lengthList(R,N1), N is 1 + N1.

%%Matriz usada
matrizBase([[1,1],[1,1]]).