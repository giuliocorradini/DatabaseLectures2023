-- creazione tabelle del database:
CREATE TABLE MAGAZZINO
	(   COD_PROD        	NUMERIC(3) NOT NULL,
	    QTA_DISP           	NUMERIC(5),
	    QTA_RIORD          	NUMERIC(5),
	    PRIMARY KEY (COD_PROD)
	);

CREATE TABLE RIORDINO
	(   COD_PROD           	NUMERIC(3) NOT NULL,
	    DATA               	DATE,
	    QTA_ORD            	NUMERIC(5),
	    PRIMARY KEY (COD_PROD),
	    FOREIGN KEY (COD_PROD) REFERENCES MAGAZZINO (COD_PROD)
	);

---- tuple inserite nella tabella magazzino:
INSERT INTO MAGAZZINO VALUES (1,150,100);
INSERT INTO MAGAZZINO VALUES (3,130,80);
INSERT INTO MAGAZZINO VALUES (5,500,150);
INSERT INTO MAGAZZINO VALUES (4,170,50);


-- Esercizio 1
CREATE FUNCTION prelievo (COD INTEGER, QTA INTEGER) RETURNS INTEGER AS $$
	DECLARE
		new_quant INTEGER;
	BEGIN
		UPDATE magazzino
	    SET qta_disp = qta_disp - QTA
		WHERE COD_PROD = COD;

		new_quant = (select qta_disp from magazzino where cod_prod = cod);

		RETURN new_quant;
	END;
$$ LANGUAGE 'plpgsql';
drop function prelievo;

SELECT prelievo(4, 50);

-- Esercizio 2
CREATE FUNCTION riordino() RETURNS trigger AS $$
	BEGIN
		IF NEW.QTA_DISP < 0 THEN
			raise exception 'Non puoi prelevare più di quanto disponibile';
		end if;

		insert into riordino values(new.COD_PROD, current_date, 100);

	    RETURN NEW;
	END;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER GESTIONE_RIORDINO
    AFTER UPDATE ON MAGAZZINO
    FOR EACH ROW
    WHEN (NEW.QTA_DISP < NEW.QTA_RIORD)
    EXECUTE PROCEDURE riordino();

drop function riordino cascade;

-- Esercizio 3

SELECT prelievo(1, 70);
SELECT prelievo(3, 300);
SELECT * FROM RIORDINO;

-- Esercizio 4

CREATE FUNCTION arrivo_ordine(PROD INTEGER) RETURNS INTEGER AS $$
    DECLARE
        qta_riordinata INTEGER;
	BEGIN
		if (SELECT DISTINCT count(COD_PROD) FROM RIORDINO WHERE COD_PROD = PROD) = 0 then
			raise exception 'Il prodotto non è nei riordini';
		end if;

		SELECT qta_ord INTO qta_riordinata FROM riordino WHERE COD_PROD = PROD;

		UPDATE MAGAZZINO
        	SET QTA_DISP = QTA_DISP + qta_riordinata
        	WHERE COD_PROD = PROD;

		DELETE FROM RIORDINO
        	WHERE COD_PROD = PROD;

		return (SELECT QTA_DISP FROM MAGAZZINO WHERE COD_PROD = PROD);
	end;
$$ LANGUAGE 'plpgsql';
drop function arrivo_ordine;

-- Esercizio 5

SELECT arrivo_ordine(1);
SELECT arrivo_ordine(4);
SELECT arrivo_ordine(1);
