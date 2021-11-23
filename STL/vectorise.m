# En entrée :
# P1, P2 : deux points
# En sortie : 
# V : vecteur (P1, P2)

function V = vectorise(P1,P2)
  V(1) = P2(1)-P1(1);
  V(2) = P2(2)-P1(2);
  V(3) = P2(3)-P1(3);
end  