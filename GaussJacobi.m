%%
%% Resolução de um sistema linear, usando método iterativo de Jacobi
%%
%% Input: Matriz A, constantes b, solução inicial,
%%			limiar de semelhança eps, número máximo de iterações maxiter
%% Output: solução x
%%
function x = GaussJacobi ( A, b, x0, eps, maxiter )
	fprintf('\n--- G A U S S - J A C O B I ---\n');
	row = size(A,1); col = row;

	% Iteração
	x = x0;			% valor inicial da solução
	d = eps+1;		% distância inicial
	k = 0;
	while k < maxiter && d > eps
		xold = x;
		for i = 1:row
			fprintf('x_%d^(%d) = 1/A(%d,%d){1/%.3f}  [ b(%d){%.3f} ', i, k+1, i, i, A(i,i), i, b(i) );
			soma = b(i);
			for j = 1:col
				if j~=i
					fprintf(' - A(%d,%d)*x_%d^(%d){-%.3f*%.3f}',i,j,j,k,A(i,j),x(j) );
					soma = soma - A(i,j)*xold(j);
				end
			end
			x(i) = soma / A(i,i);
			fprintf(' ]  = {%.3f} = x_%d^(%d)\n',x(i),i,k+1);
		end
		d = distrel(x,xold);
		k = k + 1;
		fprintf('G-J explicito iter=%4d  distrel= %12.10f  x=', k, d);
		for i = 1:row
			fprintf('%12.7f', x(i));
		end
		fprintf('\n');
	end
	fprintf('Razao de parada: ');
	if k >= maxiter fprintf('Numero maximo %d de iteracoes atingidos\n',maxiter); end
	if d <= eps fprintf('Distancia relativa abaixo do limiar %.e\n',eps); end
end
