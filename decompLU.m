%%
%% Decomposição LU sem estratégia de pivoteamento
%%
%% Input: Matriz A de coeficientes, b vetor de constantes
%% Output: Matriz LU compartilhada superior
%%         solução y da equação Ly = b
%%         solução x da equação Ux = y
%%
function [LU, y, x] = decompLU( A, b )
	disp('--- D E C O M P O S I C A O  L U  S E M  P I V O T E A M E N T O ---')

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


	for k = 1:n-1	% Para todas as colunas
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
			A(i,k) = m;
			for j=k+1:n
				A(i,j) = A(i,j) - m * A(k,j);
			end
		end
		fprintf('\n'); % nova linha
		%A, showMatFrac( A, 'A =' );
		showMatDecAndFrac( A, 'A com multiplicadores abaixo da diagonal =', accuracy, maxiter, maxcase, totalspace )
		%wait();
	end
	LU = A;
	L = tril(LU); for i = 1:n L(i,i) = 1; end;
	U = triu(LU);

	%L, showMatFrac( L, 'L =' );	U, showMatFrac( U, 'U =' );

	showMatDecAndFrac( L, 'L =', accuracy, maxiter, maxcase, totalspace )
	showMatDecAndFrac( U, 'U =', accuracy, maxiter, maxcase, totalspace )

	fprintf('Solucionando Ly = b ...\n');
	y = trianInf( L, b );
	showMatDecAndFrac( y, 'y =', accuracy, maxiter, maxcase, totalspace )
	fprintf('Solucionando Ux = y ...\n');
	x = trianSup( U, y );
	showMatDecAndFrac( x, 'x =', accuracy, maxiter, maxcase, totalspace )
end



