
/* motif_sommet(+M, +LS, ?NLS, ?NLN, -Res, -ResNom)
M : liste représentant le motif à trouver
LS : liste des sommets de départ
NLS = [] : accumulateur stockant les nouveaux sommets obtenus grâce au motif
NLN = [] : accumulateur stockant les noms des nouveaux sommets obtenus grâce au motif
Res : permet d'obtenir tous les sommets désirés par backtrack
ResNom : permet d'obtenir les noms de tous les sommets désirés par backtrack
Fonction intermédiaire utilisée par get_motif_sommet et get_motif_sommet_nom */
motif_sommet(_, [], NLS, NLN, Res, ResNom) :-
    Res = NLS, ResNom = NLN.

motif_sommet(M, [S|LS], NLS, NLN, Res, ResNom) :-
    S = sommet(Nom, T),
    is_set(M), is_set(T), intersection(M, T, I),
    length(M, N), length(I, NN),
    (N == NN -> append(NLS, S, NNLS), append(NLN, Nom, NNLN), motif_sommet(M, LS, NNLS, NNLN, Res, ResNom)) ;
    motif_sommet(M, LS, NLS, NLN, Res, ResNom).


/* get_motif_sommet(+M, +LS, -Res)
M : liste représentant le motif à trouver
LS : liste des sommets de départ
Res : liste de tous les sommets qui correspondent avec le motif M
Test
get_motif_sommet([rock, blues], [sommet(a,[rock,folk,jazz]),sommet(b,[rock,folk,blues,jazz]),sommet(c,[rock,folk,jazz]),sommet(d,[rock,folk,jazz]),sommet(e,[rock,folk,blues]),sommet(f,[folk,blues]),sommet(g,[rock,folk,jazz]),sommet(h,[rock,folk]),sommet(i,[folk,blues]),sommet(j,[blues,jazz]),sommet(k,[rock]),sommet(l,[jazz,pop]),sommet(m,[rock,folk]),sommet(n,[rock,folk,pop,blues]),sommet(o,[rock,folk,pop]),sommet(p,[rock,folk,pop,jazz]),sommet(q,[rock,folk,pop]),sommet(r,[rock,folk,pop,blues])], Res), writeln(''), writeln(Res). */
get_motif_sommet(M, LS, Res) :-
    findall(NLS, motif_sommet(M, LS, [], [], NLS, _), Res).


/* get_motif_sommet_nom(+M, +LS, -Res)
M : liste représentant le motif à trouver
LS : liste des sommets de départ
Res : liste de tous les noms des sommets qui correspondent avec le motif M
Test
get_motif_sommet_nom([rock, blues], [sommet(a,[rock,folk,jazz]),sommet(b,[rock,folk,blues,jazz]),sommet(c,[rock,folk,jazz]),sommet(d,[rock,folk,jazz]),sommet(e,[rock,folk,blues]),sommet(f,[folk,blues]),sommet(g,[rock,folk,jazz]),sommet(h,[rock,folk]),sommet(i,[folk,blues]),sommet(j,[blues,jazz]),sommet(k,[rock]),sommet(l,[jazz,pop]),sommet(m,[rock,folk]),sommet(n,[rock,folk,pop,blues]),sommet(o,[rock,folk,pop]),sommet(p,[rock,folk,pop,jazz]),sommet(q,[rock,folk,pop]),sommet(r,[rock,folk,pop,blues])], Res), writeln(''), writeln(Res). */
get_motif_sommet_nom(M, LS, Res) :-
    findall(LN, motif_sommet(M, LS, [], [], _, LN), Res).


/* liste_arete(+LS, +LA, ?NLA, -Res)
LS : liste des sommets de départ
LA : liste des aretes de départ
NLA = [] : accumulateur stockant les aretes qui ne correspondent PAS avec les sommets de LS
Res : permet d'obtenir toutes les aretes désirés par backtrack
Fonction intermédiaire utilisée par get_liste_arete */
liste_arete(_, [], NLA, Res) :-
    Res = NLA.

liste_arete(LS, [A|LA], NLA, Res) :-
    A = arete(A1, A2), X = [A1], Y = [A2],
    intersection(LS, X, I), intersection(LS, Y, II),
    ((length(I, 0) ; length(II, 0)) -> append(NLA, A, NNLA), liste_arete(LS, LA, NNLA, Res)) ;
    liste_arete(LS, LA, NLA, Res).


/* get_liste_arete(+LS, +LA, -Res)
LS : liste des sommets dont on veut conserver les aretes
LA : liste des aretes de départ
Res : liste de toutes les aretes qui correspondent uniquement aux sommets de LS
Test
get_liste_arete([a,c,n,p,[]], [arete(a,b),arete(a,c),arete(a,d),arete(a,e),arete(a,i),arete(a,j),arete(a,k),arete(a,r),arete(b,c),arete(b,d),arete(c,d),arete(c,g),arete(c,l),arete(c,m),arete(e,f),arete(e,g),arete(e,h),arete(f,g),arete(f,h),arete(g,h),arete(h,j),arete(i,j),arete(i,k),arete(i,p),arete(j,k),arete(k,p),arete(l,m),arete(l,n),arete(m,n),arete(n,o),arete(n,p),arete(n,q),arete(n,r),arete(o,p),arete(o,q),arete(o,r),arete(p,q),arete(p,r),arete(q,r)], Res), writeln(''), writeln(Res). */
get_liste_arete(LS, LA, Res) :-
    findall(NLA, liste_arete(LS, LA, [], NLA), T), /* T contient toutes les aretes reliant au moins un sommet qui n'est pas dans LS */
    subtract(LA, T, Res).
