inicia() :- matrizBase(X), imprimeMatriz(X).

%% Imprime a matriz atual do jogo
imprimeMatriz([]) :- !.
imprimeMatriz([H|T]) :- imprimeLista(H), nl, imprimeMatriz(T).

%% Imprime uam lista de elementos
imprimeLista([]):- !.
imprimeLista([H|T]) :-
  write(H), 
  write(" "),
  imprimeLista(T).




	



matrizBase([[1,2,9],[3,4,2],[1,2,3]]).