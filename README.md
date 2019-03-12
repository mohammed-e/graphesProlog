# graphesProlog

-- Auteur --<br />
Mohammed EL KHAIRA<br />
2018<br />
<br />
Programme de manipulation de graphes étiquetés non orientés avec SWI-Prolog :<br />
- entrer des requêtes sous forme de motifs puis construction des sous-graphes associés,<br />
- construction des abstractions de ces sous-graphes, associées à différentes propriétés d’abstraction (degré et étoile).<br />
<br />
-- Fichier à charger dans swipl --<br />
[final].<br />
<br />
-- Tests --<br />
test(1, 'mougel_bis.dot', 'test1.dot').<br />
test(2, 'mougel_bis.dot', 'test2.dot').<br />
test('s50_an1_redDevoir.dot', 'test4.dot', [tobacco_occasional_regular], deg(2)).<br />
test('s50_an1_redDevoir.dot', 'test5.dot', [tobacco_Non], star(7)).<br />
<br />
-- Commande pour générer un graphe à partir d'un fichier dot --<br />
sfdp -Tpdf test.dot > test.pdf<br />
<br />
Le [rapport](rapport.pdf) vous fournira plus explications sur ce projet.
