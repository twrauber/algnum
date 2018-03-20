%%
%% Distância relativa entre dois vetores
%%
%% Input: dois vetores a, b
%% Output: distancia
%%
function dr = distrel( a, b )
	dr = max(abs(a-b)) / max(abs(a));
end



