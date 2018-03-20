%%
%% Resolução de um sistema linear, usando método iterativo de Jacobi
%%
%% Input: Matriz A, constantes b, solução inicial,
%%			limiar de semelhança eps, número máximo de iterações maxiter
%% Output: solução x
%%
function x = GaussJacobiMatricial ( A, b, x0, eps, maxiter )
	fprintf('\n--- G A U S S - J A C O B I ---\n');

	accuracy = 1e-8;
	maxiterd2f = 100;
	maxcase = 3;		% casas decimais
	totalspace = 10;	% espaço total do elemento na matriz

	fprintf('Eps = %e --- Numero maximo de iteracoes = %d\n', eps, maxiter );
	showMatDecAndFrac( A, 'A =', accuracy, maxiterd2f, maxcase, totalspace );
	showMatDecAndFrac( b, 'b =', accuracy, maxiterd2f, maxcase, totalspace );
	showMatDecAndFrac( x0, 'x0 =', accuracy, maxiterd2f, maxcase, totalspace );
	showMatDecAndFrac( A\b, 'Solucao x direto =', accuracy, maxiterd2f, maxcase, totalspace );

	[L, D, U] = decomptriang( A );
	row = size(A,1);
	D1 = zeros(row,row);
	for i = 1:row
		D1(i,i) = 1/D(i,i);
	end
	
	fprintf('A=L+D+U  ;  C = -D^-1 [L+U]   ;   g = D^-1 * b\n');
	C = -D1 * (L+U);
	g = D1 * b;

	showMatDecAndFrac( C, 'C =', accuracy, maxiterd2f, maxcase, totalspace );
	showMatDecAndFrac( g, 'g =', accuracy, maxiterd2f, maxcase, totalspace );

	[r, converge] = raioEspectral( C );
	fprintf('Raio espectral= %12.10f ', r);
	if( converge )
	  fprintf('Ha convergencia\n');
	else
	  fprintf('Ha divergencia\n');
	end
	
	% Iteração
	x = x0;			% valor inicial da solução
	d = eps+1;		% distância inicial
	k = 0;
	while k < maxiter && d > eps
		xold = x;
		x = C * x + g;
		d = distrel(x,xold); dfracstr = dec2fracstr( d, 12, accuracy, maxiterd2f );
		
		k = k + 1;
		fprintf('G-J matricial iter=%4d maxiter=%4d  dist= %12.10f=%s  mindist= %e  x=(',...
				 k, maxiter, d, dfracstr , eps);
		for i = 1:row
			fprintf('%12.7f', x(i));
		end
		fprintf(') = (');
		for i = 1:row
			fprintf('%s ', dec2fracstr( x(i), 12, accuracy, maxiterd2f ) );
		end
		fprintf(')\n');
	end
	fprintf('Razao de parada: ');
	if k >= maxiter , fprintf('Numero maximo de iteracoes %d atingido\n', k); end;
	if d <= eps , fprintf('Distancia %e menor que ou igual ao limite %e apos %d iteracoes\n', d, eps, k ); end;
end


