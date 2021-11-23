# en entrée :
  # sphere :  données définissant une sphère englobante
  # limites : min x, y, z et max x, y, z de la boîte englobant la sphère
# en sortie : pas de données, mais affichage de la sphère englobante

function afficherSphereEnglo(sphere, limites)
  C = sphere.C;
  r = sphere.r;
  [X Y Z] = ellipsoid(C(1), C(2), C(3), r, r, r);
  plot3(X, Y, Z);  
  axis equal;
  xlim([limites(1,1) limites(2,1)]);
  ylim([limites(1,2) limites(2,2)]);
  zlim([limites(1,3) limites(2,3)]);

endfunction