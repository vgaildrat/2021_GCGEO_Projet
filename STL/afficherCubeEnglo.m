# en entrée :
  # cube :  données définissant un cube englobant (notamment les vertex)
  # limites : min x, y, z et max x, y, z des vertex 
# en sortie : pas de données, mais affichage du cube englobant

function afficherCubeEnglo(cube, limites)
  # Affichage juste pour vérifier que le cube est correctement calculé
  V = cube.V;

  # ce sont des quadrilatères : V => 4 vertex
  [L, C] = size(V);
  X = V(:,1)';
  Y = V(:,2)';
  Z = V(:,3)';
  scatter3 (X(:), Y(:), Z(:), 20, Z(:), "s");
  axis equal;
  xlim([limites(1,1) limites(2,1)]);
  ylim([limites(1,2) limites(2,2)]);
  zlim([limites(1,3) limites(2,3)]);
endfunction