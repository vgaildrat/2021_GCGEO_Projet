# en entrée:
# stlfile : nom du fichier (.stl ou .model)
# en sortie :
# V : les vertex : 3 coordonnées
# F : les facettes : pour chacune 3 ou 4 index de vertex 
# N : les normales à chaque facettes : 3 coordonnées
# NA : les vecteurs entre vertex : 3 coordonnées
# C : vecteur de couleurs de la facette RGB entre 0 et 255

function  [V, F, N, Na, C] =stl2mesh(stlfile)
  filename = sprintf("data/%s", stlfile);
  # fichier ouvert en lecture
  fid = fopen (filename, "r");
  if nargin == 0
      warning('No file is specified');
  endif
  % Try to read an ASCII file
  if (strfind(stlfile, ".stl"))
    [V, F, N, Na, C] = stlAread(fid);
  elseif (strfind(stlfile, ".model"))
    [V, F, N, Na, C] = modelRead(fid);
  endif

  if size(V) ==[0]
     error('File could not be read!');
  endif
  disp("Fichier correctement chargé");
  fclose(fid);
    
endfunction