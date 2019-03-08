/* write_sommet(+Stream, +NNS)
Stream : variable stockant l'identifiant du fichier ouvert
NNS : liste des sommet à écrire dans le fichier ouvert */
write_sommet(_, []).

write_sommet(Stream, NNS) :-
    NNS = [S|LS],
    S = sommet(Nom, Motif),
    write(Stream, "\t"), write(Stream, Nom), write(Stream, " [label=\""),
    write(Stream, Nom), write(Stream, " "), write(Stream, Motif), writeln(Stream, "\"];"),
    write_sommet(Stream, LS).


/* write_arete(+Stream, +NNA)
Stream : variable stockant l'identifiant du fichier ouvert
NNA : liste des aretes à écrire dans le fichier ouvert */
write_arete(_, []).

write_arete(Stream, NNA) :-
    NNA = [A|LA],
    A = arete(AG, AD),
    write(Stream, "\t"), write(Stream, AG), write(Stream, " -- "),
    write(Stream, AD), writeln(Stream, ";"),
    write_arete(Stream, LA).



/* write_dot_file(+NomOut, +NNG)
NomOut : variable stockant l'identifiant du fichier créé pour stocker le graphe
NNG : graphe à écrire dans le fichier identifié par NomOut
Test
write_dot_file('resultat.dot', att_graph([sommet(a,[rock,folk,jazz]),sommet(b,[rock,folk,blues,jazz]),sommet(c,[rock,folk,jazz]),sommet(d,[rock,folk,jazz]),sommet(e,[rock,folk,blues]),sommet(g,[rock,folk,jazz]),sommet(h,[rock,folk]),sommet(k,[rock]),sommet(m,[rock,folk]),sommet(n,[rock,folk,pop,blues]),sommet(o,[rock,folk,pop]),sommet(p,[rock,folk,pop,jazz]),sommet(q,[rock,folk,pop]),sommet(r,[rock,folk,pop,blues]),[]],[arete(a,b),arete(a,c),arete(a,d),arete(a,e),arete(a,k),arete(a,r),arete(b,c),arete(b,d),arete(c,d),arete(c,g),arete(c,m),arete(e,g),arete(e,h),arete(g,h),arete(k,p),arete(m,n),arete(n,o),arete(n,p),arete(n,q),arete(n,r),arete(o,p),arete(o,q),arete(o,r),arete(p,q),arete(p,r),arete(q,r)])).
*/

write_dot_file(NomOut, NNG) :-
    open(NomOut, write, Stream),
    writeln(Stream, "Graph {"),
    writeln(Stream, "\tlabelloc=top;"),
    writeln(Stream, "\tfontsize=18;"),

    /* écriture du titre du graphe récupéré dans la BDD */
    listeMotifs(LMtmp),
    nth0(1, LMtmp, LMtmp2),
    split_string(LMtmp2, ",", " []]\t\s\n\"", LMtmp3),
    LMtmp3 = [Titre|LM],
    write(Stream, "\tlabel=\""), write(Stream, Titre), write(Stream, ", "),
    write(Stream, LM), writeln(Stream, "\";"),

    NNG = att_graph(NNStmp, NNAtmp),
    subtract(NNStmp, [[]], NNS), subtract(NNAtmp, [[]], NNA),
    write_sommet(Stream, NNS),
    write_arete(Stream, NNA),

    write(Stream, "}"),
    close(Stream).
