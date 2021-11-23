# en entrée:
# fid : identification du fichier 
# en sortie :
# V : les vertex : 3 coordonnées
# F : les facettes : pour chacune 3 ou 4 index de vertex 
# N : les normales à chaque facettes : 3 coordonnées
# NA : les vecteurs entre vertex : 3 coordonnées
# C : vecteur de couleurs de la facette RGB entre 0 et 255

function [Ve, F, N, NA, C] = modelRead(fid)
  % Reads an STL ASCII file
  V = [];
  N = []; # A calculer
  C = [];
  F = [];
  Ve= [];
  Na = [];
  testASCII=true;
  lineCount=0;
  while feof(fid) == 0
    stlLine=fgetl(fid);
    keyWord=sscanf(stlLine,'%s');
    if length(strfind(stlLine, "color color"))  != 0
      while stlLine(1) != '#'
        stlLine(1) = [];
      endwhile
      stlLine(1) = [];
      nc=[hex2dec(stlLine(1:2)) hex2dec(stlLine(3:4)) hex2dec(stlLine(5:6))]
      C = [C; nc];
    elseif length(strfind(stlLine, "vertex")) != 0
      i=1;
      while ((stlLine(i) < '0' || '9' < stlLine(i)) && stlLine(i) != '.')
        stlLine(i) = [];
      endwhile
      while (('0'<= stlLine(i) && stlLine(i) <= '9') || stlLine(i) == '.') 
        i+=1;
      endwhile
      stlLine(i) = [];
      i+=1;
      while ((stlLine(i) < '0' || '9' < stlLine(i)) && stlLine(i) != '.')
        stlLine(i) = [];
      endwhile
      while (('0'<= stlLine(i) && stlLine(i) <= '9') || stlLine(i) == '.') 
        i+=1;
      endwhile
      stlLine(i) = [];
      i+=1;
      while ((stlLine(i) < '0' || '9' < stlLine(i)) && stlLine(i) != '.')
        stlLine(i) = [];
      endwhile
      while (('0'<= stlLine(i) && stlLine(i) <= '9') || stlLine(i) == '.') 
        i+=1;
      endwhile
      stlLine(i) = [];
      i+=1;
      nv =sscanf(stlLine,'%f %f %f');
      V = [V; nv'];
    elseif length(strfind(stlLine, "triangle ")) != 0
      i=1;
      while (stlLine(i) != '=')
        stlLine(i) = [];
      endwhile
      stlLine(i) = []; # =
      stlLine(i) = []; # "
      while (stlLine(i) != '"') 
        i+=1;
      endwhile
      stlLine(i) = []; # "
      i+=1; # espace
      while (stlLine(i) != '=')
        stlLine(i) = [];
      endwhile
      stlLine(i) = []; # =
      stlLine(i) = []; # "
      while (stlLine(i) != '"') 
        i+=1;
      endwhile
      stlLine(i) = []; #"
      i+=1; # espace
      while (stlLine(i) != '=')
        stlLine(i) = [];
      endwhile
      stlLine(i) = []; # =
      stlLine(i) = []; # "
      while (stlLine(i) != '"') 
        i+=1;
      endwhile
      stlLine(i) = []; # "
      i+=1; # espace
      nf = sscanf(stlLine, '%d %d %d');
      nf = nf .+ 1;
      F = [F; nf'];
    elseif testASCII
      lineCount=lineCount+1;
    endif
  endwhile
  # Mise au format du STL
  for l=1:size(F)(1)
      vertex = [V(F(l,1),:); V(F(l,2),:); V(F(l,3),:)];
      Ve = [Ve; vertex];
  endfor
  # Calculer les normales
  N = zeros(size(F));
  NA = normalesAretes(Ve, 3);
  # Calculer les normales aux arêtes 
  numN = 1;
  for l = 1:3:size(Ve)(1)
    N(numN,:) = normer(produitVectoriel(NA(l,:), NA(l+2,:)));
    numN += 1;
  endfor

endfunction
