%%
%% Imprimir Sistema Linear A x = b para documentação LaTeX
%%
%% Input: Matriz A de coeficientes, b vetor de constantes,
%%	nome do arquivo de saída (entre aspas), método
%% Output: Texto em arquivo de texto no formato LaTeX
%%

function printLaTeX( A, b, filename, method )
	% Verificação das dimensões da matriz e do vetor
	row = size(A,1); col = size(A,2); rowb = size(b,1);
	if row ~= col || row ~= rowb
			disp('Erro de dimensao de matriz e/ou vetor'); wait();
			return;
	end
	latex = fopen( filename, 'a+');

	fprintf( latex, '%%\nDetermine por ');
    switch ( method )
	case 'LS_METHOD_GAUSS'
		fprintf( latex, 'Eliminação de Gauss, sem Pivoteamento Parcial, ' );
	case 'LS_METHOD_GAUSS_PIV'
		fprintf( latex, 'Eliminação de Gauss, com Pivoteamento Parcial, ' );
	case 'LS_METHOD_LU'
		fprintf( latex, 'Fatoração \\emph{LU}, sem Pivoteamento Parcial, ' );
	case 'LS_METHOD_LU_PIV'
		fprintf( latex, 'Fatoração \\emph{LU}, com Pivoteamento Parcial, ' );
	otherwise
		disp('Metodo desconhecido'); wait();
		return;
    end
	fprintf( latex, '\no vetor de solução $x$, dado o sistema linear\n');
	fprintf( latex, '\\[\n\t\\begin{array}{r'); for j=1:col fprintf(latex,'rr');end
	fprintf( latex, '}\n');
	for i=1:row
		fprintf( latex, '\t\t' );
		for j=1:col
			[num, denom, success] = dec2frac( A(i,j), 1E-5, 100 ); s = signString(num);
			is_octave = (exist('OCTAVE_VERSION','builtin')>1); % Octave or Matlab
			if ~is_octave
				stdout = 1; stderr = 2;
			end;
			if ~success fprintf(stderr,'printLaTeX> Erro em dec2frac. exit\n'), return; end;
			%num
			%denom
			%s
			if j==1
				%if s == '-' fprintf( latex, '-' ); end;
				if A(i,j) ~= 0.0
					if( A(i,j) == -1 )
						fprintf( latex, '-x_{%d} & ', j );
					elseif ( A(i,j) == 1 )
						fprintf( latex, 'x_{%d} & ', j );
					elseif ( denom == 1 )
						fprintf( latex, '%dx_{%d} & ', A(i,j), j );
					else
						fprintf( latex, '\\frac{%d}{%d} x_{%d} & ', num, denom, j );
						%fprintf( latex, '%dx_{%d} & ', A(i,j), j );
					end
				else
					fprintf( latex, '        & ' );
				end
			else
				if A(i,j) ~= 0.0
					if( abs(A(i,j)) == 1 )
						fprintf( latex, '%s & x_{%d} & ', s, j );
					elseif ( denom == 1 )
						fprintf( latex, '%s & %dx_{%d} & ', s, abs(A(i,j)), j );
					else
						fprintf( latex, '%s & \\frac{%d}{%d} x_{%d} & ', s, num, denom, j );
					end
				else
					fprintf( latex, '  &        & ' );
				end
			end
		end
		[num, denom, success] = dec2frac( b(i), 1E-5, 100 ); s = signString(num);
		if ~success fprintf(stderr,'printLaTeX> Erro em dec2frac. exit\n'), return; end;
		s = '';
		if denom == 1
			fprintf( latex, ' = & %s%d', s, b(i));
		elseif denom == 2
			fprintf( latex, ' = & %s%.1f', s, b(i));
		else
			fprintf( latex, ' = & %s\\frac{%d}{%d}', s, num, denom );
		end
		if i<row
			fprintf( latex, ' \\\\' );
		else
			fprintf( latex, '.' );
		end
		fprintf( latex, '\n' );
	end
	fprintf( latex, '\t\\end{array}\n\\]\n');
	fprintf( latex, '\n');
	fprintf( latex, '');
	fclose( latex );
end
