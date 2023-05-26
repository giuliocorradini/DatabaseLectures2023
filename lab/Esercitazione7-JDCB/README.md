# JDBC

JDBC is a SQL engine provided in the standard library of Java.

## 1. Populate database

Connect to your database using an external tool and create a new table `studenti`.

```sql
pgcli postgres

> create database studenti;
```

## 2. Run the example

Launch main in `MainClass.java` using an IDE, or Java Extension for VSCode.

## 3. Monitor database

You may now monitor the outcome of the progam, to check if data was written etc.

```sql
pgcli studenti;

> select * from studenti;
```
