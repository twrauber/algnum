%%
%% Cálculo do número de condição por definição e função do sistema
%%
%% Input: Matriz A
%% Output: comparação informativa
%%
function [] = testeNumCond( A )

numcondpordef = cond(A);

normA = max(sqrt(abs(eig(A'*A))));
normInvA = max(sqrt(abs(eig(inv(A)'*inv(A)))));

numcond = normA * normInvA;



resid = numcondpordef - numcond;


printf('Numero de condicao por definicao = %f  Por norma = %f  Dif=%f\n',...
	numcondpordef, numcond, resid );

end