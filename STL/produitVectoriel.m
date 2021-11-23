# En entrée :
# V1, V2 : deux vecteurs
# En sortie : 
# PV : produit vectoriel des deux vecteurs

function PV=produitVectoriel(V1,V2)
  PV(1) = V1(2)*V2(3) - V1(3)*V2(2);
  PV(2) = V1(3)*V2(1) - V1(1)*V2(3);
  PV(3) = V1(1)*V2(2) - V1(2)*V2(1);
end  