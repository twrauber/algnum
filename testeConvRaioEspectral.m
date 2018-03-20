%%
%% Teste de convergência pelo critério do raio espectral da matriz de iteração
%% Ref.: Algoritmos Numéricos - Frederico Ferreira Campos,
%% LTC, 2a Edição, 2007, página 89
%% Dado o sistema Ax=b, transformando-o na forma iterativa x(k+1) = C x(k) + g,
%% o sistema converge para qualquer valor inicial x(0) se, e somente se,
%% rho(C) < 1, sendo rho(C) o raio espectral (maior autovalor em módulo) da
%% matriz de iteração C
%% Para os métodos de Gauss-Jacobi e Gauss-Seidel, C e g são diferentes
%%
%% Input: Matriz A, constantes b
%% Output: reposta lógica de convergência
%%
function [convergeGJ, convergeGS] = testeConvRaioEspectral( A )

	accuracy = 1e-8;
	maxiter = 10000;
	maxcase = 4;		% casas decimais
	totalspace = 10;	% espaço total do elemento na matriz

	showMatDecAndFrac( A, 'A =', accuracy, maxiter, maxcase, totalspace );

	[L, D, U] = decomptriang( A );
	row = size(A,1);
	% Gauss-Jacobi
	disp('--- Teste de convergencia Gauss-Jacobi ---');
	D1 = zeros(row,row);
	for i = 1:row
		D1(i,i) = 1/D(i,i);
	end
	C = -D1 * (L+U);
	showMatDecAndFrac( C, 'Gauss-Jacobi: C =', accuracy, maxiter, maxcase, totalspace );

	eigvals = eig(C);
	eigvalsAbs = abs(eigvals);
	maxeigvalabs =  max(eigvalsAbs);
	convergeGJ = maxeigvalabs < 1;
	fprintf('Auto-valores = \n'); eigvals
	fprintf('Maior auto-valor em modulo de C = %f  Convergencia=%s\n', maxeigvalabs, boolStr(convergeGJ) ); 

	showMatDecAndFrac( eigvalsAbs, 'Auto-valores em modulo =', accuracy, maxiter, maxcase, totalspace );

	% Gauss-Seidel
	disp('--- Teste de convergencia Gauss-Seidel ---');
	%D+L
	invDL = inv(D+L);
	C = -invDL * U;
	showMatDecAndFrac( C, 'Gauss-Seidel: C =', accuracy, maxiter, maxcase, totalspace );

	eigvals = eig(C);
	eigvalsAbs = abs(eigvals);
	maxeigvalabs =  max(eigvalsAbs);
	convergeGS = max(eigvalsAbs) < 1;

	fprintf('Auto-valores = \n'); eigvals
	fprintf('Maior auto-valor em modulo de C = %f  Convergencia=%s\n', maxeigvalabs, boolStr(convergeGS) ); 
	showMatDecAndFrac( eigvalsAbs, 'Auto-valores em modulo =', accuracy, maxiter, maxcase, totalspace );


end
