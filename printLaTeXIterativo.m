%%
%% Imprimir Sistema Linear A x = b para documentação LaTeX
%%
%% Input: Matriz A de coeficientes, b vetor de constantes,
%%	nome do arquivo de saída (entre aspas), método
%% Output: Texto em arquivo de texto no formato LaTeX
%%



function printLaTeXIterativo( A, b, x0, eps, maxiter, filename, method )
	% Verificação das dimensões da matriz e do vetor
	[row,col] = size(A); rowb = length(b);
	if row ~= col || row ~= rowb
			disp('Erro de dimensao de matriz e/ou vetor'); wait();
			return;
	end
	latex = fopen( filename, 'a+');
	fprintf('Acrescentando LaTeX no final de ''%s''...\n', filename );

	fprintf( latex, '%%\nSeja dado o sistema linear $A x = b$, com\n');
	fprintf( latex, '$');
	fprintf( latex, 'A = \\left( \\begin{array}{r'); for j=1:col fprintf(latex,'rr');end
	fprintf( latex, '}\n');
	
	
	for i=1:row
		fprintf( latex, '\t\t' );
		for j=1:col
			s = dec2fracstr( A(i,j), 5, 1E-5, 100 );
			fprintf( latex, '%s ', s );
			if j < col
				fprintf( latex, '& ', s );
			end
		end
		fprintf( latex, '\\\\\n' );	
	end	
	fprintf( latex, '\t\\end{array} \\right)');
	fprintf( latex, '$');
	fprintf( latex, ', b = $\\left( \\begin{array}{r}');
	for i=1:rowb
		s = dec2fracstr( b(i), 5, 1E-5, 100 );
		fprintf( latex, '%s \\\\', s );
	end	
	fprintf( latex, '\\end{array} \\right)$.\n');

	
	
	fprintf( latex, 'Use o método de ');
	
	switch ( method )
		case 'GAUSS_JACOBI'
			fprintf( latex, 'Gauss-Jacobi' );
		case 'GAUSS_SEIDEL'
			fprintf( latex, 'Gauss-Seidel' );
		otherwise
			disp('Metodo desconhecido'); wait();
			return;
    end
	fprintf( latex, ' para obter o valor aproximado $\\overline{x}$ da\n');
	fprintf( latex, 'solução exata $x^{*}$ por soluções aproximadas consecutivas $x^{(k)}$,\n');
	fprintf( latex, 'com a solução inicial ');


	fprintf( latex, '$x^{(0)}=\\left(\\begin{array}{ccc}');
	for i=1:rowb
		s = dec2fracstr( x0(i), 5, 1E-5, 100 );
		fprintf( latex, '%s ', s );
		if i < rowb
			fprintf( latex, '& ', s );
		end
	end	
	fprintf( latex, '\\end{array}\\right)\\transpose$.');

	for i=1:5 fprintf( latex, '%%\n'); end
	fprintf( latex, '%% INSERIR MAIS LaTeX AQUI...\n');
	for i=1:5 fprintf( latex, '%%\n'); end


	fprintf( latex, 'Sendo $\\epsilon=%.1f$ o limiar para a distância relativa\n', eps )
	fprintf( latex, ' $d_{\\mathrm{rel}}^{(k+1)} = {\\max\\limits_{1 \\leq i \\leq n}\n');
	fprintf( latex, '	\\{|x_{i}^{(k+1)}-x_{i}^{(k)}|} \\} / \n');
	fprintf( latex, '	{\\max\\limits_{1 \\leq i \\leq n} \\{|x_{i}^{(k+1)}|\\} }$ entre duas soluções consecutivas, \n');
	fprintf( latex, 'e o número máximo de iterações\n');
	fprintf( latex, '$k_{\\mathrm{max}}=%d$,\n', maxiter);
	fprintf( latex, 'obtenha a sequência de\n');
	fprintf( latex, 'soluções aproximadas $x^{(1)}, x^{(2)},\\ldots$.\n');


	fprintf( latex, '\n%%\n');
	fclose( latex );
end
