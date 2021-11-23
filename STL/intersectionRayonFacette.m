# en entrée :
# O : origine du rayon
# D : vecteur directeur du rayon
# V : vertex de la facette
# NA : vecteurs entre sommets de la facette
# N : normale à la facette
# facette : index des vertex de la facette
# TMAX : constante permettant les initialisations avec une valeur suffisamment grande
# en sortie :
# t : pt d'intersection = O .+ t .* D

function t = intersectionRayonFacette(O, D, V, NA, N, facette, TMAX) 
  # N Normale orientée vers l'oeil (test fait précédemment)
  # V == vertex de la facette, à 3 ou 4 points
  P = [0 0 0];
  psDN = produitScalaire(D,N);
##  if psDN == 0   # vecteurs perpendiculaires, pas d'intersection (impossible avec les tests précédents ?)
##    t = TMAX;
##    return;
##  endif
  # calcul du point d'intersection rayon-facette
  # résultat de la résolution d'un système où t est l'inconnue
  OV1 = vectorise(O, V(1,:));
  psOV1N = produitScalaire(OV1,N); 
  t = psOV1N/psDN;
  P = O .+ t.*D;
  # Vérifier que P est dans la facette 
  ViP = []; # Vecteurs sommets P
  CiP = []; # PV entre ces vecteurs et les NA pour obtenir un vecteur perpendiculaire au segment
  for i = 1:size(V)(1)
    ViP = [ViP; vectorise(V(i,:), P)];
    CiP = [CiP; produitVectoriel(NA(i,:), ViP(i,:))];
  endfor
  for i = 1:size(V)(1) # pour chaque vertex
    # si P est dans la facette le PS est positif pour chaque segment
    if (produitScalaire(N, CiP(i,:)) < 0)
      t = TMAX;
    endif
  endfor
endfunction