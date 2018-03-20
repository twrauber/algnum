%%
%% Cálculo do raio espectral de uma matriz C e teste lógico de convergência
%% para um algoritmo iterative de solução de um sistema linear
%% (Gauss-Jacobi, Gauss-Seidel)
%%
%% Input: Matriz C
%% Output: raio espectral e valor lógico se há convergência
%% O raio espectral é o maior autovalor em módulo da matriz C
%%
function [r, converge] = raioEspectral( C )
	r = max(abs(eig(C)));
	converge = r < 1;
end


