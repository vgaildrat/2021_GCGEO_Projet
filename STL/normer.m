# En entrée : 
# L : vecteur à normer
# En sortie : 
# L Vecteur normé

function L = normer(L)
  norme = norme(L);
  L = L ./ norme;
endfunction