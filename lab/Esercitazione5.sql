/* PARTE 1 */

/* seleziona gli studenti che hanno sostenuto tutti gli esami relativi ai corsi del docente D1 */
/* seleziona gli studenti per i quali non esiste alcun corso del docente D1 che non sia contenuto negli esami sostenuti */

select * from s where not exists (
    select * from c where cd = 'D1' and not exists (
        select cc from e where e.matr = s.matr and e.cc = c.cc
        )
);

select * from s where not exists (
    select * from c where cd = 'D1' and cc not in (
        select cc from e where e.matr = s.matr
        )
);

/* studenti che hanno sostenuto tutti gli esami dello studente M7 */
/* studenti per cui non esiste alcun esame dello studente M7 che non sia contenuto negli esami sostenuti */
select * from s as sx where not exists (
    select * from e as e_s where cc not in (
        select cc from e as e_m7 where e_m7.matr = 'M7'
        )
)

select * from e as e_s where e_s.cc in (
        select cc from e as e_m7 where e_m7.matr = 'M7'
        )

/* matricole degli studenti che hanno sostenuto un esame insieme (stesso corso, stessa data) alla matricola M2 */
select matr from s where exists (
    select * from e where e.matr = s.matr and exists (
        select * from e as ed where e.cc = ed.cc and e.data = ed.data and ed.matr = 'M7'
    )
)

/* per ogni studente il voto massimo ottenuto, escludendo gli esami con voto pari a 33 e considerando
   solo gli studenti con più di 1 esame; ordinare il risultato per voti massimi crescenti
 */
select matr, max(voto) from e where voto < 33 group by matr having count(*) > 1
order by max(voto);

/* selezionare per ogni docente il corso per il quale sono stati sostenuti il maggior numero di esami */
select cd, cc from c group by cd having cc = (
    select max(cc) from e where e.cd = c.cd
    );

/* corsi e numero di esami sostenuti */
select cc, count(matr) from e group by cc;

/* codice docente, corso e numero di esami sostenuti */


select cd, cc, part from (
    select cd, e.cc, count(matr) as part
                           from e join c on e.cc = c.cc
                           group by cd, e.cc
                           ) as sub group by cd having part = max(part);