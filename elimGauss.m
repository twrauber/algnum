%%
%% Eliminação de Gauss com resultados didáticos (pivô, multiplicadores
%% A e b) após eliminação dos elementos de cada coluna
%%
%% Input: Matriz A de coeficientes, b vetor de constantes
%% Output: Matriz A triangular superior, b vetor correspondente
%%
function [Atil, btil] = elimGauss( A, b )
	disp('--- E L I M I N A C A O  D E  G A U S S  S E M  P I V O T E A M E N T O  P A R C I A L ---')

	accuracy = 1e-8;
	maxiter = 10000;
	maxcase = 3;		% casas decimais
	totalspace = 10;	% espaço total do elemento na matriz

	% Verificação das dimensões da matriz e do vetor
	%row = size(A,1); col = size(A,2); rowb = size(b,1);
    	[row,col] = size(A); rowb = length(b);
	if row ~= col || row ~= rowb
			disp('Erro de dimensao de matriz e/ou vetor'); wait();
			return;
	end
	n = row;

	showMatDecAndFrac( A, 'A =', accuracy, maxiter, maxcase, totalspace );
	showMatDecAndFrac( b, 'b =', accuracy, maxiter, maxcase, totalspace );

	for k = 1:n-1
		pivo = A(k,k);
		if pivo == 0.0
			disp('Pivo igual a zero, nao permitido'); wait();
			return;
		end
		fprintf('Eliminando abaixo diagonal na coluna %d, pivo em (%d,%d)=', k, k, k );
		printdecandfrac( pivo, true );

		for i = k+1:n
			m = A(i,k) / pivo;
			fprintf('m(%d,%d)=', i, k); printdecandfrac(m,false);fprintf('  ');
			A(i,k) = 0.0;
			for j=k+1:n
				A(i,j) = A(i,j) - m * A(k,j);
			end
			b(i) = b(i) - m * b(k);
		end
		fprintf('\n'); % nova linha
		showMatDecAndFrac( A, 'A =', accuracy, maxiter, maxcase, totalspace );
		showMatDecAndFrac( b, 'b =', accuracy, maxiter, maxcase, totalspace );
	end
	Atil = A; btil = b;
end


