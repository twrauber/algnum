%%
%% Resolução de um sistema linear, usando método iterativo de Gauss-Seidel
%%
%% Input: Matriz A, constantes b, solução inicial,
%%			limiar de semelhança eps, número máximo de iterações maxiter
%% Output: solução x
%%
function x = GaussSeidelMatricial( A, b, x0, eps, maxiter ) % R.-L. 2a ed. p. 166
	fprintf('\n--- G A U S S - S E I D E L ---\n');

	accuracy = 1e-8;
	maxiterd2f = 10000;
	maxcase = 3;		% casas decimais
	totalspace = 10;	% espaço total do elemento na matriz

	fprintf('Eps = %e --- Numero maximo de iteracoes = %d\n', eps, maxiter );
	showMatDecAndFrac( A, 'A =', accuracy, maxiterd2f, maxcase, totalspace );
	showMatDecAndFrac( b, 'b =', accuracy, maxiterd2f, maxcase, totalspace );
	showMatDecAndFrac( x0, 'x0 =', accuracy, maxiterd2f, maxcase, totalspace );
	showMatDecAndFrac( A\b, 'Solucao x direto =', accuracy, maxiterd2f, maxcase, totalspace );

	[L, D, U] = decomptriang( A );
	row = size(A,1); col = row;

	D1 = zeros(row,row);
	for i = 1:row
		D1(i,i) = 1/D(i,i);
	end

	ID1L1D1 = inv( (eye(row) + D1 * L) ) * D1;
	fprintf('A=L+D+U  ;  C = - [I + D^-1 * L]^-1 * U   ;   g = [I + D^-1 * L]^-1 * b\n');
	C = -ID1L1D1 * U;
	g = ID1L1D1 * b;

	showMatDecAndFrac( C, 'C =', accuracy, maxiterd2f, maxcase, totalspace );
	showMatDecAndFrac( g, 'g =', accuracy, maxiterd2f, maxcase, totalspace );

	% Iteração
	x = x0;			% valor inicial da solução
	d = eps+1;		% distância inicial
	k = 0;
	while k < maxiter && d > eps
		xold = x;
		x = C * x + g; % funciona, pois x é atualizado por componentes
		d = distrel(x,xold); dfracstr = dec2fracstr( d, 12, accuracy, maxiterd2f );

		k = k + 1;
		fprintf('G-S matricial iter=%4d maxiter=%4d  dist= %12.10f=%s  mindist= %e  x=(',...
				 k, maxiter, d, dfracstr, eps);
		for i = 1:row
			fprintf('%12.7f', x(i));
		end
		fprintf(') = (');
		for i = 1:row
			fprintf('%s', dec2fracstr( x(i), 12, accuracy, maxiterd2f ) ); 
		end
		fprintf(')\n');
	end
	fprintf('Razao de parada: ');
	if k >= maxiter , fprintf('Numero maximo de iteracoes %d atingido\n', k); end;
	if d <= eps , fprintf('Distancia %e menor que ou igual ao limite %e apos %d iteracoes\n', d, eps, k ); end;
end




