function linsysTEST()

x0dim2 = zeros(2,1);
x0dim3 = zeros(3,1);
x0dim4 = zeros(4,1);

A = [5,1,1; 3,4,1; 3,3,6]; b = [5;6;0];
%A = [-1 2 1;4 1 -3;1 1 2]; b = [1;-11;2];
%A = [4 3 2; 4 5 1; -1 2 -3]; b = [1;0;-5];
%A = [4 1 -3;-1 2 1;1 1 2]; b = [-11;1;2];
%A = [2 -1; 1 2]; b = [1;3];
%A = [1 2 3; 4 5 6; 7 8 9]; b = [1;-11;2];

[cGJ, cGS] = testeConvRaioEspectral( A ) 
%disp('Enter para continuar...'); pause();

disp('--- G A U S S - J A C O B I ---')
A
b
eps = 0.02
maxiter = 20
x = GaussJacobi(A,b,x0dim3,eps,maxiter)

disp('--- G A U S S - S E I D E L ---');
A
b
eps = 0.4
maxiter = 20
disp('--- explicito ---');
x = GaussSeidel(A,b,x0dim3,eps,maxiter)
disp('--- matricial ---');
x = GaussSeidelMatricial(A,b,x0dim3,eps,maxiter)
%disp('Enter para continuar...'); pause();


disp('--- S O R ---');
A
b
eps = 0.02
maxiter = 20
% 1 < omega < 2
for omega=0.2:0.2:1.8
	omega
	x = SOR(A,b,x0dim3,omega,eps,maxiter)
end


disp('Produzindo LaTeX ...');
printLaTeX(A, b, '_out_printLaTeX.tex', 'LS_METHOD_GAUSS' );
printLaTeX(A, b, '_out_printLaTeX.tex', 'LS_METHOD_GAUSS_PIV' );
printLaTeX(A, b, '_out_printLaTeX.tex', 'LS_METHOD_LU' );
printLaTeX(A, b, '_out_printLaTeX.tex', 'LS_METHOD_LU_PIV' );

end % linsysTEST
