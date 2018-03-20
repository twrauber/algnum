%%
%% Resolu��o de um sistema linear, usando m�todo iterativo de Sobre-Relaxa��o Sucessiva (SOR)
%% Ref.: Algoritmos Num�ricos - Frederico Ferreira Campos, LTC, 2� Edi��o, 2007, p�gina 102
%%
%% Input: Matriz A, constantes b, solu��o inicial, par�metro omega,
%%			limiar de semelhan�a eps, n�mero m�ximo de itera��es maxiter
%% Output: solu��o x
%%
function x = SOR ( A, b, x0, omega, eps, maxiter )
	row = size(A,1); %col = row;
	[L, D, U] = decomptriang( A );
	B = inv(D + omega * L);
	C = B * ((1-omega)*D - omega*U);
	g = omega * B * b;


	% Itera��o
	x = x0;			% valor inicial da solu��o
	d = eps+1;		% dist�ncia inicial
	k = 0;
	while k < maxiter && d > eps
		xold = x;
		x = C * x + g;
		d = distrel(x,xold);
		k = k + 1;
		fprintf('iter=%4d  dist= %12.10f  x=', k, d);
		for i = 1:row
			fprintf('%12.5f', x(i));
		end
		fprintf('\n');
	end
end

