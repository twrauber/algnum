%%
%% Decomposição LU com pivoteamento parcial
%%
%% Input: Matriz A de coeficientes, b vetor de constantes
%% Output: Matriz LU compartilhada superior, 
%%         b permutado Pb
%%         solução y da equação Ly = Pb
%%         solução x da equação Ux = y
%%
function [LU, Pb, y, x] = luPivPar( A, b )
	disp('--- D E C O M P O S I C A O  L U  C O M  P I V O T E A M E N T O ---')

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

	P = eye( n, n );	% Matriz de permutação

	for k = 1:n-1	% Para todas as colunas
		% determinar linha do pivô na coluna k
		maxmodlin = k;
		for i = k+1:n
			if abs(A(i,k)) > abs(A(maxmodlin,k)) maxmodlin = i; end
		end
		if maxmodlin ~= k
			fprintf('Na coluna %d permutando linhas %d e %d, pivo em (%d,%d)=%.4f\n', k, k, maxmodlin, maxmodlin, k, A(maxmodlin,k) );
			if k > 1
				fprintf('Atencao: tambem permutando multiplicadores armazenados nessas linhas\n' );
			end
			[A(k,:),A(maxmodlin,:)] = swap(A(k,:),A(maxmodlin,:));
			A
			[P(k,:),P(maxmodlin,:)] = swap(P(k,:),P(maxmodlin,:));
			P
			%[b(k),b(maxmodlin)] = swap(b(k),b(maxmodlin));
			%b
		end
		Pb = P * b;
		showMatDecAndFrac( Pb, 'Pb =', accuracy, maxiter, maxcase, totalspace )
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
		showMatDecAndFrac( A, 'A =', accuracy, maxiter, maxcase, totalspace )
		%wait();
	end
	LU = A; % Pb = b;
	L = tril(LU); for i = 1:n L(i,i) = 1; end;
	U = triu(LU);
	fprintf('Decomposicao finalizada\n' );
	showMatDecAndFrac( L, 'L =', accuracy, maxiter, maxcase, totalspace )
	showMatDecAndFrac( U, 'U =', accuracy, maxiter, maxcase, totalspace )
	P
	showMatDecAndFrac( Pb, 'Pb =', accuracy, maxiter, maxcase, totalspace )
	fprintf('Solucionando Ly = Pb por Substituicao Progressiva...\n');
	y = trianInf( L, Pb );
	showMatDecAndFrac( y, 'y =', accuracy, maxiter, maxcase, totalspace )
	fprintf('Solucionando Ux = y por Substituicao Retroativa...\n');
	x = trianSup( U, y );
	showMatDecAndFrac( x, 'x =', accuracy, maxiter, maxcase, totalspace )
end


