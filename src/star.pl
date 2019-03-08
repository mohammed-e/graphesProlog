/* voisin_star(+K, +S, +LA, +AllA, ?Voisin, -Res)
K : entier tel que deg(V) >= K, pour tout V de Voisin(S)
S : sommet dont on veut la liste des voisins qui ont un degré >= K
LA : liste des aretes de départ qui se vide durant l'exécution
AllA : liste des aretes de départ qui reste inchangée durant l'exécution
Voisin = [] : accumulateur stockant les voisins désirés
Res : permet d'obtenir tous les voisins désirés par backtrack
*/
voisin_star(_, _, [], _, Voisin, Res) :-
    Res = Voisin.

voisin_star(K, S, [A|LA], AllA, Voisin, Res) :-
    A = arete(X, Y),
    (S == X), degre(Y, AllA, 0, D), D >= K -> append(Voisin, Y, NVoisin),
    voisin_star(K, S, LA, AllA, NVoisin, Res).

voisin_star(K, S, [A|LA], AllA, Voisin, Res) :-
    A = arete(X, Y),
    (S == Y), degre(X, AllA, 0, D), D >= K -> append(Voisin, X, NVoisin),
    voisin_star(K, S, LA, AllA, NVoisin, Res).

voisin_star(K, S, [_|LA], AllA, Voisin, Res) :-
    voisin_star(K, S, LA, AllA, Voisin, Res).


/* get_voisin_star(+K, +S, +LA, -LV)
K : entier tel que deg(V) >= K, pour tout V de Voisin(S)
S : sommet dont on veut la liste des voisins qui ont un degré >= K
LA : liste des aretes de départ
LV : liste des voisins de S dont le degré est >= K
Test
get_voisin_star(5, q, [arete(a,b),arete(a,c),arete(a,d),arete(a,e),arete(a,i),arete(a,j),arete(a,k),arete(a,r),arete(b,c),arete(b,d),arete(c,d),arete(c,g),arete(c,l),arete(c,m),arete(e,f),arete(e,g),arete(e,h),arete(f,g),arete(f,h),arete(g,h),arete(h,j),arete(i,j),arete(i,k),arete(i,p),arete(j,k),arete(k,p),arete(l,m),arete(l,n),arete(m,n),arete(n,o),arete(n,p),arete(n,q),arete(n,r),arete(o,p),arete(o,q),arete(o,r),arete(p,q),arete(p,r),arete(q,r)], LV). */
get_voisin_star(K, S, LA, LV) :-
    findall(Res, voisin_star(K, S, LA, LA, [], Res), LV).


/* is_star(+K, +S, +LA)
K : entier tel que deg(S) ou deg(V) >= K, pour tout V de Voisin(S)
S : sommet dont on veut savoir s'il fait partie d'une étoile
LA : liste des aretes de départ
Test
is_star(5, f, [arete(a,b),arete(a,c),arete(a,d),arete(a,e),arete(a,i),arete(a,j),arete(a,k),arete(a,r),arete(b,c),arete(b,d),arete(c,d),arete(c,g),arete(c,l),arete(c,m),arete(e,f),arete(e,g),arete(e,h),arete(f,g),arete(f,h),arete(g,h),arete(h,j),arete(i,j),arete(i,k),arete(i,p),arete(j,k),arete(k,p),arete(l,m),arete(l,n),arete(m,n),arete(n,o),arete(n,p),arete(n,q),arete(n,r),arete(o,p),arete(o,q),arete(o,r),arete(p,q),arete(p,r),arete(q,r)]). */
is_star(K, S, LA) :-
    degre(S, LA, 0, D), D >= K.

is_star(K, S, LA) :-
    get_voisin_star(K, S, LA, LV), length(LV, N), N > 1. % N > 1 car length([[]]) = 1

