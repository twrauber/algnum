%%
%% Teste de convergência pelo Critério das Linhas
%% válido para os métodos de Gauss-Jacobi e Gauss-Seidel
%% Ref.:
%% Cálculo Numérico - Aspectos Teóricos Computacionais - Márcia A. G. Ruggiero
%% e Vera Lúcia da Rocha Lopes - Ed. McGraw-Hill - 2a Edição, 1997,
%% ISBN 85-346-0204-2, p. 160
%% 
%% alpha_k := (somatório j=1, j~=k até n [ |a_kj| ] ) / | a_kk |
%% alpha_k < 1 para k = 1,..,n
%% então o sistema converge
%%
%% Input: Matriz A
%% Output: reposta lógica de convergência pelo Critério das Linhas
%% 'O valor absoluto do termo diagonal na linha i é maior do que a soma dos
%%   valores absolutos de todos os outros termos na mesma linha'.
%%
function convergeCritLinhas = testeConvCritLin( A )

	n = size(A,1);

	showMatDecAndFrac( A, 'A =', 1e-8, 10000, 5, 10 );

	diverge = false; i = 1;
	while i <= n && ~diverge
		somalin = 0.0;
		for j = 1:n
			if j ~= i
				somalin = somalin + abs(A(i,j));
			end
		end
		alpha = somalin / abs(A(i,i));
		diverge = alpha >= 1.0;
		fprintf('A(%d,%d)=', i, i); printdecandfrac(A(i,i),false);fprintf('  ');
		fprintf('Soma do modulo dos elementos da linha %d, exceto A(%d,%d)=',i,i,i); printdecandfrac(somalin,false);fprintf('  ');
		fprintf('alpha[%d]=', i); printdecandfrac(alpha,false);fprintf('\n');
		i = i+1;
	end
	convergeCritLinhas = ~diverge;
	fprintf('Convergencia=%s\n',boolStr(convergeCritLinhas));
end



