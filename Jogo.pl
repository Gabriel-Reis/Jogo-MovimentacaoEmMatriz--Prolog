play(X,Y,Matriz,Caminhos):-bagof(Caminho,inicia(X,Y,Matriz,Caminho),Caminhos).
inicia(X,Y,Matriz,Caminho) :- jogar(Matriz,X,Y,Caminho), escreveArq(Caminho).

%% Imprime a matriz atual do jogo
imprimeMatriz([]).
imprimeMatriz([H|T]) :- imprimeLista(H),nl, imprimeMatriz(T).
%% Imprime uma lista de elementos
imprimeLista([]).
imprimeLista([H|T]) :- write(H),  write(", "), imprimeLista(T).
%% Escreve no arquivo
escreveArq([]).
escreveArq(Rota) :- open('caminho.txt', write, ID), writeq(ID,Rota), write(ID,'\n'), close(ID).

%% Recupera elemento da lista
recuperaElemento(X, Y, Elemento,Matriz) :- achaElemento(X,0,Matriz,ListaX), achaElemento(Y,0,ListaX,Elemento).
%% Acha um elemento.	
achaElemento(_,_,[],_) :- false.
achaElemento(Elemento,Aux,[H|_],H) :- Elemento == Aux.
achaElemento(Elemento,Aux,[_|HT],R) :- Aux1 is Aux + 1, achaElemento(Elemento,Aux1,HT,R).

elementosVizinhos(X,Y,[S,I,D,E],Matriz) :- elementoSuperior(X,Y,S,Matriz), elementoInferior(X,Y,I,Matriz), elementoDireita(X,Y,D,Matriz), elementoEsquerda(X,Y,E,Matriz).
%%Descobre vizinhos de (X,Y)
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
	verificaFim([],X) :- X is 0.
	verificaFim([H|T],X) :- verificaFimColuna(H,X1), verificaFim(T,X2), X is X1 + X2.
	verificaFimColuna([],X) :- X is 0, !.
	verificaFimColuna([H|T],R) :- H == -1, verificaFimColuna(T, R).
	verificaFimColuna([H|T],X) :- H == 0, verificaFimColuna(T, R), X is R+1.

impossivelJogar(Matriz, X,Y) :- elementosVizinhos(X,Y,Resp,Matriz), verifica(Resp).
	verifica([]).
	verifica([H|T]) :- H < 0, verifica(T).

%%Situacoes restantes
jogar(Matriz, _,_, []) :- fimDeJogo(Matriz).
jogar(Matriz, X,Y, _) :- impossivelJogar(Matriz, X,Y).
jogar(Matriz, X,Y,["S"|Rota]) :- elementoSuperior(X,Y,Z,Matriz),Z > -1,decrementa(X,Y,Matriz,NMatriz),
																						NX is X-1,jogar(NMatriz, NX, Y,Rota).
jogar(Matriz, X,Y,["I"|Rota]) :- elementoInferior(X,Y,Z,Matriz),Z > -1,decrementa(X,Y,Matriz,NMatriz),
																						NX is X+1,jogar(NMatriz, NX, Y,Rota).
jogar(Matriz, X,Y,["E"|Rota]) :- elementoEsquerda(X,Y,Z,Matriz),Z > -1,decrementa(X,Y,Matriz,NMatriz),
																						NY is Y-1,jogar(NMatriz, X, NY,Rota).
jogar(Matriz, X,Y,["D"|Rota]) :- elementoDireita(X,Y,Z,Matriz) ,Z > -1,decrementa(X,Y,Matriz,NMatriz),
																						NY is Y+1,jogar(NMatriz, X, NY,Rota).

%%Muda numero em (X,Y)
decrementa(X,Y,Matriz, MatrizAtualizada) :- reduzX(X,Y,0,0,Matriz,MatrizAtualizada).
	reduzX(_,_,    _,    _,    [],         []) .
	reduzX(X,Y,    X, AuxY, [H|T], [LAlt|Mat]) :- NX is X+1,reduzY(X,Y, AuxY,  AuxY, H, LAlt), reduzX(X,Y,NX, AuxY, T, Mat).
	reduzX(X,Y, AuxX, AuxY, [H|T], [   H|Mat]) :- NAuxX is AuxX+1, reduzX(X,Y,NAuxX, AuxY, T,  Mat).
		reduzY(_,_, _,    _,    [],       []) .
		reduzY(_,Y, _,    Y, [H|T], [NH|MAT]) :- NH is H-1, NY is Y+1, 	 reduzY(_,Y, _, NY, T, MAT).
		reduzY(_,Y, _, AuxY, [H|T], [ H|MAT]) :- 		   NY is AuxY+1, reduzY(_,Y, _, NY, T, MAT).

%%Matriz usada
matrizBase([[0,0],[0,0]]).