/* degre(+S, +LA, ?Acc, -D)
S : sommet dont on veut déterminer le degré
LA : liste des aretes de départ
Acc = [] : accumulateur permettant d'obtenir le degré directement sans backtrack
D : entier représentant le degré du sommet S
Test
degre(a, [arete(a,b),arete(a,c),arete(a,d),arete(a,e),arete(a,i),arete(a,j),arete(a,k),arete(a,r),arete(b,c),arete(b,d),arete(c,d),arete(c,g),arete(c,l),arete(c,m),arete(e,f),arete(e,g),arete(e,h),arete(f,g),arete(f,h),arete(g,h),arete(h,j),arete(i,j),arete(i,k),arete(i,p),arete(j,k),arete(k,p),arete(l,m),arete(l,n),arete(m,n),arete(n,o),arete(n,p),arete(n,q),arete(n,r),arete(o,p),arete(o,q),arete(o,r),arete(p,q),arete(p,r),arete(q,r)], 0, X).
Remarque : cut vert car grace à l'accumulateur, la réponse est donnée sans avoir besoin du backtrack */
degre(_, [], Acc, D) :- D = Acc.

degre(S, [A|LA], Acc, D) :-
    A = arete(X, Y),
    ((S == X ; S == Y) -> NAcc is Acc + 1, degre(S, LA, NAcc, D)), ! ;
    degre(S, LA, Acc, D).


/* degre_sommet(+D, +LS, +LA, ?NLS, ?NLN, -Res, -ResNom)
D : entier tel que deg(S) >= D, pour tout S de LS
LS : liste des sommets de départ
LA : liste des aretes de départ
NLS = [] : accumulateur stockant les nouveaux sommets obtenus grâce au degré
NLN = [] : accumulateur stockant les noms des nouveaux sommets obtenus grâce au degré
Res : permet d'obtenir tous les sommets désirés par backtrack
ResNom : permet d'obtenir les noms de tous les sommets désirés par backtrack
Fonction intermédiaire utilisée par get_degre_sommet et get_degre_sommet_nom */
degre_sommet(_, [], _, NLS, NLN, Res, ResNom) :-
    Res = NLS, ResNom = NLN.

degre_sommet(D, [S|LS], LA, NLS, NLN, Res, ResNom) :-
    S = sommet(Nom, _), degre(Nom, LA, 0, DS),
    (DS >= D -> append(NLS, S, NNLS), append(NLN, Nom, NNLN), degre_sommet(D, LS, LA, NNLS, NNLN, Res, ResNom)) ;
    degre_sommet(D, LS, LA, NLS, NLN, Res, ResNom).


/* get_degre_sommet(+D, +LS, +LA, -Res)
D : entier tel que deg(S) >= D, pour tout S de LS
LS : liste des sommets de départ
LA : liste des aretes de départ
Res : liste de tous les sommets qui vérifient l'inegalité avec le degré
Test
get_degre_sommet(6, [sommet(a,[rock,folk,jazz]),sommet(b,[rock,folk,blues,jazz]),sommet(c,[rock,folk,jazz]),sommet(d,[rock,folk,jazz]),sommet(e,[rock,folk,blues]),sommet(f,[folk,blues]),sommet(g,[rock,folk,jazz]),sommet(h,[rock,folk]),sommet(i,[folk,blues]),sommet(j,[blues,jazz]),sommet(k,[rock]),sommet(l,[jazz,pop]),sommet(m,[rock,folk]),sommet(n,[rock,folk,pop,blues]),sommet(o,[rock,folk,pop]),sommet(p,[rock,folk,pop,jazz]),sommet(q,[rock,folk,pop]),sommet(r,[rock,folk,pop,blues])], [arete(a,b),arete(a,c),arete(a,d),arete(a,e),arete(a,i),arete(a,j),arete(a,k),arete(a,r),arete(b,c),arete(b,d),arete(c,d),arete(c,g),arete(c,l),arete(c,m),arete(e,f),arete(e,g),arete(e,h),arete(f,g),arete(f,h),arete(g,h),arete(h,j),arete(i,j),arete(i,k),arete(i,p),arete(j,k),arete(k,p),arete(l,m),arete(l,n),arete(m,n),arete(n,o),arete(n,p),arete(n,q),arete(n,r),arete(o,p),arete(o,q),arete(o,r),arete(p,q),arete(p,r),arete(q,r)], Res), writeln(''), writeln(Res). */
get_degre_sommet(D, LS, LA, Res) :-
    findall(NLS, degre_sommet(D, LS, LA, [], [], NLS, _), Res).