/* star_sommet(+K, +LS, +LA, +LStar, +LStarNom, -Res, -ResNom)
K : entier tel que deg(S) ou deg(V) >= K, pour tout S de LS et V de Voisin(S)
LS : liste des sommets de départ
LA : liste des aretes de départ
LStar = [] : accumulateur stockant les nouveaux sommets obtenus grâce à l'étoile
LStarNom = [] : accumulateur stockant les noms des nouveaux sommets obtenus grâce à l'étoile
Res : permet d'obtenir tous les sommets désirés par backtrack
ResNom : permet d'obtenir les noms de tous les sommets désirés par backtrack
Fonction intermédiaire utilisée par get_star_sommet et get_star_sommet_nom */
star_sommet(_, [], _, LStar, LStarNom, Res, ResNom) :-
    Res = LStar, ResNom = LStarNom.

star_sommet(K, [S|LS], LA, LStar, LStarNom, Res, ResNom) :-
    S = sommet(Nom, _),
    (is_star(K, Nom, LA) -> append(LStar, S, NLStar), append(LStarNom, Nom, NLStarNom), star_sommet(K, LS, LA, NLStar, NLStarNom, Res, ResNom)) ;
    star_sommet(K, LS, LA, LStar, LStarNom, Res, ResNom).


/* get_star_sommet(+K, +LS, +LA, -LStar)
K : entier tel que deg(S) ou deg(V) >= K, pour tout S de LS et V de Voisin(S)
LS : liste des sommets de départ
LA : liste des aretes de départ
LStar : liste de tous les sommets qui vérifient les inegalités pour l'étoile
Test
get_star_sommet(5, [sommet(a,[rock,folk,jazz]),sommet(b,[rock,folk,blues,jazz]),sommet(c,[rock,folk,jazz]),sommet(d,[rock,folk,jazz]),sommet(e,[rock,folk,blues]),sommet(f,[folk,blues]),sommet(g,[rock,folk,jazz]),sommet(h,[rock,folk]),sommet(i,[folk,blues]),sommet(j,[blues,jazz]),sommet(k,[rock]),sommet(l,[jazz,pop]),sommet(m,[rock,folk]),sommet(n,[rock,folk,pop,blues]),sommet(o,[rock,folk,pop]),sommet(p,[rock,folk,pop,jazz]),sommet(q,[rock,folk,pop]),sommet(r,[rock,folk,pop,blues])], [arete(a,b),arete(a,c),arete(a,d),arete(a,e),arete(a,i),arete(a,j),arete(a,k),arete(a,r),arete(b,c),arete(b,d),arete(c,d),arete(c,g),arete(c,l),arete(c,m),arete(e,f),arete(e,g),arete(e,h),arete(f,g),arete(f,h),arete(g,h),arete(h,j),arete(i,j),arete(i,k),arete(i,p),arete(j,k),arete(k,p),arete(l,m),arete(l,n),arete(m,n),arete(n,o),arete(n,p),arete(n,q),arete(n,r),arete(o,p),arete(o,q),arete(o,r),arete(p,q),arete(p,r),arete(q,r)], Res), writeln(''), writeln(Res). */
get_star_sommet(K, LS, LA, LStar) :-
    findall(Res, star_sommet(K, LS, LA, [], [], Res, _), LStar).


