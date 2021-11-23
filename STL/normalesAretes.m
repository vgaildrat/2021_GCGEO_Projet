# en entrée:
# V : vertex de la facette
# nbVertexFacette : nombre de vertex de la facette
# en sortie :
# NA : matrice de vecteurs entre couples de vertex successifs

function NA = normalesAretes(V, nbVertexFacette)
  NA = zeros(size(V));
  # si facette triangulaire, vecteurs qui relient p1 à p2, p2 à P3, P3 à P1
  # si quad, vecteurs qui relient p1 à p2, p2 à P3, P3 à P4, P4 à P1
  n = 1;
  for l=1:nbVertexFacette:size(V)(1)
    NA(l,:) = vectorise(V(l,:), V(l+1,:));
    NA(l+1,:) =vectorise(V(l+1,:), V(l+2,:)); 
    if (nbVertexFacette == 3)
          NA(l+2,:) =vectorise(V(l+2,:), V(l,:)); 
    endif
    if (nbVertexFacette == 4)
          NA(l+2,:) =vectorise(V(l+2,:), V(l+3,:)); 
          NA(l+3,:) =vectorise(V(l+3,:), V(l,:)); 
    endif
  endfor
  return;
endfunction
