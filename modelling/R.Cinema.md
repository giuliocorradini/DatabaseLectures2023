# Modellazione R di sale cinematografiche

CAST(**CF-ATTORE,TITOLO**)
    FK: CF-ATTORE REFERENCES ATTORE
    FK: TITOLO REFERENCES FILM

% un attributo multiplo dà sempre luogo a una nuova relazione
PERSONAGGI(**CF-ATTORE,TITOLO,PERSONAGGIO**)
    FK: CF-ATTORE,TITOLO REFERENCES CAST

PREMI(**TITOLO,NOME,ANNO**)
    FK: TITOLO REFERENCES FILM

SALA(**NOME,CITTA**,NPOSTI)

PROGRAMMA_SETTIMANALE(**NOME,CITTA,SETTIMANA**,TITOLO)
    FK: NOME,CITTA REFERENCES SALA
    FK: TITOLO REFERENCES FILM
    AK: TITOLO

FILM(**TITOLO**,GENERE,CF-REGISTA)
    FK: CF-REGISTA REFERENCES REGISTA

PERSONA(**CF**,NOME)

REGISTA(**CF**,ETA)
    FK: CF REFERENCES PERSONA

ATTORE(**CF**,NAZIONALITA)
    FK: CF REFERENCES PERSONA