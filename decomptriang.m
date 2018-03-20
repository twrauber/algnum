%%
%% Decomposi��o aditiva de uma matriz quadratica em parte
%% inferior triangular com diagonal zero L
%% superior triangular com diagonal zero U e diagonal D
%%
%% Input: Matriz A
%% Output: Matrizes de decomposi��o L, D, U
%%
function [L,D,U] = decomptriang ( A )
	row = size(A,1);
	col = size(A,2);
	if row ~= col exit;
	end
	L = zeros(row,col); D = L; U = L;	% Matrices vazias
	for i = 1:row
		for j = 1:col
			if i > j
				L(i,j) = A(i,j);
			elseif i < j
				U(i,j) = A(i,j);
			else
				D(i,j) = A(i,j);
			end
		end
	end
end



