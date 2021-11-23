# en entrée:
# fid : identification du fichier 
# en sortie :
# V : les vertex : 3 coordonnées
# F : les facettes : pour chacune 3 ou 4 index de vertex 
# N : les normales à chaque facettes : 3 coordonnées
# NA : les vecteurs entre vertex : 3 coordonnées
# C : vecteur de couleurs de la facette RGB entre 0 et 255
# Lecture d'un fichier stl ASCII (d'où le A)
function [V, F, N, NA, C] = stlAread(fid)
  % Reads an STL ASCII file
  fileTitle=sscanf(fgetl(fid),'%*s %s');
  vnum=1;
  V = [];
  N = [];
  C = [];
  F = [];
  Na = [];
  fclr=0;
  testASCII=true;
  lineCount=0;
  while feof(fid) == 0
    stlLine=fgetl(fid);
    keyWord=sscanf(stlLine,'%s');
    if strncmpi(keyWord,'color',5) == 1;
      nc=sscanf(stlLine,'%*s %f %f %f');
      C = [C; nc'];
    elseif strncmpi(keyWord,'facet',5) == 1;
      nn =sscanf(stlLine,'%*s %*s %f %f %f');
      N = [N; normer(nn')];
    elseif strncmpi(keyWord,'outer',5) == 1;
      nf = [];
    elseif strncmpi(keyWord,'endloop',7) == 1;
        F = [F; nf];
        nf = [];
    elseif strncmpi(keyWord,'vertex',6) == 1;
      nv = sscanf(stlLine, '%*s %f %f %f');
      nf = [nf, vnum];
      vnum = vnum + 1;
      V = [V; nv'];
    elseif testASCII
      lineCount=lineCount+1;
      if lineCount>20
        if vnum>2
          testASCII=false;
        else
          error('File is not an STL ASCII file!')
        endif
      endif
    endif
  endwhile
  
  # Calculer les normales aux arêtes
  NA = normalesAretes(V, 3);
  if size(C)(1) == 0
    C = [200 200 0];
  endif

endfunction
