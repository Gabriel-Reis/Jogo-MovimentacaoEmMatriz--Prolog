%% Gabriel Augusto Requena dos Reis 16.2.8105
%% Bruno Cesar Cota Conceição 13.2.8514
play(X,Y,Matriz,Caminhos):-bagof(Caminho,jogar(X,Y,Matriz,Caminho),Caminhos),escreveArq(Caminhos),!.

jogar(X,Y,Matriz, []) :- fimDeJogo(Matriz), recuperaElemento(X,Y,Matriz,0).
jogar(X,Y,Matriz, _) :- impossivelJogar(Matriz, X,Y), fail.
jogar(X,Y,Matriz,["S"|Rota]) :- elementoSuperior(X,Y,Matriz,Z),Z > -1,
					decrementa(X,Y,Matriz,NMatriz),NX is X-1,jogar(NX, Y,NMatriz,Rota).
jogar(X,Y,Matriz,["I"|Rota]) :- elementoInferior(X,Y,Matriz,Z),Z > -1, 
					decrementa(X,Y,Matriz,NMatriz),NX is X+1,jogar(NX, Y,NMatriz,Rota).
jogar(X,Y,Matriz,["E"|Rota]) :- elementoEsquerda(X,Y,Matriz,Z),Z > -1,
					decrementa(X,Y,Matriz,NMatriz),NY is Y-1,jogar(X, NY,NMatriz,Rota).
jogar(X,Y,Matriz,["D"|Rota]) :- elementoDireita(X,Y,Matriz,Z) ,Z > -1,
					decrementa(X,Y,Matriz,NMatriz),NY is Y+1,jogar(X, NY,NMatriz,Rota).

fimDeJogo(Matriz) :- verificaFim(Matriz,1).

verificaFim([],0).
verificaFim([H|T],X) :- verificaFimLinha(H,X1), verificaFim(T,X2), X is X1 + X2.

verificaFimLinha([],0).
verificaFimLinha([-1|T],R) :- verificaFimLinha(T, R).
verificaFimLinha([0|T],R) :- verificaFimLinha(T, X), R is X+1.

recuperaElemento(X, Y,Matriz, Elemento):-achaElemento(X,0,Matriz,ListaX), achaElemento(Y,0,ListaX,Elemento).

achaElemento(_,_,[],_) :- false.
achaElemento(Elemento,Elemento,[R|_],R).
achaElemento(Elemento,Aux,[_|HT],R) :- Aux1 is Aux + 1, achaElemento(Elemento,Aux1,HT,R).

impossivelJogar(Matriz, X,Y) :- elementosVizinhos(X,Y,Matriz,Resp), verificaLista(Resp).

verificaLista([]).
verificaLista([H|T]) :- H < 0, verificaLista(T).

elementosVizinhos(X,Y,Matriz,[S,I,D,E]) :- elementoSuperior(X,Y,Matriz,S),
										   elementoInferior(X,Y,Matriz,I), 
										   elementoDireita(X,Y,Matriz,D),
										   elementoEsquerda(X,Y,Matriz,E).

elementoSuperior(X,Y,Matriz,Elemento) :- N is X-1, recuperaElemento(N,Y,Matriz,Elemento).
elementoSuperior(_,_,_,-5).
elementoInferior(X,Y,Matriz,Elemento) :- N is X+1, recuperaElemento(N,Y,Matriz,Elemento).
elementoInferior(_,_,_,-5).
elementoDireita(X,Y,Matriz,Elemento) :- N is Y+1, recuperaElemento(X,N,Matriz,Elemento).
elementoDireita(_,_,_,-5).
elementoEsquerda(X,Y,Matriz,Elemento) :- N is Y-1, recuperaElemento(X,N,Matriz,Elemento).
elementoEsquerda(_,_,_,-5).

decrementa(X,Y,Matriz, MatrizAtualizada) :- reduzX(X,Y,0,0,Matriz,MatrizAtualizada).

reduzX(X,Y, X, AuxY, [H|T], [LAlt|T]) :- reduzY(Y, AuxY, H, LAlt).
reduzX(X,Y, AuxX, AuxY, [H|T], [H|Mat]) :- NAuxX is AuxX+1, reduzX(X,Y,NAuxX, AuxY, T,  Mat).

reduzY(Y, Y, [H|T], [NH|T]) :- NH is H-1.
reduzY(Y, AuxY, [H|T], [H|MAT]) :- NY is AuxY+1, reduzY(Y,NY, T, MAT).

escreveArq([]).
escreveArq(Rota) :- open('caminhos.txt', write, ID), escreveRota(Rota,ID), close(ID).

escreveRota([H|[]],ID) :- write(ID, H).
escreveRota([H|T],ID) :- write(ID, H), write(ID,'\n'), escreveRota(T,ID).