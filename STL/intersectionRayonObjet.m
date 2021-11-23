# en entrée :
# O : origine du rayon
# D : vecteur directeur du rayon
# L : position de la ource lumineuse
# obj : objet de la scène
# TMAX : constante permettant les initialisations avec une valeur suffisamment grande
# en sortie :
# la couleur et t : pt d'intersection = O .+ t .* D

function [couleur t] = intersectionRayonObjet(O, D, L, obj, TMAX)
  couleur = [200, 200, 200];
  cObj = obj.C(1,:);
  [nbFaces, nbVertex] = size(obj.F);
  t = TMAX;
  
  for f = 1:nbFaces
    if (produitScalaire(D,obj.N(f,:)) < 0) # facette orientée vers l'oeil 
      # récupérer les données de la facette
      Face = obj.F(f,:);
      Vertex = [];
      for i=1:length(Face)
            Vertex=[Vertex; obj.V(Face(i),:)]; 
      endfor
      Normales = [];
      for i=1:length(Face)
            Normales=[Normales; obj.NA(Face(i),:)]; 
      endfor 
      tObj = intersectionRayonFacette(O, D, Vertex, Normales, obj.N(f,:), f, TMAX);
      if (0 < tObj && tObj < t)
        t = tObj;
        # Lancer les rayons vers les sources lumineuses et calculer la couleur
        # Pour l'instant, faire avec un PS entre la N et une supposée lumière
        PtIntersection = O .+ t.*D;
        DL = vectorise(PtIntersection, L);
        DL = normer(DL);
        ps = produitScalaire(DL, obj.N(f,:));

        couleurAmbiante = round(cObj .* 0.3);  # Eclairage minimum simulé
        if ps > 0
          couleur = couleurAmbiante + 0.9 .* round(cObj .* ps); # Réflexion diffuse simulée
        else
          couleur = couleurAmbiante;
        endif
      endif
    endif
  endfor

endfunction