/* get_star_sommet_nom(+K, +LS, +LA, -LStar)
K : entier tel que deg(S) ou deg(V) >= K, pour tout S de LS et V de Voisin(S)
LS : liste des sommets de départ
LA : liste des aretes de départ
LStar : liste de tous les noms des sommets qui vérifient les inegalités pour l'étoile
Test
get_star_sommet_nom(5, [sommet(a,[rock,folk,jazz]),sommet(b,[rock,folk,blues,jazz]),sommet(c,[rock,folk,jazz]),sommet(d,[rock,folk,jazz]),sommet(e,[rock,folk,blues]),sommet(f,[folk,blues]),sommet(g,[rock,folk,jazz]),sommet(h,[rock,folk]),sommet(i,[folk,blues]),sommet(j,[blues,jazz]),sommet(k,[rock]),sommet(l,[jazz,pop]),sommet(m,[rock,folk]),sommet(n,[rock,folk,pop,blues]),sommet(o,[rock,folk,pop]),sommet(p,[rock,folk,pop,jazz]),sommet(q,[rock,folk,pop]),sommet(r,[rock,folk,pop,blues])], [arete(a,b),arete(a,c),arete(a,d),arete(a,e),arete(a,i),arete(a,j),arete(a,k),arete(a,r),arete(b,c),arete(b,d),arete(c,d),arete(c,g),arete(c,l),arete(c,m),arete(e,f),arete(e,g),arete(e,h),arete(f,g),arete(f,h),arete(g,h),arete(h,j),arete(i,j),arete(i,k),arete(i,p),arete(j,k),arete(k,p),arete(l,m),arete(l,n),arete(m,n),arete(n,o),arete(n,p),arete(n,q),arete(n,r),arete(o,p),arete(o,q),arete(o,r),arete(p,q),arete(p,r),arete(q,r)], Res), writeln(''), writeln(Res). */
get_star_sommet_nom(K, LS, LA, LStarNom) :-
    findall(ResNom, star_sommet(K, LS, LA, [], [], _, ResNom), LStarNom).



/* get_star(+K, +LS, +LA, -Res)
K : entier tel que deg(S) ou deg(V) >= K, pour tout S de LS et V de Voisin(S)
LS : liste des sommets de départ
LA : liste des aretes de départ
Res : liste de tous les noms des sommets qui vérifient les inegalités pour l'étoile une fois le point fixe atteint
Test
get_star(5, [sommet(a,[rock,folk,jazz]),sommet(b,[rock,folk,blues,jazz]),sommet(c,[rock,folk,jazz]),sommet(d,[rock,folk,jazz]),sommet(e,[rock,folk,blues]),sommet(f,[folk,blues]),sommet(g,[rock,folk,jazz]),sommet(h,[rock,folk]),sommet(i,[folk,blues]),sommet(j,[blues,jazz]),sommet(k,[rock]),sommet(l,[jazz,pop]),sommet(m,[rock,folk]),sommet(n,[rock,folk,pop,blues]),sommet(o,[rock,folk,pop]),sommet(p,[rock,folk,pop,jazz]),sommet(q,[rock,folk,pop]),sommet(r,[rock,folk,pop,blues])], [arete(a,b),arete(a,c),arete(a,d),arete(a,e),arete(a,i),arete(a,j),arete(a,k),arete(a,r),arete(b,c),arete(b,d),arete(c,d),arete(c,g),arete(c,l),arete(c,m),arete(e,f),arete(e,g),arete(e,h),arete(f,g),arete(f,h),arete(g,h),arete(h,j),arete(i,j),arete(i,k),arete(i,p),arete(j,k),arete(k,p),arete(l,m),arete(l,n),arete(m,n),arete(n,o),arete(n,p),arete(n,q),arete(n,r),arete(o,p),arete(o,q),arete(o,r),arete(p,q),arete(p,r),arete(q,r)], Res), writeln(''), writeln(Res).
Remarque : cut vert car la réponse est donnée sans avoir besoin du backtrack */
get_star(0, LS, LA, Res) :-
    Res = att_graph(LS, LA), !.

get_star(K, LS, LA, Res) :-
    get_star_sommet(K, LS, LA, NLS),
    get_star_sommet_nom(K, LS, LA, Nom), get_liste_arete(Nom, LA, NLA),
    (length(LS, X), length(NLS, NX), X > NX) -> get_star(K, NLS, NLA, Res) ;
    get_star_sommet(K, LS, LA, NLS),
    get_star_sommet_nom(K, LS, LA, Nom), get_liste_arete(Nom, LA, NLA),
    get_star(0, NLS, NLA, Res).
