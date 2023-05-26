/** PARTE 1 **/

/* a) */
SELECT matr, acorso FROM S WHERE citta = 'MO' ORDER BY acorso;

/* b) */
SELECT matr, cc, voto*2 from E WHERE cc = 'C1' ORDER BY voto DESC, matr;

/** PARTE 2 **/

/* a) */
SELECT COUNT(*) FROM S;

/* b) */
SELECT COUNT(DISTINCT matr) FROM E;

/* c) */
SELECT SUM(voto)/count(voto) FROM E WHERE matr='M2';

/** PARTE 3 **/

/* a) */
SELECT matr, max(voto), min(voto) FROM E WHERE cc != 'C2' GROUP BY matr;

/* b) */
SELECT snome, s.matr, max(voto), min(voto) FROM E, S WHERE e.matr = s.matr GROUP BY s.matr;

/* c) */
SELECT c.cc, c.cnome, count(*) FROM c NATURAL JOIN e GROUP BY c.cc;

/* d) */
SELECT voto, count(*) FROM e WHERE voto BETWEEN 22 and 28 GROUP BY voto;

/* e) */
SELECT cc, avg(voto) FROM e GROUP BY cc HAVING COUNT(matr) > 2;

/* f) */
SELECT DISTINCT matr FROM e GROUP BY matr, voto HAVING count(voto) >= 2;