/* get_degre_sommet_nom(+D, +LS, +LA, -Res)
D : entier tel que deg(S) >= D, pour tout S de LS
LS : liste des sommets de départ
LA : liste des aretes de départ
Res : liste de tous les noms des sommets qui vérifient l'inegalité avec le degré
Test
get_degre_sommet_nom(6, [sommet(a,[rock,folk,jazz]),sommet(b,[rock,folk,blues,jazz]),sommet(c,[rock,folk,jazz]),sommet(d,[rock,folk,jazz]),sommet(e,[rock,folk,blues]),sommet(f,[folk,blues]),sommet(g,[rock,folk,jazz]),sommet(h,[rock,folk]),sommet(i,[folk,blues]),sommet(j,[blues,jazz]),sommet(k,[rock]),sommet(l,[jazz,pop]),sommet(m,[rock,folk]),sommet(n,[rock,folk,pop,blues]),sommet(o,[rock,folk,pop]),sommet(p,[rock,folk,pop,jazz]),sommet(q,[rock,folk,pop]),sommet(r,[rock,folk,pop,blues])], [arete(a,b),arete(a,c),arete(a,d),arete(a,e),arete(a,i),arete(a,j),arete(a,k),arete(a,r),arete(b,c),arete(b,d),arete(c,d),arete(c,g),arete(c,l),arete(c,m),arete(e,f),arete(e,g),arete(e,h),arete(f,g),arete(f,h),arete(g,h),arete(h,j),arete(i,j),arete(i,k),arete(i,p),arete(j,k),arete(k,p),arete(l,m),arete(l,n),arete(m,n),arete(n,o),arete(n,p),arete(n,q),arete(n,r),arete(o,p),arete(o,q),arete(o,r),arete(p,q),arete(p,r),arete(q,r)], Res), writeln(''), writeln(Res). */
get_degre_sommet_nom(D, LS, LA, Res) :-
    findall(LN, degre_sommet(D, LS, LA, [], [], _, LN), Res).


/* get_degre(+D, +LS, +LA, -Res)
D : entier tel que deg(S) >= D, pour tout S de LS
LS : liste des sommets de départ
LA : liste des aretes de départ
Res : liste de tous les sommets qui vérifient l'inegalité avec le degré une fois le point fixe atteint
Test
get_degre(4, [sommet(a,[rock,folk,jazz]),sommet(b,[rock,folk,blues,jazz]),sommet(c,[rock,folk,jazz]),sommet(d,[rock,folk,jazz]),sommet(e,[rock,folk,blues]),sommet(f,[folk,blues]),sommet(g,[rock,folk,jazz]),sommet(h,[rock,folk]),sommet(i,[folk,blues]),sommet(j,[blues,jazz]),sommet(k,[rock]),sommet(l,[jazz,pop]),sommet(m,[rock,folk]),sommet(n,[rock,folk,pop,blues]),sommet(o,[rock,folk,pop]),sommet(p,[rock,folk,pop,jazz]),sommet(q,[rock,folk,pop]),sommet(r,[rock,folk,pop,blues])], [arete(a,b),arete(a,c),arete(a,d),arete(a,e),arete(a,i),arete(a,j),arete(a,k),arete(a,r),arete(b,c),arete(b,d),arete(c,d),arete(c,g),arete(c,l),arete(c,m),arete(e,f),arete(e,g),arete(e,h),arete(f,g),arete(f,h),arete(g,h),arete(h,j),arete(i,j),arete(i,k),arete(i,p),arete(j,k),arete(k,p),arete(l,m),arete(l,n),arete(m,n),arete(n,o),arete(n,p),arete(n,q),arete(n,r),arete(o,p),arete(o,q),arete(o,r),arete(p,q),arete(p,r),arete(q,r)], Res), writeln(''), writeln(Res).
Remarque : cut vert car la réponse est donnée sans avoir besoin du backtrack */
get_degre(0, LS, LA, Res) :-
    Res = att_graph(LS, LA), !.

get_degre(D, LS, LA, Res) :-
    get_degre_sommet(D, LS, LA, NLS),
    get_degre_sommet_nom(D, LS, LA, Nom), get_liste_arete(Nom, LA, NLA),
    (length(LS, X), length(NLS, NX), X > NX) -> get_degre(D, NLS, NLA, Res) ;
    get_degre_sommet(D, LS, LA, NLS),
    get_degre_sommet_nom(D, LS, LA, Nom), get_liste_arete(Nom, LA, NLA),
    get_degre(0, NLS, NLA, Res).
