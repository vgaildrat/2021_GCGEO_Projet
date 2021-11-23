# en entrée :
  # obj :  données définissant l'objet 
  # limites : min x, y, z et max x, y, z des vertex 
# en sortie : pas de données, mais affichage du maillage 

function afficherMesh(obj, limites)
# Affichage juste pour vérifier que l'objet est correctement chargé
  V = obj.V;
  Col = obj.C;
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
  axis equal;
  xlim([limites(1,1) limites(2,1)]);
  ylim([limites(1,2) limites(2,2)]);
  zlim([limites(1,3) limites(2,3)]);
endfunction