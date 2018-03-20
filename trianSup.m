%%
%% Solução de um sistema linear triangular superior por
%% substituições retroativas
%%
%% Input: Matriz A triangular superior de coeficientes, b vetor de constantes
%% Output: vetor de solução
%%
function x = trianSup( A, b )
	disp('--- S O L U C A O  D E  S I S T E M A  T R I A N G U L A R  S U P E R I O R ---')
	% Verificação das dimensões da matriz e do vetor
	%row = size(A,1); col = size(A,2); rowb = size(b,1);
	[row,col] = size(A); rowb = length(b);
	if row ~= col || row ~= rowb
			disp('Erro de dimensao de matriz e/ou vetor'); wait();
			return;
	end
	n = row;
	% Verificação da triangularidade superior de A
	for k = 2:n
		for i = 1:k-1
			if A(k,i) ~= 0.0
				disp('Matriz nao triangular superior'); wait();
				return;
			end
		end
	end

	x = zeros(n,1);	% valor inicial da solução
	x(n) = b(n) / A(n,n);				fprintf('x(%d)=b(%d)/A(%d,%d) = %.3f/%.3f = ', n, n, n, n, b(n), A(n,n) );
							printdecandfrac( x(n), true );
	for i = 1:n-1
		k = n-i; % for k = n-1:1
		soma = b(k);				fprintf('x(%d)=[ b(%d) {%.3f}', k, k, b(k) );
		for j = k+1:n
			Ax = A(k,j) * x(j);
			soma = soma - Ax;		fprintf(' - A(%d,%d)*x(%d) {%.3f*%.3f=%.3f}', k, j, j, A(k,j),x(j), Ax );
		end
		x(k) = soma / A(k,k);			fprintf(' ] / A(%d,%d) {/%.3f} = ', k, k, A(k,k) );
							printdecandfrac( x(k), true );
	end
end
