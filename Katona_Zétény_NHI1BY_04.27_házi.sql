-- Új tábla létrehozása maszkolt mezőkkel
CREATE TABLE webshop_maszk (
    LOGIN NVARCHAR(50),
    EMAIL NVARCHAR(100) MASKED WITH (FUNCTION = 'email()'),
    NEV NVARCHAR(100) MASKED WITH (FUNCTION = 'partial(2,"***************",0)'),
    SZULEV INT MASKED WITH (FUNCTION = 'random(1950, 2005)'),
    NEM CHAR(1),
    CIM NVARCHAR(200)
);

-- Adatok másolása az eredeti webshop táblából
INSERT INTO webshop_maszk (LOGIN, EMAIL, NEV, SZULEV, NEM, CIM)
SELECT LOGIN, EMAIL, NEV, SZULEV, NEM, CIM
FROM webshop;

-- Felhasználó létrehozása (aki csak maszkolt adatokat lát)
CREATE LOGIN webshop_user WITH PASSWORD = 'StrongPassword123!';
CREATE USER webshop_user FOR LOGIN webshop_user;
GRANT SELECT ON webshop_maszk TO webshop_user;

-- Lekérdezés példa (amit webshop_user láthat)
EXECUTE AS USER = 'webshop_user';
SELECT * FROM webshop_maszk;
REVERT;
