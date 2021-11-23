# Affichage juste pour vérifier que l'objet est chargé

# en entrée :
# V : les vertex : 3 coordonnées
# F : les facettes : pour chacun des 4 index de vertex 
# N : les normales à chaque facettes : 3 coordonnées
# Col : couleur de l'objet (R G V)
# en sortie :
# en sortie : pas de données, mais affichage de la sphère englobante

function afficherSTL(V, F, N, Col)
  # ce sont des facettes triangulaires
  [L, C] = size(V);
  Vx = [];
  Vy = [];
  Vz = [];

  i = 1;
  while i < L
    Vx = [Vx, V(i:i+2,1)];
    i = i + 3;
  endwhile
  i = 1;
  while i < L
    Vy = [Vy, V(i:i+2,2)];
    i = i + 3;
  endwhile
  i = 1;
  while i < L
    Vz = [Vz, V(i:i+2,3)];
    i = i + 3;
  endwhile

  light("position", [-100, -100, 0]);
  light("position", [+10, +100, 0]);
  material shiny;
  shading interp;
  if size(Col) != [0 0]
    h=surf(Vx,Vy,Vz,'FaceColor',[Col(1,1)/255, Col(1,2)/255, Col(1,3)/255],'EdgeColor','r');
    lighting gouraud;

    printf("V avec couleurs\n");
  else
    h = mesh(Vx, Vy, Vz);
    set(h, "EdgeColor", "g", "FaceColor", "interp");
    printf("V sans couleurs\n");
  end


  #axis image
  axis equal

##  sc=0.2;
##
##  xl=xlim;
##  dx=xl(2)-xl(1);
##  xl(1)=xl(1)-sc*dx;
##  xl(2)=xl(2)+sc*dx;
##  xlim(xl);
##
##  yl=ylim;
##  dy=yl(2)-yl(1);
##  yl(1)=yl(1)-sc*dy;
##  yl(2)=yl(2)+sc*dy;
##  ylim(yl);
##
##  zl=zlim;
##  dz=zl(2)-zl(1);
##  zl(1)=zl(1)-sc*dz;
##  zl(2)=zl(2)+sc*dz;
##  zlim(zl);

endfunction