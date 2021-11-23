
printf("Main principal : \n");
objets = []; # un vecteur d'objets
boitesEnglo = [];  # toutes les boites englobantes
spheresEnglo = []; # toutes les spheres englobantes

TMAX=1000; # valeur suffisamment grande 
Min = [TMAX TMAX TMAX];  # pour calculer l'étendue couverte par les objets min
Max = [-TMAX -TMAX -TMAX]; # et max

### A faire pour chaque objet à charger
disp("entrer le nom des fichiers au format stl ou model (entrée pour terminer la saisie)");
nom=input("nom du fichier : ", "s"); # saisie du premier objet
while (strfind(nom, ".stl") || strfind(nom, ".model"))
  [V, F, N, NA, C] = stl2mesh(nom);  # le chargement d'un objet produit :
  obj.V = V; # les vertex : 3 coordonnées
  obj.F = F; # les facettes : pour chacune 3 ou 4 index de vertex 
  obj.N = N; # les normales à chaque facettes : 3 coordonnées
  obj.NA = NA; # les vecteurs entre vertex : 3 coordonnéest
  obj.C = C; # la couleur de l'objet : [R G B] entre 0 et 255
  # ces données sont stockées dans une structure appelée obj
  objets = [objets; obj]; # ajout de obj dans objets
  

  # calcul des coordonnées min et max occupée par tous les objets chargés
  # en intégrant obj dans le calcul
  [Min Max] = calculMinMax(V, Min, Max);

  # calcul de la boite englobante de obj à partir de ses vertex
## TODO
##  [V, F, N, NA, C]= boiteEnglobante(obj.V); # ce qui produit :
##  boite.V = V; # les vertex
##  boite.F = F; # les facettes à 4 vertex
##  boite.N = N; # les normales de chaque facette
##  boite.NA = NA; # les vecteurs entre les vertex
##  boite.C = C; # inutilisé ici mais prévu dans les objets
##  boitesEnglo = [boitesEnglo; boite]; # ajout de la boite dans les boites

  # calcul de la sphere englobante de obj à partir de ses vertex
## TODO
##  [Centre, rayon] = sphereEnglobante(obj.V); # ce qui produit :
##  sphere.C = Centre; # le centre
##  sphere.r = rayon; # le rayon de la sphere
##  spheresEnglo = [spheresEnglo; sphere]; # ajout de la sphere dans les spheres
##  nom=input("nom du fichier : ", "s"); # saisie du prochain objet
endwhile

# on n'utilise qu'une seule source lumineuse, mais peut-être modifié
disp("position de la source lumineuse : ");
L = [0 0 0];
L(1) = input("en x : ");
L(2) = input("en y : ");
L(3) = input("en z : ");

# on calcule les limites nécessaires pour l'écran, afin qu'on puisse voir tous les obiets chargés
limites = zeros(2, 3);
facteur = 2;
limites(1,:) = [Min(1)-(Max(1)-Min(1)/facteur) Min(2)-(Max(2)-Min(2)/facteur) Min(3)-(Max(3)-Min(3)/facteur)];
limites(2,:) = [Max(1)+(Max(1)-Min(1)/facteur) Max(2)+(Max(2)-Min(2)/facteur) Max(3)+(Max(3)-Min(3)/facteur)];

# taille de l'image qui permet l'affichage de l'écran
Image = ecran(limites);

# Pour chaque pixel de l'image appeler lancer de rayons pour calculer l'image
# La projection est orthographique, tous les rayons sont // comme si l'oeil 
# était à l'infini sur les Z positifs
D = [0 0 -1];         # vecteur directeur du rayon "oeil" vers les Z négatifs
yI = round(limites(1,2)); # les coord de l'écran sont différents des coord Image
for y = 1:size(Image)(2) 
  xI = round(limites(1,1)); # les coord de l'écean sont différents des coord Image
  for x = 1:size(Image)(1)
    O = [xI, yI, TMAX/2];  # pt origine du rayon, suffisamment "loin" sur les Z positifs
    # le résultat du calcul du lancer de rayons est stocké dans l'image
    Image(x, y,:) = lancerDeRayons(O, D, L, objets, boitesEnglo, spheresEnglo, TMAX);
    xI += 1;
  endfor
  yI += 1;
endfor

### Affichage pour vérification
axis equal;
# permet de fixer position et taille de l'image résultante
figure(1, 'units', 'points','position',[0, 300, 600,250])
# Afficher les objets
subplot(1, 2, 1);
hold on;
for i = 1:size(objets)(1)
  afficherMesh(objets(i), limites);
endfor
xlabel("X");
ylabel("Y");
zlabel("Z");
hold off;

# Afficher l'image
subplot(1,2,2);
colormap("default");
axis equal;
Image = Image ./ 255;
image(Image);

xlabel("X");
ylabel("Y");
disp("Fin du main"); 
