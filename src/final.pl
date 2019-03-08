:-include('dotToList.pl').
:-include('motif.pl').
:-include('degre.pl').
:-include('star.pl').
:-include('listToDot.pl').
:-include('test.pl').



/* graphe_induit(+G, +Motif, -NG)
G : graphe de départ
Motif : liste représentant le motif à conserver
NG : le nouveau graphe respectant le motif
Test
graphe_induit(att_graph([sommet(a,[rock,folk,jazz]),sommet(b,[rock,folk,blues,jazz]),sommet(c,[rock,folk,jazz]),sommet(d,[rock,folk,jazz]),sommet(e,[rock,folk,blues]),sommet(f,[folk,blues]),sommet(g,[rock,folk,jazz]),sommet(h,[rock,folk]),sommet(i,[folk,blues]),sommet(j,[blues,jazz]),sommet(k,[rock]),sommet(l,[jazz,pop]),sommet(m,[rock,folk]),sommet(n,[rock,folk,pop,blues]),sommet(o,[rock,folk,pop]),sommet(p,[rock,folk,pop,jazz]),sommet(q,[rock,folk,pop]),sommet(r,[rock,folk,pop,blues])],[arete(a,b),arete(a,c),arete(a,d),arete(a,e),arete(a,i),arete(a,j),arete(a,k),arete(a,r),arete(b,c),arete(b,d),arete(c,d),arete(c,g),arete(c,l),arete(c,m),arete(e,f),arete(e,g),arete(e,h),arete(f,g),arete(f,h),arete(g,h),arete(h,j),arete(i,j),arete(i,k),arete(i,p),arete(j,k),arete(k,p),arete(l,m),arete(l,n),arete(m,n),arete(n,o),arete(n,p),arete(n,q),arete(n,r),arete(o,p),arete(o,q),arete(o,r),arete(p,q),arete(p,r),arete(q,r)]), [rock, blues], NG), writeln(''), writeln(NG). */
graphe_induit(G, Motif, NG) :-
    G = att_graph(S, A),
    get_motif_sommet(Motif, S, NS),
    get_motif_sommet_nom(Motif, S, Nom), get_liste_arete(Nom, A, NA),
    NG = att_graph(NS, NA).


/* point_fixe(+NG, +Prop, -NNG)
NG : graphe de départ
Prop : abstraction à réaliser
NNG : le nouveau graphe respectant l'abstraction
Test
point_fixe(att_graph([sommet(a,[rock,folk,jazz]),sommet(b,[rock,folk,blues,jazz]),sommet(c,[rock,folk,jazz]),sommet(d,[rock,folk,jazz]),sommet(e,[rock,folk,blues]),sommet(f,[folk,blues]),sommet(g,[rock,folk,jazz]),sommet(h,[rock,folk]),sommet(i,[folk,blues]),sommet(j,[blues,jazz]),sommet(k,[rock]),sommet(l,[jazz,pop]),sommet(m,[rock,folk]),sommet(n,[rock,folk,pop,blues]),sommet(o,[rock,folk,pop]),sommet(p,[rock,folk,pop,jazz]),sommet(q,[rock,folk,pop]),sommet(r,[rock,folk,pop,blues])],[arete(a,b),arete(a,c),arete(a,d),arete(a,e),arete(a,i),arete(a,j),arete(a,k),arete(a,r),arete(b,c),arete(b,d),arete(c,d),arete(c,g),arete(c,l),arete(c,m),arete(e,f),arete(e,g),arete(e,h),arete(f,g),arete(f,h),arete(g,h),arete(h,j),arete(i,j),arete(i,k),arete(i,p),arete(j,k),arete(k,p),arete(l,m),arete(l,n),arete(m,n),arete(n,o),arete(n,p),arete(n,q),arete(n,r),arete(o,p),arete(o,q),arete(o,r),arete(p,q),arete(p,r),arete(q,r)]), deg(6), NNG), writeln(''), writeln(NNG). */
point_fixe(NG, Prop, NNG) :-
    NG = att_graph(NS, NA),
    ((Prop = deg(N) -> get_degre(N, NS, NA, Res)) ;
    (Prop = star(N) -> get_star(N, NS, NA, Res))),
    NNG = Res.



/*
Test exemple énoncé devoir :
graphe_induit(att_graph([sommet(a, [rock]), sommet(b, [rock]), sommet(c, [rock]), sommet(d, [rock]), sommet(e, [blues]), sommet(f, [rock])], [arete(a,b), arete(a,c), arete(a,d), arete(a,e), arete(b,c), arete(d,e), arete(d,f), arete(e,f)]), [rock], NG), point_fixe(NG, deg(2), NNG).
*/
