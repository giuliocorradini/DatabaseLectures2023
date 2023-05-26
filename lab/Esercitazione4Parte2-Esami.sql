/* Esercitazione 4 */
/* Parte 2: database Esami */

/* 2.a */
select citta from s except select citta from d;

select citta from s where citta not in (select citta from d);

/* 2.b */
select snome from s where matr in (
    select matr from e where cc = 'C1'
);

select snome from s, e where s.matr = e.matr and e.cc = 'C1';

/* 2.c */
select * from s where acorso = (select min(acorso) from s);

/* 2.d */
select snome from s where matr not in (
    select matr from e where cc = 'C1'
);

select snome from s where matr != ALL (
    select matr from e where cc = 'C1'
);

select snome from s where not exists (
    select * from e where cc = 'C1' and e.matr = s.matr
);

select snome from s except select snome from s natural join e where cc = 'C1';
/* fare except è l'unico modo per invertire il risultato? */

/* 2.e: studenti che hanno sostenuto tutti gli esami relativi a corsi del docente D1 */
select * from s where matr in (
    select matr from e where cc in (
        select cc from c where cd = 'D1'
    ) group by matr
      having count(cc) = (
          select count(cc) from c where cd = 'D1'
      )
);

