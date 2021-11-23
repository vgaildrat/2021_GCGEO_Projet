# en entrée :
# O : origine du rayon
# D : vecteur directeur du rayon
# L : position de la ource lumineuse
# objets : objets de la scène, chaque objet est une structure
# boites : boites englobantes, une par objet, chaque boite est une structure
# spheres : spheres englobantes, une par objet, chaque sphere est une structure
# TMAX : constante permettant les initialisations avec une valeur suffisamment grande
# en sortie :
# la couleur à stocker dans l'image

function couleur = lancerDeRayons(O, D, L, objets, boites, spheres, TMAX)
  # boites et/ou spheres à utiliser ici pour éviter les calculs inutiles
  # sur-échantillonnage possible
  
  # couleur init, grise
  couleur=[200 200 200];
  tMin = TMAX;
  # le rayon est lancé dans la scène
  for i = 1:size(objets)(1)
    # calcul d'intersection avec les objets 1 à 1
    [coul t] = intersectionRayonObjet(O, D, L, objets(i), TMAX);
    # on récupère la couleur si le pt d'intersection est plus près de l'oeil
    if t < tMin
      tMin = t; # c'est le nouveau minimum
      couleur = coul;
    endif
  endfor
endfunction