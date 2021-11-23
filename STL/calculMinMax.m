# en entrée :
# Vertex : vertex définissant un objet
# Min, Max : coordonnées min et max à mettre à jour par comparaison avec les vertex en entrée
# en sortie :
# Min et Max mis à jour

function [Min Max] = calculMinMax(Vertex, Min, Max)
  [L, C] = size(Vertex);
  Mini = Vertex(1,:);
  Maxi = Vertex(1,:);

  for l = 1:L  
    for c = 1:3
      if Vertex(l,c) < Mini(c)
        Mini(c) = Vertex(l,c);
      endif
      if Vertex(l,c) > Maxi(c)
        Maxi(c) = Vertex(l,c);
      endif
    endfor
  endfor
  for c = 1:3  
    if (Mini(c) < Min(c))
      Min(c) = Mini(c);
    endif
    if (Maxi(c) > Max(c))
      Max(c) = Maxi(c);
    endif
  endfor
  
endfunction