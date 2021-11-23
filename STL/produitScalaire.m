# En entrée :
# V1, V2 : deux vecteurs
# En sortie : 
# ps : produit scalaire des deux vecteurs

function ps = produitScalaire(V1,V2)
  ps = V1(1)*V2(1) + V1(2)*V2(2) + V1(3)*V2(3);
end  