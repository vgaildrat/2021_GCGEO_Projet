# En entrée : 
# limites : limites de l'écran en x et y
# En sortie : 
# Matrice image initialisée à "blanc"

function Image = ecran(limites)
  # suréchantillonnage régulier
  Image = zeros(round(limites(2,1)-limites(1,1)),    # les X == lignes
                round(limites(2,2)-limites(1,2)),  # les Y == les colonnes
                3);  
  Image = Image .+255;
endfunction