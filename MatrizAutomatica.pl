imprimeMatriz(_, 0, _):- !.

imprimeMatriz(A, B, C):-
    write(A), write(" "),
    M is A mod C,
    pulaLinha(M),
    Proximo is A + 1,
    MAX is B - 1,
    imprimeMatriz(Proximo, MAX, C).

pulaLinha(0):- nl.
pulaLinha(_).

matriz(N):-
    matriz(N,N).

matriz(M,N):-
    MAX is M * N,
    imprimeMatriz(1, MAX, N).