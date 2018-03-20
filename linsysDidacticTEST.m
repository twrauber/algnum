%%=================================================
% Solução de sistemas lineares com suporte didatico
% Autor: Thomas W. Rauber trauber@gmail.com , 2009
%%=================================================

SETUP

%A = [5,1,1; 3,4,1; 3,3,6]; b = [5;6;0];
%A = [-1 2 1;4 1 -3;1 1 2]; b = [1;-11;2];
%A = [4 3 2; 4 5 1; -1 2 -3]; b = [1;0;-5];
%A = [4 1 -3;-1 2 1;1 1 2]; b = [-11;1;2];
%A = [3 2 4; 1 1 2; 4 3 -2]; b = [1;2;3];
%A = [3 -1 2; 1 4 2; 2 -2 2]; b = [3.5;3;5];
A = [3 -1 2; 1 4 2; 2 -6 2]; b=[2 5.5 0]';

%y = trianInf( [1,0,0; 3/4,1,0; 1/4,-1/2,1], [-2;9;3] )


disp('--- E L I M I N A Ç Ã O  D E  G A U S S ---')
A
b
[Atil, btil] = elimGauss( A, b )
x = trianSup( Atil, btil )

disp('--- E L I M I N A Ç Ã O  D E  G A U S S  C O M  P I V O T E A M E N T O  P A R C I A L ---')
A
b
[Atil, btil] = elimGaussPivPar( A, b )
x = trianSup( Atil, btil )

disp('--- D E C O M P O S I Ç Ã O  L U  S E M  P I V O T E A M E N T O ---')
A = [3 -4 1; 1 2 2; 4 0 -3]; b = [9;3;-2];
A
b
[LU, y, x] = decompLU( A, b )

disp('--- D E C O M P O S I Ç Ã O  L U  C O M  P I V O T E A M E N T O  P A R C I A L ---')
A = [3 -4 1; 1 2 2; 4 0 -3]; b = [9;3;-2];
A
b
[LU, Pb, y, x] = luPivPar( A, b )

