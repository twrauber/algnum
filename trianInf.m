%%
%% Solução de um sistema linear triangular inferior por
%% substituições progressivas
%%
%% Input: Matriz A triangular inferior de coeficientes, b vetor de constantes
%% Output: vetor de solução
%%
function y = trianInf( A, b )
	disp('--- S O L U C A O  D E  S I S T E M A  T R I A N G U L A R  I N F E R I O R ---')
	% Verificação das dimensões da matriz e do vetor
	row = size(A,1); col = size(A,2); rowb = size(b,1);
	if row ~= col || row ~= rowb
			disp('Erro de dimensao de matriz e/ou vetor'); wait();
			return;
	end
	n = row;
	% Verificação da triangularidade superior de A
	for k = 2:n
		for i = 1:k-1
            		if A(i,k) ~= 0.0
				disp('Matriz nao triangular inferior'); wait();
				return;
            		end
		end
	end

	y = zeros(n,1);	% valor inicial da solução
	y(1) = b(1) / A(1,1);				fprintf('y(1)=b(1)/A(1,1) = %.3f/%.3f = ', b(1), A(1,1) );
							printdecandfrac( y(1), true );
	for i = 2:n
		soma = b(i);				fprintf('y(%d)=[ b(%d) {%.3f}', i, i, b(i) );
		for j = 1:i-1
			Ay = A(i,j) * y(j);
			soma = soma - Ay;	fprintf(' - A(%d,%d)*y(%d) {%.3f*%.3f=%.3f}', i, j, j, A(i,j), y(j), Ay );
		end
		y(i) = soma / A(i,i);			fprintf(' ] / A(%d,%d) {/%.3f} = ', i, i, A(i,i) );
							printdecandfrac( y(i), true );
	end
end



